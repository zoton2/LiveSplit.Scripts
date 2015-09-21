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
		
		if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
		{
			vars.missionAddresses.Add(0x35B75C);  // Give Me Liberty and Luigi's Girls
			vars.missionAddresses.Add(0x35B76C);  // Don't Spank Ma Bitch Up
			vars.missionAddresses.Add(0x35B770);  // Drive Misty For Me
			vars.missionAddresses.Add(0x35B780);  // Mike Lips Last Lunch
			vars.missionAddresses.Add(0x35B784);  // Farewell 'Chunky' Lee Chong
			vars.missionAddresses.Add(0x35B788);  // Van Heist
			vars.missionAddresses.Add(0x35B78C);  // Cipriani's Chauffeur
			vars.missionAddresses.Add(0x35B79C);  // Taking Out the Laundry
			vars.missionAddresses.Add(0x35B7A0);  // The Pick-Up
			vars.missionAddresses.Add(0x35B7A4);  // Salvatore's Called a Meeting
			vars.missionAddresses.Add(0x35B7B4);  // Chaperone
			vars.missionAddresses.Add(0x35B7B8);  // Cutting the Grass
			vars.missionAddresses.Add(0x35B7A8);  // Triads and Tribulations
			vars.missionAddresses.Add(0x35B7AC);  // Blow Fish
			//vars.missionAddresses.Add(0x35B7BC);  // Bomb Da Base: Act I
			vars.missionAddresses.Add(0x35B7C0);  // Bomb Da Base: Act II
			vars.missionAddresses.Add(0x35B7C4);  // Last Requests
			vars.missionAddresses.Add(0x35B878);  // Sayonara Salvatore
			vars.missionAddresses.Add(0x35B87C);  // Under Surveillance
			vars.missionAddresses.Add(0x35B880);  // Paparazzi Purge
			vars.missionAddresses.Add(0x35B884);  // Payday For Ray
			vars.missionAddresses.Add(0x35B890);  // Silence The Sneak
			vars.missionAddresses.Add(0x35B894);  // Arms Shortage
			vars.missionAddresses.Add(0x35B898);  // Evidence Dash
			vars.missionAddresses.Add(0x35B8C4);  // Liberator
			vars.missionAddresses.Add(0x35B8C8);  // Waka-Gashira Wipeout
			vars.missionAddresses.Add(0x35B8CC);  // A Drop In The Ocean
			vars.missionAddresses.Add(0x35B8FC);  // Grand Theft Aero
			vars.missionAddresses.Add(0x35B910);  // Bait
			vars.missionAddresses.Add(0x35B914);  // Espresso-2-Go!
			vars.missionAddresses.Add(0x35B918);  // S.A.M. + Ransom
			//vars.missionAddresses.Add(0x35B948);  // The Exchange
		}
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
