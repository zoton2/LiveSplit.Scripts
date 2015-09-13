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
		// By default autosplitter splits after every mission in Any% and Shakedown% category, in All Missions it splits after credits.
		// All unsupported categories will split only after credits.
		// You may want to adjust these settings to your needs.
		
		///////////////////////////// A N Y % /////////////////////////////
		if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
		{
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
		
		///////////////////// A L L   M I S S I O N S /////////////////////
		// Mission order SHOULD BE up to date with latest KZ_FREW's route.
		// It's important to list missions here in the exact same order you do them during the run.
		// You may want to rearrange this list for your needs.
		// It's recommended to split at least every few missions in case something unexpected happens in the run.
		else if (vars.category.Contains("missions")) 
		{
			//vars.missionAddresses.Add(0x421600);  // The Party
			//vars.missionAddresses.Add(0x421604);  // Back Alley Brawl
			//vars.missionAddresses.Add(0x421608);  // Jury Fury
			//vars.missionAddresses.Add(0x42160C);  // Riot
			//vars.missionAddresses.Add(0x421614);  // Treacherous Swine
			//vars.missionAddresses.Add(0x421728);  // Road Kill
			//vars.missionAddresses.Add(0x421618);  // Mall Shootout
			//vars.missionAddresses.Add(0x42161C);  // Guardian Angels
			//vars.missionAddresses.Add(0x42162C);  // The Chase
			//vars.missionAddresses.Add(0x42172C);  // Waste The Wife
			//vars.missionAddresses.Add(0x421630);  // Phnom Penh '86
			//vars.missionAddresses.Add(0x421634);  // The Fastest Boat
			//vars.missionAddresses.Add(0x421638);  // Supply and Demand
			//vars.missionAddresses.Add(0x421620);  // Sir Yes Sir
			//vars.missionAddresses.Add(0x421650);  // Four Iron
			//vars.missionAddresses.Add(0x421648);  // Death Row
			//vars.missionAddresses.Add(0x42163C);  // Rub Out
			//vars.missionAddresses.Add(0x4216A8);  // Shakedown
			//vars.missionAddresses.Add(0x421684);  // Recruitment Drive
			//vars.missionAddresses.Add(0x421688);  // Dildo Dodo
			//vars.missionAddresses.Add(0x4216C0);  // Spilling the Beans
			//vars.missionAddresses.Add(0x4216C4);  // Hit the Courier
			//vars.missionAddresses.Add(0x4216AC);  // Bar Brawl
			//vars.missionAddresses.Add(0x421730);  // Autocide
			//vars.missionAddresses.Add(0x421624);  // All Hands On Deck
			//vars.missionAddresses.Add(0x42168C);  // Martha's Mug Shot
			//vars.missionAddresses.Add(0x421690);  // G-Spotlight
			//vars.missionAddresses.Add(0x421654);  // Demolition Man
			//vars.missionAddresses.Add(0x421658);  // Two Bit Hit
			//vars.missionAddresses.Add(0x421750);  // V.I.P.
			//vars.missionAddresses.Add(0x421734);  // Check Out At The Check In
			//vars.missionAddresses.Add(0x421700);  // Love Juice
			//vars.missionAddresses.Add(0x421704);  // Psycho Killer
			//vars.missionAddresses.Add(0x4216CC);  // Alloy Wheels Of Steel
			//vars.missionAddresses.Add(0x4216D0);  // Messing With The Man
			//vars.missionAddresses.Add(0x4216D4);  // Hog Tied
			//vars.missionAddresses.Add(0x4216B0);  // Cop Land
			//vars.missionAddresses.Add(0x421754);  // Friendly Rivalry
			//vars.missionAddresses.Add(0x421758);  // Cabmaggedon
			//vars.missionAddresses.Add(0x421660);  // No Escape?
			//vars.missionAddresses.Add(0x4216DC);  // Stunt Boat Challenge
			//vars.missionAddresses.Add(0x421664);  // The Shootist
			//vars.missionAddresses.Add(0x421708);  // Publicity Tour
			//vars.missionAddresses.Add(0x421668);  // The Driver
			//vars.missionAddresses.Add(0x42166C);  // The Job
			//vars.missionAddresses.Add(0x4216F0);  // Juju Scramble
			//vars.missionAddresses.Add(0x4216F4);  // Bombs Away!
			//vars.missionAddresses.Add(0x421738);  // Loose Ends
			//vars.missionAddresses.Add(0x4216B4);  // Cap the Collector
			//vars.missionAddresses.Add(0x4216F8);  // Dirty Lickin's
			//vars.missionAddresses.Add(0x421678);  // Gun Runner
			//vars.missionAddresses.Add(0x42167C);  // Boomshine Saigon
			//vars.missionAddresses.Add(0x4216E0);  // Cannon Fodder
			//vars.missionAddresses.Add(0x4216E4);  // Naval Engagement
			//vars.missionAddresses.Add(0x4216E8);  // Trojan Voodoo
			vars.missionAddresses.Add(0x4216B8);  // Keep Your Friends Close
		}
		
		/////////////////// B E A T   S H A K E D O W N ///////////////////
		else if (vars.category.Contains("shakedown"))
		{
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
		}
		
		///////////////////// C O L L E C T A B L E S /////////////////////
		else if (vars.category.Contains("package") || vars.category.Contains("rob") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage")) {}
		
		///////////////////////////////////////////////////////////////////
		else 
		{
			vars.missionAddresses.Add(0x4216B8); // Keep Your Friends Close
		}
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
	
	if (vars.missionAddressesCurrent.Count != 0) {
		vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));
		
		// Used to ignore the check for a single frame (not sure if actually needed but leaving in anyway).
		vars.checkCurrentMission = false;
	}
	
	// Used to know when the player starts a new game.
	vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x5B5F10+vars.offset));
	
	// Last split stuff for any% on Keep Your Friends Close, not exactly sure what the values represent but they work!
	if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		vars.kyfc1 = new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset));
		vars.kyfc2 = new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset));
		vars.kyfc3 = new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset));
	}
	
	// Init section for collectable runs. [nice conditions]
	// For "simplicity" reasons, mixed runs (for example: packages + stunts) are not supported.
	// Nobody does it anyway, but in case someone attempts it, the first category will override any other.
	// Interesting thing is "mission type" and "collectable type" run mix will actually work.
	else if (vars.category.Contains("package") || vars.category.Contains("rob") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
	{
		vars.collectableIndex = 0;
		
		// You can specify when autosplitter splits by adding values (separated by commas)
		// IN ASCENDING ORDER to vars.collectableSplitOn arrays.
		
		////////////// 1 0 0   H I D D E N   P A C K A G E S //////////////
		if (vars.category.Contains("package"))
		{
			// Set up memory watcher for collected packages counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x4226E8+vars.offset));
			
			// By default it splits on 100 packages (max value)
			vars.collectableSplitOn = new int[] { 100 };
		}
		
		//////////////////// A L L   R O B B E R I E S ////////////////////
		else if (vars.category.Contains("rob"))
		{
			// Set up memory watcher for completed robberies counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x422A6C+vars.offset));
			
			// By default it splits on 15 robberies (max value)
			vars.collectableSplitOn = new int[] { 15 };
		}
		
		/////////// A L L   U N I Q U E   S T U N T   J U M P S ///////////
		else if (vars.category.Contains("stunt") || vars.category.Contains("jump"))
		{
			// Set up memory watcher for completed USJs counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x421EDC+vars.offset));
			
			// By default it splits on 36 USJs (max value)
			vars.collectableSplitOn = new int[] { 36 };
		}
		
		///////////////////// A L L   R A M P A G E S /////////////////////
		else  if (vars.category.Contains("rampage"))
		{
			// Set up memory watcher for completed rampages counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x42286C+vars.offset));
			
			// By default it splits on 35 rampages (max value)
			vars.collectableSplitOn = new int[] { 35 };
		}
	}
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
	vars.gameState.Update(game);
	if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		vars.kyfc1.Update(game);
		vars.kyfc2.Update(game);
		vars.kyfc3.Update(game);
	}
	
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
	
	// Collectables
	else if (vars.category.Contains("package") || vars.category.Contains("rob") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
	{
		vars.collectable.Update(game);
		
		// Split when number of required collectables for next split equals the one ingame.
		if (vars.collectable.Old < vars.collectableSplitOn[vars.collectableIndex] && vars.collectable.Current == vars.collectableSplitOn[vars.collectableIndex])
		{
			vars.doSplit = true;
			
			if (vars.collectableIndex < vars.collectableSplitOn.Length-1)
			{
				vars.collectableIndex++;
			}
		}
	}
	
	// Final split for any% (when control is lost on Keep Your Friends Closer). [this is a little bit dirty but should work]
	else if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		if (vars.kyfc1.Current == 245 && vars.kyfc2.Current > vars.kyfc3.Current) {vars.doSplit = true;}
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
		
		if (vars.category.Contains("package") || vars.category.Contains("rob") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
		{
			vars.collectableIndex = 0;
		}
	}
	
	return vars.doStart;
}

reset {return vars.doReset;}
split {return vars.doSplit;}
