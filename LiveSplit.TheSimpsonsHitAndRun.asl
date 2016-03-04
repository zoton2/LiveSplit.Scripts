// Bugs:
// > Reset does not work after startup if no save file is loaded beforehand, either because the user has none
//   or they use the "No Automatic Saved Game Load" mod in the mod launcher. Not a big issue though.
//   > This bug happens because the newGame variable needs to change from 1 to 0.

state("Simpsons")
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
	int activeMission : 0x2C8984, 0x110C;  // 0-6 (or 0-7 on level 1 cuz tutorial); doesn't change for bonus missions races.
	int activeLevel : 0x2C8984, 0x1108;  // 0-6 depending on what level you are on.
}

startup
{
	// Declaring variables and stuff.
	refreshRate = 30;
	
	// Add the levels settings parent.
	settings.Add("levels", false, "Levels");
	settings.SetToolTip("levels", "Splits when you move to the next level.");
	
	// Level 1 settings.
	settings.Add("level1", false, "Level 1", "levels");
	settings.CurrentDefaultParent = "level1";
	settings.Add("L1Tutorial", false, "Tutorial Mission");
	settings.Add("L1M1", false, "Mission 1");
	settings.Add("L1M2", false, "Mission 2");
	settings.Add("L1M3", false, "Mission 3");
	settings.Add("L1M4", false, "Mission 4");
	settings.Add("L1M5", false, "Mission 5");
	settings.Add("L1M6", false, "Mission 6");
	settings.Add("L1Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 2 settings.
	settings.Add("level2", false, "Level 2", "levels");
	settings.CurrentDefaultParent = "level2";
	settings.Add("L2M1", false, "Mission 1");
	settings.Add("L2M2", false, "Mission 2");
	settings.Add("L2M3", false, "Mission 3");
	settings.Add("L2M4", false, "Mission 4");
	settings.Add("L2M5", false, "Mission 5");
	settings.Add("L2M6", false, "Mission 6");
	settings.Add("L2Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 3 settings.
	settings.Add("level3", false, "Level 3", "levels");
	settings.CurrentDefaultParent = "level3";
	settings.Add("L3M1", false, "Mission 1");
	settings.Add("L3M2", false, "Mission 2");
	settings.Add("L3M3", false, "Mission 3");
	settings.Add("L3M4", false, "Mission 4");
	settings.Add("L3M5", false, "Mission 5");
	settings.Add("L3M6", false, "Mission 6");
	settings.Add("L3Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 4 settings.
	settings.Add("level4", false, "Level 4", "levels");
	settings.CurrentDefaultParent = "level4";
	settings.Add("L4M1", false, "Mission 1");
	settings.Add("L4M2", false, "Mission 2");
	settings.Add("L4M3", false, "Mission 3");
	settings.Add("L4M4", false, "Mission 4");
	settings.Add("L4M5", false, "Mission 5");
	settings.Add("L4M6", false, "Mission 6");
	settings.Add("L4Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 5 settings.
	settings.Add("level5", false, "Level 5", "levels");
	settings.CurrentDefaultParent = "level5";
	settings.Add("L5M1", false, "Mission 1");
	settings.Add("L5M2", false, "Mission 2");
	settings.Add("L5M3", false, "Mission 3");
	settings.Add("L5M4", false, "Mission 4");
	settings.Add("L5M5", false, "Mission 5");
	settings.Add("L5M6", false, "Mission 6");
	settings.Add("L5Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 6 settings.
	settings.Add("level6", false, "Level 6", "levels");
	settings.CurrentDefaultParent = "level6";
	settings.Add("L6M1", false, "Mission 1");
	settings.Add("L6M2", false, "Mission 2");
	settings.Add("L6M3", false, "Mission 3");
	settings.Add("L6M4", false, "Mission 4");
	settings.Add("L6M5", false, "Mission 5");
	settings.Add("L6M6", false, "Mission 6");
	settings.Add("L6Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Level 7 settings.
	settings.Add("level7", false, "Level 7", "levels");
	settings.CurrentDefaultParent = "level7";
	settings.Add("L7M1", false, "Mission 1");
	settings.Add("L7M2", false, "Mission 2");
	settings.Add("L7M3", false, "Mission 3");
	settings.Add("L7M4", false, "Mission 4");
	settings.Add("L7M5", false, "Mission 5");
	settings.Add("L7M6", false, "Mission 6");
	settings.Add("L7Bonus", false, "Bonus Mission");
	settings.CurrentDefaultParent = null;
	
	// Add the setting for the final non-100% split.
	settings.Add("finalSplit", false, "Final Split (non-100%)");
	settings.SetToolTip("finalSplit", "Splits as soon as the final FMV starts playing.");
	
	// Coin grinding setting!
	settings.Add("coinGrinding", false, "Coin Grinding (6200 L6M6)");
	settings.SetToolTip("coinGrinding", "Splits once you have more than 6200 coins and you're on \"Set to Kill\".");
	
	// Add the settings for picking up the bonus movie ticket.
	settings.Add("BonusMovie", false, "Bonus Movie");
	settings.SetToolTip("coinGrinding", "Splits when you pick up the ticket in the Android's Dungeon.");
	
	// Add the setting for the final 100% split.
	settings.Add("finalSplit100", false, "Final Split (100%)");
	settings.SetToolTip("finalSplit100", "Splits after every goal towards 100% has been completed.");
	
	// Stores all of the memory addresses for all of the specific (100%) stats in the game.
	vars.statWatchers = new MemoryWatcherList();
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFE28))) { Name = "L1CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x238)) { Name = "L1Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x24C)) { Name = "L1Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x234)) { Name = "L1CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x230)) { Name = "L1Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x19C)) { Name = "L1TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1BC)) { Name = "L1CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1DC)) { Name = "L1CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBC)) { Name = "L1M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xDC)) { Name = "L1M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xFC)) { Name = "L1M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x11C)) { Name = "L1M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x13C)) { Name = "L1M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x15C)) { Name = "L1M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x17C)) { Name = "L1M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1FC)) { Name = "L1BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFE48))) { Name = "L2CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x4A4)) { Name = "L2Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x4B8)) { Name = "L2Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x4A0)) { Name = "L2CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x49C)) { Name = "L2Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x408)) { Name = "L2TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x428)) { Name = "L2CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x448)) { Name = "L2CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x308)) { Name = "L2M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x328)) { Name = "L2M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x348)) { Name = "L2M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x368)) { Name = "L2M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x388)) { Name = "L2M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x3A8)) { Name = "L2M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x3C8)) { Name = "L2M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x468)) { Name = "L2BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFE68))) { Name = "L3CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x710)) { Name = "L3Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x724)) { Name = "L3Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x70C)) { Name = "L3CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x708)) { Name = "L3Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x674)) { Name = "L3TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x694)) { Name = "L3CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x6B4)) { Name = "L3CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x574)) { Name = "L3M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x594)) { Name = "L3M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x5B4)) { Name = "L3M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x5D4)) { Name = "L3M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x5F4)) { Name = "L3M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x614)) { Name = "L3M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x634)) { Name = "L3M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x6D4)) { Name = "L3BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFE88))) { Name = "L4CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x97C)) { Name = "L4Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x990)) { Name = "L4Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x978)) { Name = "L4CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x974)) { Name = "L4Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x8E0)) { Name = "L4TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x900)) { Name = "L4CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x920)) { Name = "L4CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x7E0)) { Name = "L4M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x800)) { Name = "L4M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x820)) { Name = "L4M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x840)) { Name = "L4M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x860)) { Name = "L4M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x880)) { Name = "L4M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x8A0)) { Name = "L4M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x940)) { Name = "L4BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFEA8))) { Name = "L5CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBE8)) { Name = "L5Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBFC)) { Name = "L5Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBE4)) { Name = "L5CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBE0)) { Name = "L5Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xB4C)) { Name = "L5TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xB6C)) { Name = "L5CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xB8C)) { Name = "L5CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xA4C)) { Name = "L5M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xA6C)) { Name = "L5M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xA8C)) { Name = "L5M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xAAC)) { Name = "L5M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xACC)) { Name = "L5M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xAEC)) { Name = "L5M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xB0C)) { Name = "L5M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xBAC)) { Name = "L5BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFEC8))) { Name = "L6CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xE54)) { Name = "L6Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xE68)) { Name = "L6Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xE50)) { Name = "L6CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xE4C)) { Name = "L6Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xDB8)) { Name = "L6TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xDD8)) { Name = "L6CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xDF8)) { Name = "L6CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xCB8)) { Name = "L6M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xCD8)) { Name = "L6M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xCF8)) { Name = "L6M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xD18)) { Name = "L6M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xD38)) { Name = "L6M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xD58)) { Name = "L6M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xD78)) { Name = "L6M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xE18)) { Name = "L6BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, unchecked((int)0xFFFFFEE8))) { Name = "L7CollectorCards" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x10C0)) { Name = "L7Wasps" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x10D4)) { Name = "L7Gags" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x10BC)) { Name = "L7CharacterClothing" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x10B8)) { Name = "L7Vehicles" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1024)) { Name = "L7TimeTrial" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1044)) { Name = "L7CircuitRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1064)) { Name = "L7CheckpointRace" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xF24)) { Name = "L7M1" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xF44)) { Name = "L7M2" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xF64)) { Name = "L7M3" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xF84)) { Name = "L7M4" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xFA4)) { Name = "L7M5" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xFC4)) { Name = "L7M6" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0xFE4)) { Name = "L7M7" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x1084)) { Name = "L7BM" });
	vars.statWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x2C8984, 0x704)) { Name = "BonusMovie" });
}

init
{
	// Declaring variables and stuff.
	vars.canStart = true;
	vars.highestLevel = 0;
	vars.coinGrindingDone = false;
}

update
{
	// Checks if we have gotten into a new game (after the intro FMV) and if so toggles the variable on.
	if (!vars.canStart && current.newGame > old.newGame) {vars.canStart = true;}
}

split
{
	// Could probably be done a bit neater, but this will do for now.
	// A check is done to make sure this is the furthest we've been in the game so far.
	if (current.activeLevel > vars.highestLevel) {
		// Keeps a record of the highest level we've been on in case someone backtracks so it doesn't split twice.
		vars.highestLevel = current.activeLevel;
		
		// If the parent setting for level splits is enabled, level splits are enabled.
		if (settings["levels"]) {
			if (settings["level1"] && old.activeLevel == 0 && current.activeLevel == 1) {return true;}
			if (settings["level2"] && old.activeLevel == 1 && current.activeLevel == 2) {return true;}
			if (settings["level3"] && old.activeLevel == 2 && current.activeLevel == 3) {return true;}
			if (settings["level4"] && old.activeLevel == 3 && current.activeLevel == 4) {return true;}
			if (settings["level5"] && old.activeLevel == 4 && current.activeLevel == 5) {return true;}
			if (settings["level6"] && old.activeLevel == 5 && current.activeLevel == 6) {return true;}
		}
	}
	
	// Final split for most full-game categories.
	if (settings["finalSplit"] && vars.highestLevel == 6 && current.lastVideoLoaded == "fmv7.rmv" && current.videoPlaying == 1) {return true;}
	
	// Coin grinding!
	if (settings["coinGrinding"] && !vars.coinGrindingDone && current.activeLevel == 5 && current.activeMission == 5 && current.coinsTotal > 6200) {
		vars.coinGrindingDone = true;
		return true;
	}
	
	// Splits once the bonus movie ticket has been picked up.
	if (settings["BonusMovie"] && vars.statWatchers["BonusMovie"].Current > vars.statWatchers["BonusMovie"].Old) {return true;}
	
	// Final split for 100%, once all goals that count towards 100% are completed.
	// While the game is booting (state 0) the values can be messed up so don't wanna check there!
	if (settings["finalSplit100"] && current.gameState > 0) {
		// Update memory watchers and add the total objectives done together.
		vars.statWatchers.UpdateAll(game);
		var total = ((MemoryWatcherList)vars.statWatchers).Sum(x => (byte)x.Current);
		
		// If all of the objectives have been done, split!
		if (total == 393) {return true;}
	}
}

start
{
	// Technically we could just check newGame but I put the other ones in for safety.
	// Done on the same frame as the reset, when a new game is started and the FMV is loaded in.
	if (vars.canStart && current.mainMenu == 1 && current.newGame == 0 && current.lastVideoLoaded == "fmv1a.rmv") {
		// Resetting variables.
		vars.canStart = false;
		vars.highestLevel = 0;
		vars.coinGrindingDone = false;
		
		return true;
	}
}

reset
{
	// Technically we could just check newGame but I put the other ones in for safety.
	// Done on the same frame as the start split, when a new game is started and the FMV is loaded in.
	return current.mainMenu == 1 && current.newGame < old.newGame && current.lastVideoLoaded == "fmv1a.rmv";
}

isLoading
{
	return current.gameState == 8 || (current.gameState == 10 && current.notLoading == 0 && current.paused != 1) || (current.gameState == 2 && current.mainMenu == 0);
}