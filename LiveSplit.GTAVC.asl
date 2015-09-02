state("gta-vc")
{
	byte gameVersion : 0x208578;  // Used to detect the version; same for each version obviously.
}

// These need to exist so they are actually found as versions by the code below.
state("gta-vc", "1.0") {}
state("gta-vc", "1.1") {}
state("gta-vc", "steam") {}
state("gta-vc", "jp") {}

init
{
	// Populate the mission memory addresses list, but only once.
	if(!((IDictionary<String, object>)vars).ContainsKey("missionAddresses"))
	{
		// Makes a list of all the memory addresses for each mission, in order.
		vars.missionAddresses = new List<int>();
		
		// Adds all mission memory addresses to the list above.
		// If you don't want to autosplit for certain missions, just put a // in front of them.
		vars.missionAddresses.Add(0x421600);  // The Party
		vars.missionAddresses.Add(0x421604);  // Back Alley Brawl
		vars.missionAddresses.Add(0x421608);  // Jury Fury
		vars.missionAddresses.Add(0x42160C);  // Riot
		vars.missionAddresses.Add(0x421614);  // Treacherous Swine
		vars.missionAddresses.Add(0x421618);  // Mall Shootout
		vars.missionAddresses.Add(0x42161C);  // Guardian Angels
		vars.missionAddresses.Add(0x42162C);  // The Chase
		vars.missionAddresses.Add(0x421630);  // Phnom Penh '86
		vars.missionAddresses.Add(0x421634);  // The Fastest Boat
		vars.missionAddresses.Add(0x421638);  // Supply and Demand
		vars.missionAddresses.Add(0x421620);  // Sir Yes Sir
		vars.missionAddresses.Add(0x421648);  // Death Row
		vars.missionAddresses.Add(0x42163C);  // Rub Out
		vars.missionAddresses.Add(0x4216A8);  // Shakedown
		vars.missionAddresses.Add(0x4216AC);  // Bar Brawl
		vars.missionAddresses.Add(0x4216B0);  // Cop Land
		vars.missionAddresses.Add(0x4216C0);  // Spilling the Beans
		vars.missionAddresses.Add(0x4216C4);  // Hit the Courier
		vars.missionAddresses.Add(0x4216B4);  // Cap the Collector
	}
	
	// Detects current game version.
	switch ((int)current.gameVersion)
	{
		case 93:
			version = "1.0";
			vars.offset = 0;
			break;
		case 129:
			version = "1.1";
			vars.offset = 8;
			break;
		case 91:
			version = "steam";
			vars.offset = -0xFF8;
			break;
		case 68:
			version = "jp";
			vars.offset = -0x2FF8;
			break;
	}
	
	// Makes a copy of the mission memory addresses list (so it can be edited and then restored on reset).
	vars.missionAddressesCurrent = new List<int>(vars.missionAddresses);
	vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));
	
	// Used to ignore the check for a single frame (not sure if actually needed but leaving in anyway).
	vars.checkCurrentMission = false;
	
	// Used to know when the player starts a new game.
	vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x5B5F10+vars.offset));
	
	// Last split stuff on Keep Your Friends Close, not exactly sure what the values represent but they work!
	vars.kyfc1 = new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset));
	vars.kyfc2 = new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset));
	vars.kyfc3 = new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset));
}

update
{
	// unknown version, don't do anything
	if (version == "")
		return;
	
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	
	// Keeping a few extra memory watchers up to date for the current frame.
	vars.gameState.Update(game);
	vars.kyfc1.Update(game);
	vars.kyfc2.Update(game);
	vars.kyfc3.Update(game);
	
	// Japanese game state is shifted by +4 (due to more intro movies) so needs a separate check.
	if (version == "jp")
	{
		// Starting the splits after the initial new game load is done.
		if (vars.gameState.Old == 12 && vars.gameState.Current == 13) {vars.doStart = true;}
		
		// Resetting the splits if needed.
		if (vars.gameState.Old != 12 && vars.gameState.Current == 12) {vars.doReset = true;}
	}
	
	else
	{
		// Starting the splits after the initial new game load is done.
		if (vars.gameState.Old == 8 && vars.gameState.Current == 9) {vars.doStart = true;}
		
		// Resetting the splits if needed.
		if (vars.gameState.Old != 8 && vars.gameState.Current == 8) {vars.doReset = true;}
	}
	
	// All missions (besides the final split).
	if (vars.missionAddressesCurrent.Count != 0)
	{
		vars.currentMissionWatcher.Update(game);
		
		if (vars.checkCurrentMission && vars.currentMissionWatcher.Old == 0 && vars.currentMissionWatcher.Current == 1)
		{
			vars.missionAddressesCurrent.RemoveAt(0);
			if (vars.missionAddressesCurrent.Count != 0) {vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));}
			vars.doSplit = true;
			vars.checkCurrentMission = false;
		}
		
		else {vars.checkCurrentMission = true;}
	}
	
	// Final split (when control is lost on Keep Your Friends Closer).
	else if (vars.kyfc1.Current == 245 && vars.kyfc2.Current > vars.kyfc3.Current) {vars.doSplit = true;}
}

start
{
	if (vars.doStart)
	{
		// Makes a copy of the mission memory addresses list (so it can be edited and then restored on reset).
		vars.missionAddressesCurrent = new List<int>(vars.missionAddresses);
		vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));
		vars.checkCurrentMission = false;
	}
	
	return vars.doStart;
}

reset {return vars.doReset;}
split {return vars.doSplit;}