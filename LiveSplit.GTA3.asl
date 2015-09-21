state("gta3")
{
	// Used to detect the version; each version has a different memory address.
	// The correct memory address will have the value 1407551829.
	int versionCheck10 : 0x5C1E70;     // Version 1.0 NoCD
	int versionCheck11 : 0x5C2130;     // Version 1.1 NoCD
	//int versionCheckSteam : 0x1C6FD0;  // Version 1.1 Steam
}

// These need to exist so they are actually found as versions by the code below.
state("gta3", "1.0") {}
state("gta3", "1.1") {}
state("gta3", "steam") {}

init
{
	// Declaring variables.
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	vars.offset = 0;
	
	// Read category from split file
	vars.category = timer.Run.CategoryName.ToLower();
	
	// Populate the mission memory addresses list, but only once.
	if(!((IDictionary<String, object>)vars).ContainsKey("missionAddresses"))
	{
		// Makes a list of all the memory addresses for each mission, in order.
		vars.missionAddresses = new List<int>();
		
		// make a list of memory addresses here
	}
	
	// Workaround for identifying the Steam version correctly.
	// If the game is started after LiveSplit, the other method doesn't work.
	if (modules.First().ModuleMemorySize == 6197248)
	{
		version = "steam";
		vars.offset = 0;
	}
	
	// Detects current game version if not Steam.
	else {
		if (current.versionCheck10 == 1407551829)
		{
			version = "1.0";
			vars.offset = -0x10140;
		}
		
		else if (current.versionCheck11 == 1407551829)
		{
			version = "1.1";
			vars.offset = -0x10140;
		}
	}
	
	// Makes a copy of the mission memory addresses list (so it can be edited and then restored on reset).
	vars.missionAddressesCurrent = new List<int>(vars.missionAddresses);
	
	if (vars.missionAddressesCurrent.Count != 0)
	{
		vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));
		
		// Used to ignore the check for a single frame (not sure if actually needed but leaving in anyway).
		vars.checkCurrentMission = false;
	}
	
	// Used to know when the player starts a new game.
	//if (version == "jp") {vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x5B2F18));}
	//else {vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x5B5F08+vars.offset));}
	
	// Used to know when the player loads a saved game.
	//vars.loadingCheck = new MemoryWatcher<byte>(new DeepPointer(0x574B74+vars.offset));
	
	// Last split stuff for any% on Keep Your Friends Close, not exactly sure what the values represent but they work!
	/*if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		vars.kyfc1 = new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset));
		vars.kyfc2 = new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset));
		vars.kyfc3 = new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset));
	}*/
}

update
{
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	
	// unknown version, don't do anything
	if (version == "")
		return;
	
	// Keeping a few extra memory watchers up to date for the current frame.
	//vars.gameState.Update(game);
	//vars.loadingCheck.Update(game);
	/*if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		vars.kyfc1.Update(game);
		vars.kyfc2.Update(game);
		vars.kyfc3.Update(game);
	}*/
	
	// Works out the current real time in seconds, so it can be compared to.
	// going to use ~5 seconds for GTA3 just to be safe for SRL races and such, might need to be higher?
	var currentRealTime = timer.CurrentTime.RealTime.ToString();
	var currentRealTimeInSeconds = TimeSpan.Parse(currentRealTime).TotalSeconds;
	
	// Japanese game state is shifted by +4 (due to more intro movies) so needs a separate check.
	/*if (version == "jp")
	{
		// Starting the splits after the initial new game load is done.
		if (vars.gameState.Old == 12 && vars.gameState.Current == 13 && vars.loadingCheck.Current == 1) {vars.doStart = true;}
		
		// Resetting the splits if needed.
		if (vars.gameState.Old == 13 && vars.gameState.Current == 12 && currentRealTimeInSeconds > 5) {vars.doReset = true;}
	}*/
	
	/*else
	{
		// Starting the splits after the initial new game load is done.
		if (vars.gameState.Old == 8 && vars.gameState.Current == 9 && vars.loadingCheck.Current == 1) {vars.doStart = true;}
		
		// Resetting the splits if needed.
		if (vars.gameState.Old == 9 && vars.gameState.Current == 8 && currentRealTimeInSeconds > 5) {vars.doReset = true;}
	}*/
	
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
	
	// Final split for any% (when control is lost on Keep Your Friends Closer). [this is a little bit dirty but should work]
	/*else if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		if (vars.kyfc1.Current == 245 && vars.kyfc2.Current > vars.kyfc3.Current) {vars.doSplit = true;}
	}*/
}

start
{
	if (vars.doStart)
	{
		// Makes a copy of the mission memory addresses list (so it can be edited and then restored on reset).
		vars.missionAddressesCurrent = new List<int>(vars.missionAddresses);
		
		if (vars.missionAddressesCurrent.Count != 0) {
			vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));
			vars.checkCurrentMission = false;
		}
	}
	
	return vars.doStart;
}

reset {return vars.doReset;}
split {return vars.doSplit;}
