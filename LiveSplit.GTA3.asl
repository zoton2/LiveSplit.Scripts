state("gta3")
{
	// unknown/default version
}

// These need to exist so they are actually found as versions by the code below.
// Also some variables used in any% final split check are declared here.
state("gta3", "1.0") 
{
	byte exchangeHelipad : 0x34F578;
	byte exchangeTimer : 0x34B8EC;
	byte percentage : 0x4F6224; // This may be wrong, but nobody plays 1.0 anyway, so this shouldn't be a problem
}
state("gta3", "1.1") 
{
	byte exchangeHelipad : 0x34F578;
	byte exchangeTimer : 0x34B8EC;
	byte percentage : 0x4F63DC;
}
state("gta3", "steam") 
{
	byte exchangeHelipad : 0x35F6B8;
	byte exchangeTimer : 0x35BA2C;
	byte percentage : 0x50651C;
}

init
{
	// Declaring variables.
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	vars.offset = 0;
	vars.exchangeTimerOld = 0;
	
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
		
		///////////////////////////// 1 0 0 % /////////////////////////////
		else if (vars.category.Contains("100%") || vars.category.Contains("hundo")) 
		{
			// You can add addresses for missions you want to split on
			// MAKE SURE THEY ARE IN RIGHT ORDER, IT'S VERY IMPORTANT
			// Autosplitter will automatically split when you reach 100%, but nothing bad will happen
			// when you finish a run with a mission that's in this list.
			// Here are some miscellaneous addresses to get you started:
			// TODO: add misc addresses
		}
		
		///////////////////// C O L L E C T A B L E S /////////////////////
		else if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage")) {}
		
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
	
	// Init section for 100%
	if (vars.category.Contains("100%") || vars.category.Contains("hundo")) 
	{
		vars.hundoShouldSplit = false;
		vars.hundoMissionDone = false; // Used to check if buffered mission is done
		vars.percentageOld = 0.0;
		if (vars.missionAddressesCurrent.Count != 0)
		{
			vars.hundoCompletedMission = vars.missionAddressesCurrent[0]; // Used to store buffered mission
		}
		else
		{
			vars.hundoCompletedMission = 0x0;
		}
		
		// Watchers
		vars.taxiWatcher = new MemoryWatcher<byte>(new DeepPointer(0x35B9C4+vars.offset));
	}
	
	// Init section for collectable runs.
	// For "simplicity" reasons, mixed runs (for example: packages + stunts) are not supported.
	// Nobody does it anyway, but in case someone attempts it, the first category will override any other.
	// Interesting thing is "mission type" and "collectable type" run mix will actually work.
	else if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
	{
		vars.collectableIndex = 0;
		
		// You can specify when autosplitter splits by adding values (separated by commas)
		// IN ASCENDING ORDER to vars.collectableSplitOn arrays.
		
		////////////// 1 0 0   H I D D E N   P A C K A G E S //////////////
		if (vars.category.Contains("package"))
		{
			// Set up memory watcher for collected packages counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x35C3D4+vars.offset));
			
			// By default it splits on 100 packages (max value)
			vars.collectableSplitOn = new int[] { 100 };
		}
		
		/////////// A L L   U N I Q U E   S T U N T   J U M P S ///////////
		else if (vars.category.Contains("stunt") || vars.category.Contains("jump"))
		{
			// Set up memory watcher for completed USJs counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x35BFB0+vars.offset));
			
			// By default it splits on 20 USJs (max value)
			vars.collectableSplitOn = new int[] { 20 };
		}
		
		///////////////////// A L L   R A M P A G E S /////////////////////
		else if (vars.category.Contains("rampage"))
		{
			// Set up memory watcher for completed rampages counter
			vars.collectable = new MemoryWatcher<int>(new DeepPointer(0x35C0AC+vars.offset));
			
			// By default it splits on 20 rampages (max value)
			vars.collectableSplitOn = new int[] { 20 };
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
			if (vars.category.Contains("100%") || vars.category.Contains("hundo")) { vars.hundoCompletedMission = vars.missionAddressesCurrent[0]; }
			vars.missionAddressesCurrent.RemoveAt(0);
			if (vars.missionAddressesCurrent.Count != 0) {vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));}
			if (vars.category.Contains("100%") || vars.category.Contains("hundo")) { vars.hundoMissionDone = true; }
			else { vars.doSplit = true; }
			vars.checkCurrentMission = false;
		}
		
		else {vars.checkCurrentMission = true;}
	}
	
	// Final split for any%
	// That timer variable is used in different missions so we're making sure that we're on The Exchange
	// by also checking for variable that is set in the very last part of the mission.
	// Timer variable is changed on the fade out when you lose control.
	else if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
	{
		if (current.exchangeHelipad == 1 && current.exchangeTimer != vars.exchangeTimerOld) {vars.doSplit = true;}
		vars.exchangeTimerOld = current.exchangeTimer;
	}
	
	// Collectables
	else if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
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
	
	// 100%
	// By default it only splits on missions from 100% section of missionAddresses list and when ingame percentage reaches 100%
	// It's possible to add optional checks for splits for all kinds of fancy crap in the game
	if (vars.category.Contains("100%") || vars.category.Contains("hundo")) 
	{		
		// Divide by 1.54 because there are 154 places in script that "add" percentage. Well coded Rockstar, well coded.
		if ((current.percentage/1.54) >= 100.0 && (current.percentage/1.54) != vars.percentageOld) 
		{
			vars.hundoShouldSplit = true;
			vars.percentageOld = current.percentage/1.54;
		}
		
		// NG+ 100% section for Gael. After reaching first taxi dupe, it splits for every percentage change.
		if (vars.category.Contains("ng"))
		{
			vars.taxiWatcher.Update(game);
			if (vars.taxiWatcher.Current == 1)
			{
				if ((current.percentage/1.54) > vars.percentageOld)
				{
					vars.hundoShouldSplit = true;
					vars.percentageOld = current.percentage/1.54;
				}
			}
		}
		
		// If you want to split independently of mission, make your checks outside this switch block.
		// If you need help ping Pitpo on #gta channel on SRL's IRC server.
		// You can find two examples of using this switch in Vice City autosplitter
		switch ((int)vars.hundoCompletedMission)
		{
			case 0:
				break;
			default:
				if (vars.hundoMissionDone == true)
				{
					vars.hundoShouldSplit = true;
					vars.hundoMissionDone = false;
				}
				break;
		}
		
		if (vars.hundoShouldSplit == true) 
		{ 
			vars.doSplit = true;
			vars.hundoShouldSplit = false;
		}
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
		if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
		{
			vars.collectableIndex = 0;
		}
		else if (vars.category.Contains("100%") || vars.category.Contains("hundo"))
		{
			vars.percentageOld = 0.0;
			vars.hundoCompletedMission = vars.missionAddressesCurrent[0];
		}
	}
	
	return vars.doStart;
}

reset {return vars.doReset;}
split {return vars.doSplit;}
