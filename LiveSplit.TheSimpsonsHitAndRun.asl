// Compatibility:
// > This script works with the popular "FairLight" No-CD. It will check the user is using this before doing the update/start/reset/split/isLoading functions.

// Bugs:
// > Reset does not work after startup if no save file is loaded beforehand, either because the user has none
//   or they use the "No Automatic Saved Game Load" mod in the mod launcher. Not a big issue though.
//   > This bug happens because the newGame variable needs to change from 1 to 0.

// Notes:
// > Normal missions will split even if you don't complete them fully or are playing from a save file,
//   so it works with NG+ and Any% as well.
// > I added some code for settings for gags/clothing/wasps but don't know if they're wanted or useful enough
//   to code the actual splitting for them, so they're commented out for now.
// > This code should be idiot proof, so if you accidentally go to a higher level or mission in NG+, you should
//   still be able to go back to the correct mission and the split should still work from there on.

state("Simpsons")
{
	// unknown/default version
}

state("Simpsons", "FairLight")
{
	// Some basic non-stat memory addresses are stored here.
	int gameState : 0x2C9014, 0xC;  // Can be a few different numbers to do with the state the game is currently in.
	int notLoading : 0x2C9018, 0x1D58;  // 0 if loading, 1 if not.
	int paused : 0x2C8428, 0x18;  // If in the pause menu or not.
	int mainMenu : 0x2C9018, 0x1A18;  // If on the main menu or not.
	string11 lastVideoLoaded : 0x2C8980, 0x54, 0x14, 0xF;  // File name of the last video file the game loaded.
	int videoPlaying : "binkw32.dll", 0x6521C;  // If a video is currently playing or not.
	int newGame : 0x2C842C, 0x6C;  // Turns to 0 when a new game is started and changes to 1 when the first level is loaded.
	int coinsTotal : 0x2C8984, 0x111C;  // L O D S of E M O N E, what's that spell? Loadsamoney! (probably)
	int activeMission : 0x2C8984, 0x110C;  // 0-6 (or 0-7 on level 1 cuz tutorial); doesn't change for bonus missions/races.
	int activeLevel : 0x2C8984, 0x1108;  // 0-6 depending on what level you are on.
}

startup
{
	// A simple action to reset some variables in the script later.
	Action ResetVars = () => {
		vars.canStart = false;
		vars.coinGrindingDone = false;
		vars.highestLevel = 0;
		vars.highestMission = new int[7];
	};
	vars.resetVariables = ResetVars;
	
	// Level 1 settings.
	settings.Add("level1", false, "Level 1");
	settings.Add("L1M0", false, "0: The Cola Caper (Tutorial Mission)", "level1");
	settings.Add("L1M1", false, "1: S-M-R-T", "level1");
	settings.Add("L1M2", false, "2: Petty Theft Homer", "level1");
	settings.Add("L1M3", false, "3: Office Spaced", "level1");
	settings.Add("L1M4", false, "4: Blind Big Brother", "level1");
	settings.Add("L1M5", false, "5: Flowers by Irene", "level1");
	settings.Add("L1M6", false, "6: Bonestorm Storm", "level1");
	settings.Add("L1M7", false, "7: The Fat and Furious", "level1");
	settings.SetToolTip("L1M7", "Splits when you move to the next level.");
	settings.Add("l1100%", false, "100%", "level1");
	settings.Add("L1Races", false, "Races", "l1100%");
	settings.Add("L1TimeTrial", false, "Time Trial", "L1Races");
	settings.Add("L1CircuitRace", false, "Circuit", "L1Races");
	settings.Add("L1CheckpointRace", false, "Checkpoint", "L1Races");
	/*settings.Add("L1CollectorCards", false, "Collector Cards", "level1");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L1CollectorCard"+i, false, i.ToString(), "L1CollectorCards");
	}
	settings.Add("L1Wasps", false, "Wasp Cameras", "level1");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L1Wasp"+i, false, i.ToString(), "L1Wasps");
	}
	settings.Add("L1Gags", false, "Gags", "level1");
	for (var i = 1; i <= 15; i++) {
		settings.Add("L1Gag"+i, false, i.ToString(), "L1Gags");
	}*/
	settings.Add("L1BM", false, "Bonus Mission: This Old Shanty", "l1100%");
	
	// Level 2 settings.
	settings.Add("level2", false, "Level 2");
	settings.Add("L2M1", false, "1: Detention Deficit Disorder", "level2");
	settings.Add("L2M2", false, "2: Weapons of Mass Delinquency", "level2");
	settings.Add("L2M3", false, "3: Vox Nerduli", "level2");
	settings.Add("L2M4", false, "4: Bart 'n' Frink", "level2");
	settings.Add("L2M5", false, "5: Better than Beef", "level2");
	settings.Add("L2M6", false, "6: Monkey See, Monkey D'oh!", "level2");
	settings.Add("L2M7", false, "7: Cell-Outs", "level2");
	settings.SetToolTip("L2M7", "Splits when you move to the next level.");
	settings.Add("l2100%", false, "100%", "level2");
	settings.Add("L2Races", false, "Races", "l2100%");
	settings.Add("L2TimeTrial", false, "Time Trial", "L2Races");
	settings.Add("L2CircuitRace", false, "Circuit", "L2Races");
	settings.Add("L2CheckpointRace", false, "Checkpoint", "L2Races");
	/*settings.Add("L2CollectorCards", false, "Collector Cards", "level2");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L2CollectorCard"+i, false, i.ToString(), "L2CollectorCards");
	}
	settings.Add("L2Wasps", false, "Wasp Cameras", "level2");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L2Wasp"+i, false, i.ToString(), "L2Wasps");
	}
	settings.Add("L2Gags", false, "Gags", "level2");
	for (var i = 1; i <= 11; i++) {
		settings.Add("L2Gag"+i, false, i.ToString(), "L2Gags");
	}*/
	settings.Add("L2BM", false, "Bonus Mission: Dial B for Blood", "l2100%");
	
	// Level 3 settings.
	settings.Add("level3", false, "Level 3");
	settings.Add("L3M1", false, "1: Nerd Race Queen", "level3");
	settings.Add("L3M2", false, "2: Clueless", "level3");
	settings.Add("L3M3", false, "3: Bonfire of the Manatees", "level3");
	settings.Add("L3M4", false, "4: Operation Hellfish", "level3");
	settings.Add("L3M5", false, "5: Slithery Sleuthing", "level3");
	settings.Add("L3M6", false, "6: Fishy Deals", "level3");
	settings.Add("L3M7", false, "7: The Old Pirate and the Sea", "level3");
	settings.SetToolTip("L3M7", "Splits when you move to the next level.");
	settings.Add("l3100%", false, "100%", "level3");
	settings.Add("L3Races", false, "Races", "l3100%");
	settings.Add("L3TimeTrial", false, "Time Trial", "L3Races");
	settings.Add("L3CircuitRace", false, "Circuit", "L3Races");
	settings.Add("L3CheckpointRace", false, "Checkpoint", "L3Races");
	/*settings.Add("L3CollectorCards", false, "Collector Cards", "level3");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L3CollectorCard"+i, false, i.ToString(), "L3CollectorCards");
	}
	settings.Add("L3Wasps", false, "Wasp Cameras", "level3");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L3Wasp"+i, false, i.ToString(), "L3Wasps");
	}
	settings.Add("L3Gags", false, "Gags", "level3");
	for (var i = 1; i <= 11; i++) {
		settings.Add("L3Gag"+i, false, i.ToString(), "L3Gags");
	}*/
	settings.Add("L3BM", false, "Bonus Mission: Princi-Pal", "l3100%");
	
	// Level 4 settings.
	settings.Add("level4", false, "Level 4");
	settings.Add("L4M1", false, "1: For A Few Donuts More", "level4");
	settings.Add("L4M2", false, "2: Redneck Roundup", "level4");
	settings.Add("L4M3", false, "3: Ketchup Logic", "level4");
	settings.Add("L4M4", false, "4: Return of the Nearly-Dead", "level4");
	settings.Add("L4M5", false, "5: Wolves Stole My Pills", "level4");
	settings.Add("L4M6", false, "6: Cola Wars", "level4");
	settings.Add("L4M7", false, "7: From Outer Space", "level4");
	settings.SetToolTip("L4M7", "Splits when you move to the next level.");
	settings.Add("l4100%", false, "100%", "level4");
	settings.Add("L4Races", false, "Races", "l4100%");
	settings.Add("L4TimeTrial", false, "Time Trial", "L4Races");
	settings.Add("L4CircuitRace", false, "Circuit", "L4Races");
	settings.Add("L4CheckpointRace", false, "Checkpoint", "L4Races");
	/*settings.Add("L4CollectorCards", false, "Collector Cards", "level4");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L4CollectorCard"+i, false, i.ToString(), "L4CollectorCards");
	}
	settings.Add("L4Wasps", false, "Wasp Cameras", "level4");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L4Wasp"+i, false, i.ToString(), "L4Wasps");
	}
	settings.Add("L4Gags", false, "Gags", "level4");
	for (var i = 1; i <= 15; i++) {
		settings.Add("L4Gag"+i, false, i.ToString(), "L4Gags");
	}*/
	settings.Add("L4BM", false, "Bonus Mission: Beached Love", "l4100%");
	
	// Level 5 settings.
	settings.Add("level5", false, "Level 5");
	settings.Add("L5M1", false, "1: Incriminating Caffeine", "level5");
	settings.Add("L5M2", false, "2: ...and Baby Makes 8", "level5");
	settings.Add("L5M3", false, "3: Eight is Too Much", "level5");
	settings.Add("L5M4", false, "4: This Little Piggy", "level5");
	settings.Add("L5M5", false, "5: Never Trust a Snake", "level5");
	settings.Add("L5M6", false, "6: Kwik Cash", "level5");
	settings.Add("L5M7", false, "7: Curious Curator", "level5");
	settings.SetToolTip("L5M7", "Splits when you move to the next level.");
	settings.Add("l5100%", false, "100%", "level5");
	settings.Add("L5Races", false, "Races", "l5100%");
	settings.Add("L5TimeTrial", false, "Time Trial", "L5Races");
	settings.Add("L5CircuitRace", false, "Circuit", "L5Races");
	settings.Add("L5CheckpointRace", false, "Checkpoint", "L5Races");
	/*settings.Add("L5CollectorCards", false, "Collector Cards", "level5");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L5CollectorCard"+i, false, i.ToString(), "L5CollectorCards");
	}
	settings.Add("L5Wasps", false, "Wasp Cameras", "level5");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L5Wasp"+i, false, i.ToString(), "L5Wasps");
	}
	settings.Add("L5Gags", false, "Gags", "level5");
	for (var i = 1; i <= 6; i++) {
		settings.Add("L5Gag"+i, false, i.ToString(), "L5Gags");
	}*/
	settings.Add("L5BM", false, "Bonus Mission: Kinky Frinky", "l5100%");
	
	// Level 6 settings.
	settings.Add("level6", false, "Level 6");
	settings.Add("L6M1", false, "1: Going to the Lu'", "level6");
	settings.Add("L6M2", false, "2: Getting Down with the Clown", "level6");
	settings.Add("L6M3", false, "3: Lab Coat Caper", "level6");
	settings.Add("L6M4", false, "4: Duff for Me, Duff for You", "level6");
	settings.Add("L6M5", false, "5: Full Metal Jackass", "level6");
	settings.Add("L6M6", false, "6: Set To Kill", "level6");
	settings.Add("L6M7", false, "7: Kang and Kodos Strike Back", "level6");
	settings.SetToolTip("L6M7", "Splits when you move to the next level.");
	settings.Add("l6100%", false, "100%", "level6");
	settings.Add("L6Races", false, "Races", "l6100%");
	settings.Add("L6TimeTrial", false, "Time Trial", "L6Races");
	settings.Add("L6CircuitRace", false, "Circuit", "L6Races");
	settings.Add("L6CheckpointRace", false, "Checkpoint", "L6Races");
	/*settings.Add("L6CollectorCards", false, "Collector Cards", "level6");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L6CollectorCard"+i, false, i.ToString(), "L6CollectorCards");
	}
	settings.Add("L6Wasps", false, "Wasp Cameras", "level6");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L6Wasp"+i, false, i.ToString(), "L6Wasps");
	}
	settings.Add("L6Gags", false, "Gags", "level6");
	for (var i = 1; i <= 11; i++) {
		settings.Add("L6Gag"+i, false, i.ToString(), "L6Gags");
	}*/
	settings.Add("L6BM", false, "Bonus Mission: Milking the Pigs", "l6100%");
	
	// Level 7 settings.
	settings.Add("level7", false, "Level 7");
	settings.Add("L7M1", false, "1: Rigor Motors", "level7");
	settings.Add("L7M2", false, "2: Long Black Probes", "level7");
	settings.Add("L7M3", false, "3: Pocket Protector", "level7");
	settings.Add("L7M4", false, "4: There's Something About Monty", "level7");
	settings.Add("L7M5", false, "5: Alien \"Auto\"topsy Part I", "level7");
	settings.Add("L7M6", false, "6: Alien \"Auto\"topsy Part II", "level7");
	settings.Add("L7M7", false, "7: Alien \"Auto\"topsy Part III", "level7");
	settings.SetToolTip("L7M7", "Splits as soon as the final FMV starts playing.");
	settings.Add("l7100%", false, "100%", "level7");
	settings.Add("L7Races", false, "Races", "l7100%");
	settings.Add("L7TimeTrial", false, "Time Trial", "L7Races");
	settings.Add("L7CircuitRace", false, "Circuit", "L7Races");
	settings.Add("L7CheckpointRace", false, "Checkpoint", "L7Races");
	/*settings.Add("L7CollectorCards", false, "Collector Cards", "level7");
	for (var i = 1; i <= 7; i++) {
		settings.Add("L7CollectorCard"+i, false, i.ToString(), "L7CollectorCards");
	}
	settings.Add("L7Wasps", false, "Wasp Cameras", "level7");
	for (var i = 1; i <= 20; i++) {
		settings.Add("L7Wasp"+i, false, i.ToString(), "L7Wasps");
	}
	settings.Add("L7Gags", false, "Gags", "level7");
	for (var i = 1; i <= 15; i++) {
		settings.Add("L7Gag"+i, false, i.ToString(), "L7Gags");
	}*/
	settings.Add("L7BM", false, "Bonus Mission: Flaming Tires", "l7100%");
	
	// Add the header for misc. 100% stuff.
	settings.Add("misc100%", false, "Miscellaneous 100% Stuff");
	
	// Add the setting for coin grinding!
	settings.Add("coinGrinding", false, "Coin Grinding (6200 L6M6)", "misc100%");
	settings.SetToolTip("coinGrinding", "Splits once you have more than 6200 coins and you're on \"Set to Kill\".");
	
	// Add the setting for picking up the bonus movie ticket.
	settings.Add("bonusMovie", false, "Bonus Movie", "misc100%");
	settings.SetToolTip("bonusMovie", "Splits when you pick up the ticket in the Android's Dungeon.");
	
	// Add the setting for a specific card. For Mango <3.
	settings.Add("mangosCard", false, "Mango's Card (L5 Card 3)", "misc100%");
	settings.SetToolTip("mangosCard", "For Mango <3.");
	
	// Add the setting for the final 100% split.
	settings.Add("finalSplit100%", false, "100%", "misc100%");
	settings.SetToolTip("finalSplit100%", "Splits after every goal towards 100% has been completed.");
	
	// Memory address pointers for all of the 100% stats in the game.
	var statPointers = new Dictionary<int, string> {
		{unchecked((int)0xFFFFFE28), "L1CollectorCards"},
		{0x238, "L1Wasps"},
		{0x24C, "L1Gags"},
		{0x234, "L1CharacterClothing"},
		{0x230, "L1Vehicles"},  // Doesn't count cars won.
		{0x19C, "L1TimeTrial"},
		{0x1BC, "L1CircuitRace"},
		{0x1DC, "L1CheckpointRace"},
		{0xBC, "L1M1"},
		{0xDC, "L1M2"},
		{0xFC, "L1M3"},
		{0x11C, "L1M4"},
		{0x13C, "L1M5"},
		{0x15C, "L1M6"},
		{0x17C, "L1M7"},
		{0x1FC, "L1BM"},
		{unchecked((int)0xFFFFFE48), "L2CollectorCards"},
		{0x4A4, "L2Wasps"},
		{0x4B8, "L2Gags"},
		{0x4A0, "L2CharacterClothing"},
		{0x49C, "L2Vehicles"},  // Doesn't count cars won.
		{0x408, "L2TimeTrial"},
		{0x428, "L2CircuitRace"},
		{0x448, "L2CheckpointRace"},
		{0x308, "L2M1"},
		{0x328, "L2M2"},
		{0x348, "L2M3"},
		{0x368, "L2M4"},
		{0x388, "L2M5"},
		{0x3A8, "L2M6"},
		{0x3C8, "L2M7"},
		{0x468, "L2BM"},
		{unchecked((int)0xFFFFFE68), "L3CollectorCards"},
		{0x710, "L3Wasps"},
		{0x724, "L3Gags"},
		{0x70C, "L3CharacterClothing"},
		{0x708, "L3Vehicles"},  // Doesn't count cars won.
		{0x674, "L3TimeTrial"},
		{0x694, "L3CircuitRace"},
		{0x6B4, "L3CheckpointRace"},
		{0x574, "L3M1"},
		{0x594, "L3M2"},
		{0x5B4, "L3M3"},
		{0x5D4, "L3M4"},
		{0x5F4, "L3M5"},
		{0x614, "L3M6"},
		{0x634, "L3M7"},
		{0x6D4, "L3BM"},
		{unchecked((int)0xFFFFFE88), "L4CollectorCards"},
		{0x97C, "L4Wasps"},
		{0x990, "L4Gags"},
		{0x978, "L4CharacterClothing"},
		{0x974, "L4Vehicles"},  // Doesn't count cars won.
		{0x8E0, "L4TimeTrial"},
		{0x900, "L4CircuitRace"},
		{0x920, "L4CheckpointRace"},
		{0x7E0, "L4M1"},
		{0x800, "L4M2"},
		{0x820, "L4M3"},
		{0x840, "L4M4"},
		{0x860, "L4M5"},
		{0x880, "L4M6"},
		{0x8A0, "L4M7"},
		{0x940, "L4BM"},
		{unchecked((int)0xFFFFFEA8), "L5CollectorCards"},
		{0xBE8, "L5Wasps"},
		{0xBFC, "L5Gags"},
		{0xBE4, "L5CharacterClothing"},
		{0xBE0, "L5Vehicles"},  // Doesn't count cars won.
		{0xB4C, "L5TimeTrial"},
		{0xB6C, "L5CircuitRace"},
		{0xB8C, "L5CheckpointRace"},
		{0xA4C, "L5M1"},
		{0xA6C, "L5M2"},
		{0xA8C, "L5M3"},
		{0xAAC, "L5M4"},
		{0xACC, "L5M5"},
		{0xAEC, "L5M6"},
		{0xB0C, "L5M7"},
		{0xBAC, "L5BM"},
		{unchecked((int)0xFFFFFEC8), "L6CollectorCards"},
		{0xE54, "L6Wasps"},
		{0xE68, "L6Gags"},
		{0xE50, "L6CharacterClothing"},
		{0xE4C, "L6Vehicles"},  // Doesn't count cars won.
		{0xDB8, "L6TimeTrial"},
		{0xDD8, "L6CircuitRace"},
		{0xDF8, "L6CheckpointRace"},
		{0xCB8, "L6M1"},
		{0xCD8, "L6M2"},
		{0xCF8, "L6M3"},
		{0xD18, "L6M4"},
		{0xD38, "L6M5"},
		{0xD58, "L6M6"},
		{0xD78, "L6M7"},
		{0xE18, "L6BM"},
		{unchecked((int)0xFFFFFEE8), "L7CollectorCards"},
		{0x10C0, "L7Wasps"},
		{0x10D4, "L7Gags"},
		{0x10BC, "L7CharacterClothing"},
		{0x10B8, "L7Vehicles"},  // Doesn't count cars won.
		{0x1024, "L7TimeTrial"},
		{0x1044, "L7CircuitRace"},
		{0x1064, "L7CheckpointRace"},
		{0xF24, "L7M1"},
		{0xF44, "L7M2"},
		{0xF64, "L7M3"},
		{0xF84, "L7M4"},
		{0xFA4, "L7M5"},
		{0xFC4, "L7M6"},
		{0xFE4, "L7M7"},
		{0x1084, "L7BM"},
		{0x704, "BonusMovie"}
	};
	
	// Goes through the dictionary above and adds those pointers with the base address to the memory watcher list.
	vars.statWatchers = new MemoryWatcherList();
	foreach (var pointer in statPointers)
		vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, pointer.Key)) { Name = pointer.Value });
}

init
{
	// After bootup, the timer is allowed to start if needed.
	vars.canStart = true;
	
	// Version checking.
	switch (modules.First().ModuleMemorySize)
	{
		case 2965504:
			version = "FairLight";
			break;
	}
}

update
{
	if (version != "")
		return false;
	
	// Update all of the memory readings for the stats.
	vars.statWatchers.UpdateAll(game);
	
	// Checks if we have gotten into a new game (after the intro FMV) and if so toggles the variable on.
	// For runs from a save, this should immediately toggle it from it's initial value of false back to true.
	if (!vars.canStart && current.newGame == 1)
		vars.canStart = true;
	
	// Reset some variables when the timer is started, so we don't need to rely on the start action in this script.
	timer.OnStart += (s, e) => {
		vars.resetVariables();
		
		// Store the currently set level/mission in case this is being done from a save.
		vars.highestLevel = current.activeLevel;
		vars.highestMission[current.activeLevel] = current.activeMission;
	};
}

split
{
	if (version == "")
		return false;
	
	vars.doSplit = false;
	
	// If the settings for the level we are currently on are activated.
	if (settings["level"+(current.activeLevel+1)]) {
		// If the current mission we're on is the one above the last recorded highest number and we're on the same level.
		if (current.activeLevel == vars.highestLevel && current.activeMission == vars.highestMission[current.activeLevel]+1) {
			// Level 1's mission numbers works slightly differently.
			var onLevel1 = 0; if (current.activeLevel == 0) {onLevel1 = 1;}
			
			// If the setting for splitting the mission we just finished is set, split!
			if (settings["L"+(current.activeLevel+1)+"M"+(current.activeMission-onLevel1)])
				vars.doSplit = true;
		}
		
		// If the 100% settings for the level we are currently on are activated.
		if (settings["l"+(current.activeLevel+1)+"100%"]) {
			// If the bonus mission in the current level is done.
			if (settings["L"+(current.activeLevel+1)+"BM"]
			&& vars.statWatchers["L"+(current.activeLevel+1)+"BM"].Current > vars.statWatchers["L"+(current.activeLevel+1)+"BM"].Old)
				vars.doSplit = true;
			
			// If the time trial in the current level is done.
			if (settings["L"+(current.activeLevel+1)+"TimeTrial"]
			&& vars.statWatchers["L"+(current.activeLevel+1)+"TimeTrial"].Current > vars.statWatchers["L"+(current.activeLevel+1)+"TimeTrial"].Old)
				vars.doSplit = true;
			
			// If the circuit race in the current level is done.
			if (settings["L"+(current.activeLevel+1)+"CircuitRace"]
			&& vars.statWatchers["L"+(current.activeLevel+1)+"CircuitRace"].Current > vars.statWatchers["L"+(current.activeLevel+1)+"CircuitRace"].Old)
				vars.doSplit = true;
			
			// If the checkpoint race in the current level is done.
			if (settings["L"+(current.activeLevel+1)+"CheckpointRace"]
			&& vars.statWatchers["L"+(current.activeLevel+1)+"CheckpointRace"].Current > vars.statWatchers["L"+(current.activeLevel+1)+"CheckpointRace"].Old)
				vars.doSplit = true;
		}
	}
	
	// If we're past level 1 and the settings are activated for the previous level.
	if (current.activeLevel > 0 && settings["level"+current.activeLevel]) {
		// If we just moved a level higher and all of the missions have been done in the last level.
		if (current.activeLevel == vars.highestLevel+1 && vars.highestMission[vars.highestLevel] >= 6) {
			// If the setting for splitting the last mission on the level we just came from is set, split.
			if (settings["L"+(current.activeLevel)+"M7"])
				vars.doSplit = true;
		}
	}
	
	// Store the mission/level we are now on as the highest mission/level
	vars.highestMission[current.activeLevel] = current.activeMission;
	vars.highestLevel = current.activeLevel;
	
	// Final split for most full-game categories, as soon as the final FMV starts.
	if (settings["L7M7"] && vars.highestLevel == 6 && vars.highestMission[6] == 6 && current.lastVideoLoaded == "fmv7.rmv" && current.videoPlaying == 1)
		vars.doSplit = true;
	
	// If the settings for the misc. 100% stuff are activated.
	if (settings["misc100%"]) {
		// Coin grinding! Splits once they have more than 6200 coins and on "Set to Kill".
		if (settings["coinGrinding"] && !vars.coinGrindingDone && vars.highestLevel == 5 && vars.highestMission[5] == 5 && current.coinsTotal > 6200)
			vars.coinGrindingDone = true; vars.doSplit = true;
		
		// Splits once the bonus movie ticket has been picked up.
		if (settings["bonusMovie"] && vars.statWatchers["BonusMovie"].Current > vars.statWatchers["BonusMovie"].Old)
			vars.doSplit = true;
		
		// A split for Mango to help with his splits because this was in his terrible script.
		if (settings["mangosCard"] && vars.statWatchers["L5CollectorCards"].Old == 2 && vars.statWatchers["L5CollectorCards"].Current == 3)
			vars.doSplit = true;
		
		// Final split for 100%, once all goals that count towards 100% are completed.
		// While the game is booting (state 0) the values can be messed up so don't want to check then.
		if (settings["finalSplit100%"] && current.gameState > 0) {
			// Add the total objectives done together.
			var total = ((MemoryWatcherList)vars.statWatchers).Sum(x => (byte)x.Current);
			
			// If all of the objectives have been done, split!
			if (total == 393)
				vars.doSplit = true;
		}
	}
	
	if (vars.doSplit)
		return true;
}

start
{
	if (version == "")
		return false;
	
	// Done on the same frame as the reset, when a new game is started and the FMV is loaded in.
	return vars.canStart && current.mainMenu == 1 && current.newGame == 0 && current.lastVideoLoaded == "fmv1a.rmv";
}

reset
{
	if (version == "")
		return false;
	
	// Done on the same frame as the start split, when a new game is started and the FMV is loaded in.
	return current.mainMenu == 1 && current.newGame < old.newGame && current.lastVideoLoaded == "fmv1a.rmv";
}

isLoading
{
	if (version != "")
		// Load removing for most loading screens in the game.
		return current.gameState == 8
		|| (current.gameState == 10 && current.notLoading == 0 && current.paused != 1)
		|| (current.gameState == 2 && current.mainMenu == 0);
}