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
	vars.skipInitialCutsceneCheck = new MemoryWatcher<int>(new DeepPointer(0x35CC50+vars.offset));
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
	vars.skipInitialCutsceneCheck.Update(game);
	
	// Works out the current real time in seconds, so it can be compared to.
	// going to use ~5 seconds for GTA3 just to be safe for SRL races and such, might need to be higher?
	var currentRealTime = timer.CurrentTime.RealTime.ToString();
	var currentRealTimeInSeconds = TimeSpan.Parse(currentRealTime).TotalSeconds;
	
	// Starting the splits after the initial cutscene skip.
	if (vars.skipInitialCutsceneCheck.Old == 0 && vars.skipInitialCutsceneCheck.Current == 3841) {vars.doStart = true;}
	
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
