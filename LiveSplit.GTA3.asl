state("gta3")
{
	// unknown/default version
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
		
		// Adds all mission memory addresses to the list above.
		// If you don't want to autosplit for certain missions, just put a // in front of them.
		// If you don't want to autosplit for ANY missions, commenting them all out works. (but only in Any%)
		// By default autosplitter splits after every mission in Any% category, in All Missions it splits after credits.
		// All unsupported categories will split only after credits.
		// You may want to adjust these settings to your needs.
		
		///////////////////////////// A N Y % /////////////////////////////
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
		}
		
		///////////////////// A L L   M I S S I O N S /////////////////////
		// Mission order may need changing (I think this is Omega's new route).
		// It's important to list missions here in the exact same order you do them during the run.
		// You may want to rearrange this list for your needs.
		// It's recommended to split at least every few missions in case something unexpected happens in the run.
		// Use the "Bling-Bling Scramble" split at your own risk, I need to figure out if it works or not.
		else if (vars.category.Contains("missions"))
		{
			//vars.missionAddresses.Add(0x35B75C);  // Give Me Liberty and Luigi's Girls
			//vars.missionAddresses.Add(0x35B76C);  // Don't Spank Ma Bitch Up
			//vars.missionAddresses.Add(0x35B770);  // Drive Misty For Me
			//vars.missionAddresses.Add(0x35B80C);  // The Crook
			//vars.missionAddresses.Add(0x35B810);  // The Thieves
			//vars.missionAddresses.Add(0x35B814);  // The Wife
			//vars.missionAddresses.Add(0x35B818);  // Her Lover
			//vars.missionAddresses.Add(0x35B780);  // Mike Lips Last Lunch
			//vars.missionAddresses.Add(0x35B784);  // Farewell 'Chunky' Lee Chong
			//vars.missionAddresses.Add(0x35B788);  // Van Heist
			//vars.missionAddresses.Add(0x35B78C);  // Cipriani's Chauffeur
			//vars.missionAddresses.Add(0x35B79C);  // Taking Out the Laundry
			//vars.missionAddresses.Add(0x35B790);  // Dead Skunk in the Trunk
			//vars.missionAddresses.Add(0x35B838);  // Turismo
			//vars.missionAddresses.Add(0x35B794);  // The Getaway
			//vars.missionAddresses.Add(0x35B7A0);  // The Pick-Up
			//vars.missionAddresses.Add(0x35B970);  // Patriot Playground
			//vars.missionAddresses.Add(0x35B7A4);  // Salvatore's Called a Meeting
			//vars.missionAddresses.Add(0x35B7B4);  // Chaperone
			//vars.missionAddresses.Add(0x35B7B8);  // Cutting the Grass
			//vars.missionAddresses.Add(0x35B7A8);  // Triads and Tribulations
			//vars.missionAddresses.Add(0x35B774);  // Pump-Action Pimp
			//vars.missionAddresses.Add(0x35B9EC);  // RC Diablo Destruction
			//vars.missionAddresses.Add(0x35B778);  // The Fuzz Ball
			//vars.missionAddresses.Add(0x35B7E4);  // I Scream, You Scream
			//vars.missionAddresses.Add(0x35B7E8);  // Trial By Fire
			//vars.missionAddresses.Add(0x35B7EC);  // Big 'N' Veiny
			//vars.missionAddresses.Add(0x35B9F0);  // RC Mafia Massacre
			//vars.missionAddresses.Add(0x35B7AC);  // Blow Fish
			//vars.missionAddresses.Add(0x35B7BC);  // Bomb Da Base: Act I
			//vars.missionAddresses.Add(0x35B7C0);  // Bomb Da Base: Act II
			//vars.missionAddresses.Add(0x35B7C4);  // Last Requests
			//vars.missionAddresses.Add(0x35B878);  // Sayonara Salvatore
			//vars.missionAddresses.Add(0x35B8D4);  // Bling-Bling Scramble
			//vars.missionAddresses.Add(0x35B87C);  // Under Surveillance
			//vars.missionAddresses.Add(0x35B8AC);  // Kanbu Bust Out
			//vars.missionAddresses.Add(0x35B9F8);  // RC Casino Calamity
			//vars.missionAddresses.Add(0x35B8B0);  // Grand Theft Auto
			//vars.missionAddresses.Add(0x35B8D8);  // Uzi Rider
			//vars.missionAddresses.Add(0x35B97C);  // Multistorey Mayhem
			//vars.missionAddresses.Add(0x35B880);  // Paparazzi Purge
			//vars.missionAddresses.Add(0x35B884);  // Payday For Ray
			//vars.missionAddresses.Add(0x35B890);  // Silence The Sneak
			//vars.missionAddresses.Add(0x35B888);  // Two-Faced Tanner
			//vars.missionAddresses.Add(0x35B8B4);  // Deal Steal
			//vars.missionAddresses.Add(0x35B8B8);  // Shima
			//vars.missionAddresses.Add(0x35B8BC);  // Smack Down
			//vars.missionAddresses.Add(0x35B974);  // A Ride In The Park
			//vars.missionAddresses.Add(0x35B894);  // Arms Shortage
			//vars.missionAddresses.Add(0x35B898);  // Evidence Dash
			//vars.missionAddresses.Add(0x35B89C);  // Gone Fishing
			//vars.missionAddresses.Add(0x35B8DC);  // Gangcar Round-Up
			//vars.missionAddresses.Add(0x35B8A0);  // Plaster Blaster
			//vars.missionAddresses.Add(0x35B8E0);  // Kingdom Come
			//vars.missionAddresses.Add(0x35B8C4);  // Liberator
			//vars.missionAddresses.Add(0x35B8C8);  // Waka-Gashira Wipeout
			//vars.missionAddresses.Add(0x35B8CC);  // A Drop In The Ocean
			//vars.missionAddresses.Add(0x35B8FC);  // Grand Theft Aero
			//vars.missionAddresses.Add(0x35B8A4);  // Marked Man
			//vars.missionAddresses.Add(0x35B900);  // Escort Service
			//vars.missionAddresses.Add(0x35B9F4);  // RC Rumpo Rampage
			//vars.missionAddresses.Add(0x35B924);  // Uzi Money
			//vars.missionAddresses.Add(0x35B928);  // Toyminator
			//vars.missionAddresses.Add(0x35B92C);  // Rigged to Blow
			//vars.missionAddresses.Add(0x35B930);  // Bullion Run
			//vars.missionAddresses.Add(0x35B910);  // Bait
			//vars.missionAddresses.Add(0x35B904);  // Decoy
			//vars.missionAddresses.Add(0x35B908);  // Love's Disappearance
			//vars.missionAddresses.Add(0x35B914);  // Espresso-2-Go!
			//vars.missionAddresses.Add(0x35B918);  // S.A.M. + Ransom
			vars.missionAddresses.Add(0x35B948);  // The Exchange
			//vars.missionAddresses.Add(0x35B934);  // Rumble
			//vars.missionAddresses.Add(0x35B978);  // Gripped!
		}
		
		///////////////////// K I N G D O M   C O M E /////////////////////
		else if (vars.category.Contains("kingdom"))
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
			vars.missionAddresses.Add(0x35B8D4);  // Bling-Bling Scramble
			vars.missionAddresses.Add(0x35B8D8);  // Uzi Rider
			vars.missionAddresses.Add(0x35B8DC);  // Gangcar Round-Up
			vars.missionAddresses.Add(0x35B8E0);  // Kingdom Come
		}
		
		///////////////////////////////////////////////////////////////////
		else 
		{
			vars.missionAddresses.Add(0x35B948);  // The Exchange
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
	else
	{
		var versionCheck = memory.ReadValue<int>(modules.First().BaseAddress+0x1C1E70);
		
		if (versionCheck == 1407551829)
		{
			version = "1.0";
			vars.offset = -0x10140;
		}
		
		else
		{
			versionCheck = memory.ReadValue<int>(modules.First().BaseAddress+0x1C2130);
			
			if (versionCheck == 1407551829)
			{
				version = "1.1";
				vars.offset = -0x10140;
			}
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
	
	// Used to know when the player skips the initial cutscene and starts the run.
	vars.skipInitialCutsceneCheck = new MemoryWatcher<int>(new DeepPointer(0x35CC50+vars.offset));
	
	// Used to know what state the game is currently in.
	vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x505A2C+vars.offset));
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
	vars.gameState.Update(game);
	
	// Works out the current real time in seconds, so it can be compared to.
	// going to use ~5 seconds for GTA3 just to be safe for SRL races and such, might need to be higher?
	var currentRealTime = timer.CurrentTime.RealTime.ToString();
	var currentRealTimeInSeconds = TimeSpan.Parse(currentRealTime).TotalSeconds;
	
	// Starting the splits after the initial cutscene skip.
	if (vars.skipInitialCutsceneCheck.Old == 0 && vars.skipInitialCutsceneCheck.Current == 3841) {vars.doStart = true;}
	
	// Resetting the splits if needed.
	if (vars.gameState.Old == 9 && vars.gameState.Current == 8 && currentRealTimeInSeconds > 5) {
		vars.doReset = true;
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
