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
	byte progressMade : 0x4F6224; // This may be wrong, but nobody plays 1.0 anyway, so this shouldn't be a problem
}
state("gta3", "1.1") 
{
	byte exchangeHelipad : 0x34F578;
	byte exchangeTimer : 0x34B8EC;
	byte progressMade : 0x4F63DC;
}
state("gta3", "steam") 
{
	byte exchangeHelipad : 0x35F6B8;
	byte exchangeTimer : 0x35BA2C;
	byte progressMade : 0x50651C;
}

init
{
	refreshRate = 30;
	// Declaring variables.
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
			vars.missionAddresses.Add(0x35B7A8);  // Triads and Tribulations
			vars.missionAddresses.Add(0x35B7B8);  // Cutting the Grass
			//vars.missionAddresses.Add(0x35B7AC);  // Blow Fish - Apparently, due to the instapass magic it doesn't autosplit, because mission "fails" or something
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
		// Mission order needs changing (this is outdated Omega's route).
		// It's important to list missions here in the exact same order you do them during the run.
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
			//vars.missionAddresses.Add(0x35B778);  // The Fuzz Ball (used later in example)
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
	
	// Split after you start the next mission
	// 0 - never
	// 1 - always
	// 2 - only on selected missions
	vars.splitOnMission = 0;
	
	vars.missionPassed = false;
	vars.missionPassedAddress = 0x0; // Used to store buffered mission address (defaults to nothing for safety reasons)
	
	if (vars.splitOnMission != 0 || vars.category.Contains("100%") || vars.category.Contains("hundo"))
	{
		// There is no onMission variable exclusive to story missions, but there's one for every other oddjob (and "employer"?)
		vars.onMissionFlag = new MemoryWatcher<int>(new DeepPointer(0x35B6C4+vars.offset));
		vars.onMissionFlagVigilante = new MemoryWatcher<int>(new DeepPointer(0x35B964+vars.offset));
		vars.onMissionFlagTaxi = new MemoryWatcher<int>(new DeepPointer(0x35B9BC+vars.offset));
		vars.onMissionFlagParamedic = new MemoryWatcher<int>(new DeepPointer(0x35B954+vars.offset));
		vars.onMissionFlagFirefighter = new MemoryWatcher<int>(new DeepPointer(0x35B95C+vars.offset));
		vars.onMissionFlagRampage = new MemoryWatcher<int>(new DeepPointer(0x35C0A8+vars.offset));
		vars.skipSplit = false;
		vars.checkSkipSplit = true;
		
		// This string (MemoryWatcher has issues with strings so it's byte) stores name of the last thread
		// It's only useful for hospital and police station icons. Game likes to switch addresses 
		// for this thing (it's a static variable, so no pointers) but it's always this one for those two icons
		vars.lastOddJobThread = new MemoryWatcher<byte>(new DeepPointer(0x308308+vars.offset));
		
		if (vars.splitOnMission == 2 && !((IDictionary<String, object>)vars).ContainsKey("OMSplit"))
		{
			vars.OMSplit = new List<int>();
			
			// If you want to split after picking up next mission only in some cases (splitOnMission = 2), add them to this list
			if (vars.category.Contains("any") || vars.category.Contains("beat the game"))
			{
				vars.OMSplit.Add(0x35B79C);  // Taking Out the Laundry
				vars.OMSplit.Add(0x35B7A8);  // Triads and Tribulations
				vars.OMSplit.Add(0x35B878);  // Sayonara Salvatore
				vars.OMSplit.Add(0x35B898);  // Evidence Dash
			}
		}
		if (vars.splitOnMission == 2)
		{
			// Make copy of that list to make it reset friendly
			vars.OMSplitCurrent = new List<int>(vars.OMSplit);
		}
	}
	
	// Used to know when the player skips the initial cutscene and starts the run.
	vars.skipInitialCutsceneCheck = new MemoryWatcher<int>(new DeepPointer(0x35CC50+vars.offset));
	
	// Used to know what state the game is currently in.
	vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x505A2C+vars.offset));
	
	// Init section for 100%
	if (vars.category.Contains("100%") || vars.category.Contains("hundo")) 
	{
		vars.hundoShouldSplit = false;
		vars.progressOld = 0;
		vars.progressReal = 0;
		vars.splitOnMissionHundo = false;
		
		//vars.previousStunts = 0;
		
		// Watchers
		vars.hundoPackages = new MemoryWatcher<int>(new DeepPointer(0x35C3D4+vars.offset));
		vars.hundoRampages = new MemoryWatcher<int>(new DeepPointer(0x35C0AC+vars.offset));
		vars.hundoStunts = new MemoryWatcher<int>(new DeepPointer(0x35BFB0+vars.offset));
		
		vars.taxiWatcher = new MemoryWatcher<byte>(new DeepPointer(0x35B9C4+vars.offset));
		vars.craneExportsDone = new MemoryWatcher<byte>(new DeepPointer(0x35C3B4+vars.offset));
		//vars.PAPDone = new MemoryWatcher<byte>(new DeepPointer(0x35B774+vars.offset));
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
	// unknown version, don't do anything
	if (version == "")
		return;
	
	// Keeping a few extra memory watchers up to date for the current frame.
	vars.skipInitialCutsceneCheck.Update(game);
	vars.gameState.Update(game);
	if (vars.splitOnMission != 0 || vars.category.Contains("100%") || vars.category.Contains("hundo")) 
	{
		vars.onMissionFlag.Update(game);
		vars.onMissionFlagFirefighter.Update(game);
		vars.onMissionFlagParamedic.Update(game);
		vars.onMissionFlagRampage.Update(game);
		vars.onMissionFlagTaxi.Update(game);
		vars.onMissionFlagVigilante.Update(game);
		vars.lastOddJobThread.Update(game);
		
		// There must be other way to do it...
		if ((vars.onMissionFlagFirefighter.Current == 1 && vars.onMissionFlagFirefighter.Old == 0) ||
			(vars.onMissionFlagParamedic.Current == 1 && vars.onMissionFlagParamedic.Old == 0) ||
			(vars.onMissionFlagRampage.Current == 1 && vars.onMissionFlagRampage.Old != 1) ||
			(vars.onMissionFlagTaxi.Current == 1 && vars.onMissionFlagTaxi.Old == 0) ||
			(vars.onMissionFlagVigilante.Current == 1 && vars.onMissionFlagVigilante.Old == 0) ||
			((vars.lastOddJobThread.Current == 104 || vars.lastOddJobThread.Current == 119) && vars.lastOddJobThread.Current != vars.lastOddJobThread.Old))
		{
			vars.skipSplit = true;
			vars.checkSkipSplit = false;
		} else if (vars.checkSkipSplit) { vars.skipSplit = false; }
		else { vars.checkSkipSplit = true; }
	}
	
	// All missions (besides the final split).
	if (vars.missionAddressesCurrent.Count != 0)
	{
		vars.currentMissionWatcher.Update(game);
		
		if (vars.checkCurrentMission && vars.currentMissionWatcher.Old == 0 && vars.currentMissionWatcher.Current == 1)
		{
			vars.missionPassedAddress = vars.missionAddressesCurrent[0];
			vars.missionAddressesCurrent.RemoveAt(0);
			if (vars.missionAddressesCurrent.Count != 0) {vars.currentMissionWatcher = new MemoryWatcher<byte>(new DeepPointer(vars.missionAddressesCurrent[0]+vars.offset));}
			vars.missionPassed = true;
			vars.checkCurrentMission = false;
		}
		
		else {vars.checkCurrentMission = true;}
	}
	
	// Update collectables watcher (if needed)
	if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
	{
		vars.collectable.Update(game);
	}
	
	// 100%
	// By default it only splits on missions from 100% section of missionAddresses list and when ingame percentage reaches 100%
	// It's possible to add optional checks for splits for all kinds of fancy crap in the game
	else if (vars.category.Contains("100%") || vars.category.Contains("hundo"))
	{
		// Keep watchers updated
		vars.hundoPackages.Update(game);
		vars.hundoRampages.Update(game);
		vars.hundoStunts.Update(game);
		vars.craneExportsDone.Update(game);
		//vars.PAPDone.Update(game);
				
		if (current.progressMade > vars.progressOld && (!vars.category.Contains("ingame") && !vars.category.Contains("in-game")))
		{
			// Every duped mission instance is (thankfully) awarding player at the exact same frame, so there's no need for complex duping checks.
			// Emergency vehicles (crane) exports reward player with percentage after all cars are delivered.
			if (vars.craneExportsDone.Old == 0 && vars.craneExportsDone.Current == 1)
			{
				vars.progressReal = vars.progressReal + 7;
			}
			else
			{
				vars.progressReal++;
			}
			vars.progressOld = current.progressMade;
		}
		
		if (vars.progressReal == 154 && (!vars.category.Contains("ingame") && !vars.category.Contains("in-game")))
		{
			vars.hundoShouldSplit = true;
		}
		
		// NG+ 100% section for Gael. It splits for every percentage change.
		if (vars.category.Contains("ingame") || vars.category.Contains("in-game"))
		{
			//vars.taxiWatcher.Update(game);
			//if (vars.taxiWatcher.Current == 1)
			//{
				if (current.progressMade > vars.progressOld)
				{
					vars.hundoShouldSplit = true;
					vars.progressOld = current.progressMade;
				}
			//}
		}
		
		//if (vars.PAPDone.Old == 0 && vars.PAPDone.Current == 1)
		//{
		//	vars.previousStunts = vars.hundoStunts.Current;
		//}
		
		// If you want to split independently of mission, make your checks outside this switch block.
		// If you need help ping Pitpo on #gta channel on SRL's IRC server.
		// You can find two more examples of using this switch in Vice City autosplitter
		switch ((int)vars.missionPassedAddress)
		{
			case 0:
				break;
			//case (int)0x35B778:  // The Fuzz Ball - split after mission and the "infamous stunts" are done (it's possible to set up a watcher for individual stunts, but i'm to lazy to look for addresses)
			//	if (vars.missionPassed && vars.hundoStunts.Current - vars.previousStunts >= 3)
			//	{
			//		vars.hundoShouldSplit = true;
			//		vars.missionPassed = false;
			//	}
			default:
				if (vars.missionPassed)
				{
					vars.hundoShouldSplit = true;
					vars.missionPassed = false;
					vars.splitOnMissionHundo = false; // split after mission pass by default
				}
				break;
		}
	}
}

start
{
	// Starting the splits after the initial cutscene skip.
	if (vars.skipInitialCutsceneCheck.Old == 0 && vars.skipInitialCutsceneCheck.Current == 3841)
	{
		// Makes a copy of the mission memory addresses list (so it can be edited and then restored on reset).
		vars.missionAddressesCurrent = new List<int>(vars.missionAddresses);
		if (vars.splitOnMission == 2)
		{
			vars.OMSplitCurrent = new List<int>(vars.OMSplit);
		}
		vars.missionPassed = false;
		vars.missionPassedAddress = 0x0;
		
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
			vars.progressOld = 0;
			vars.progressReal = 0;
		}
	}
	
	return vars.skipInitialCutsceneCheck.Old == 0 && vars.skipInitialCutsceneCheck.Current == 3841;
}

reset
{
	// Works out the current real time in seconds, so it can be compared to.
	// going to use ~5 seconds for GTA3 just to be safe for SRL races and such, might need to be higher?
	var currentRealTime = timer.CurrentTime.RealTime.ToString();
	var currentRealTimeInSeconds = TimeSpan.Parse(currentRealTime).TotalSeconds;
	
	// Resetting the splits if needed.
	return vars.gameState.Old == 9 && vars.gameState.Current == 8 && currentRealTimeInSeconds > 5;
}

split
{
	if (vars.missionPassed && !vars.category.Contains("100%") && !vars.category.Contains("hundo"))
	{
		switch ((int)vars.splitOnMission) {
			case 1:	// Split on every onMissionFlag 0->1 change (but only on story missions)
			{
				if (vars.onMissionFlag.Current == 1 && vars.onMissionFlag.Old == 0 && !vars.skipSplit) { goto case 0; }
				else { break; }
			}
			case 2:	// Split on selected onMissionFlag 0->1 changes
			{
				if (vars.OMSplitCurrent.Count != 0)
				{
					if (vars.missionPassedAddress == vars.OMSplitCurrent[0])
					{
						if (vars.onMissionFlag.Current == 1 && vars.onMissionFlag.Old == 0 && !vars.skipSplit)
						{
							vars.OMSplitCurrent.RemoveAt(0);
							goto case 0;
						} else { break; }
					} else { goto case 0; }
				} else { goto case 0; }
			}
			case 0: // Split after mission pass
			default:
			{
				vars.missionPassed = false;
				return true;
				break;
			}
		}
	}
	
	// Final split for any%
	// That timer variable is used in different missions so we're making sure that we're on The Exchange
	// by also checking for variable that is set in the very last part of the mission.
	// Timer variable is changed on the fade out when you lose control.
	if ((vars.category.Contains("any") || vars.category.Contains("beat the game")) && vars.missionAddressesCurrent.Count == 0)
	{
		return current.exchangeHelipad == 1 && current.exchangeTimer != old.exchangeTimer;
	}
	
	// Collectables
	else if (vars.category.Contains("package") || vars.category.Contains("stunt") ||
			vars.category.Contains("jump") || vars.category.Contains("rampage"))
	{
		// Split when number of required collectables for next split equals the one ingame.
		if (vars.collectable.Old < vars.collectableSplitOn[vars.collectableIndex] && vars.collectable.Current == vars.collectableSplitOn[vars.collectableIndex])
		{
			if (vars.collectableIndex < vars.collectableSplitOn.Length-1)
			{
				vars.collectableIndex++;
			}
			return true;
		}
	}
	
	// 100%
	else if (vars.category.Contains("100%") || vars.category.Contains("hundo"))
	{
		if (vars.hundoShouldSplit)
		{
			if (vars.splitOnMissionHundo) 
			{
				if (vars.onMissionFlag.Current == 1 && vars.onMissionFlag.Old == 0 && !vars.skipSplit) 
				{
					vars.splitOnMissionHundo = false;
					vars.hundoShouldSplit = false;
					return true;
				}
			} else {
				return true;
			}
		}
	}
}
