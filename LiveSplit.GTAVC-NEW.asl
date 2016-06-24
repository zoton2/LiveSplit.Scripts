state("gta-vc")
{
	byte gameVersion : 0x208578;  // Used to detect the version (works for all versions beside Steam).
}

state("gta-vc", "1.0")
{
	int islandLoad : 0x305310;
	int loadSaveLoad : 0x38D724;
    int replayLoad : 0x38A72C;
	byte genLoad : 0x2F7759;
}

state("gta-vc", "1.1")
{
	int islandLoad : 0x305310;
	int loadSaveLoad : 0x38D72C;
    int replayLoad : 0x38A72C;
	byte genLoad : 0x2F7759;
}

state("gta-vc", "Steam")
{
	int islandLoad : 0x304310;
	int loadSaveLoad : 0x38E71C;
    int replayLoad : 0x389734;
	byte genLoad : 0x2F6759;
}

//state("testapp", "Steam") {} // needs properly implementing

state("gta-vc", "Japanese")
{
	int islandLoad : 0x302310;
	int loadSaveLoad : 0x38A72C;
    int replayLoad : 0x387734;
	byte genLoad : 0x2F4759;
}

startup
{
	// List of mission memory addresses (for 1.0, see below for where offsets get added).
	vars.missionAddresses = new Dictionary<int, string> {
		{0x421600, "The Party"},
		{0x421604, "Back Alley Brawl"},
		{0x421608, "Jury Fury"},
		{0x42160C, "Riot"},
		{0x421614, "Treacherous Swine"},
		{0x421728, "Road Kill"},
		{0x421618, "Mall Shootout"},
		{0x42161C, "Guardian Angels"},
		{0x42162C, "The Chase"},
		{0x42172C, "Waste The Wife"},
		{0x421630, "Phnom Penh '86"},
		{0x421634, "The Fastest Boat"},
		{0x421638, "Supply and Demand"},
		{0x421620, "Sir Yes Sir"},
		{0x421650, "Four Iron"},
		{0x421648, "Death Row"},
		{0x42163C, "Rub Out"},
		{0x4216A8, "Shakedown"},
		{0x421684, "Recruitment Drive"},
		{0x421688, "Dildo Dodo"},
		{0x4216C0, "Spilling the Beans"},
		{0x4216C4, "Hit the Courier"},
		{0x4216AC, "Bar Brawl"},
		{0x421730, "Autocide"},
		{0x421624, "All Hands On Deck"},
		{0x42168C, "Martha's Mug Shot"},
		{0x421690, "G-Spotlight"},
		{0x421654, "Demolition Man"},
		{0x421658, "Two Bit Hit"},
		{0x421750, "V.I.P."},
		{0x421734, "Check Out At The Check In"},
		{0x421700, "Love Juice"},
		{0x421704, "Psycho Killer"},
		{0x4216CC, "Alloy Wheels Of Steel"},
		{0x4216D0, "Messing With The Man"},
		{0x4216D4, "Hog Tied"},
		{0x4216B0, "Cop Land"},
		{0x421754, "Friendly Rivalry"},
		{0x421758, "Cabmaggedon"},
		{0x421660, "No Escape?"},
		{0x4216DC, "Stunt Boat Challenge"},
		{0x421664, "The Shootist"},
		{0x421708, "Publicity Tour"},
		{0x421668, "The Driver"},
		{0x42166C, "The Job"},
		{0x4216F0, "Juju Scramble"},
		{0x4216F4, "Bombs Away!"},
		{0x421738, "Loose Ends"},
		{0x4216B4, "Cap the Collector"},
		{0x4216F8, "Dirty Lickin's"},
		{0x421678, "Gun Runner"},
		{0x42167C, "Boomshine Saigon"},
		{0x4216E0, "Cannon Fodder"},
		{0x4216E4, "Naval Engagement"},
		{0x4216E8, "Trojan Voodoo"},
		{0x4216B8, "Keep Your Friends Close"},
		{0x421BFC, "Checkpoint Charlie"}
	};
	
	settings.Add("Missions", false, "Missions");
	
	// Adds missions to the settings and also to a separate list for easier checking later.
	vars.missionList = new List<string>();
	foreach (var address in vars.missionAddresses) {
		settings.Add(address.Value, false, address.Value, "Missions");
		vars.missionList.Add(address.Value);
	}
	
	settings.Add("btgFinalSplit", false, "Any% Final Split");
	settings.SetToolTip("btgFinalSplit", "Splits once you lose control on \"Keep Your Friends Close\".");
}

init
{
	vars.offset = 0;
	vars.split = new List<string>();
	
	// Detects current game version if Steam.
	if (modules.First().ModuleMemorySize == 6905856)
	{
		version = "Steam";
		vars.offset = -0xFF8;
	}
	
	else {
		// Detects current game version if not Steam.
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
			case 68:
				version = "Japanese";
				vars.offset = -0x2FF8;
				break;
		}
	}
	
	// Adds mission memory addresses (with the correct offset) to the watcher list.
	vars.memoryWatchers = new MemoryWatcherList();
	foreach (var address in vars.missionAddresses)
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(address.Key+vars.offset)) { Name = address.Value });
	
	// Add correct memory address for the "game state" to the watcher list.
	var gameStateAddress = (version == "Japanese") ? 0x5B2F18 : 0x5B5F08+vars.offset;
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(gameStateAddress)) { Name = "gameState" });
	
	// Japanese game state is shifted by +4 (due to more intro movies) so needs to be taken into account later.
	vars.gameStateShift = (version == "Japanese") ? 4 : 0;
	
	// Used to know when the player loads a saved game. 0 if so and 1 if not.
	// This is needed so the timer doesn't start if you load a save game after the initial boot up.
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x574B74+vars.offset)) { Name = "notLoadingCheck" });
	
	// Memory addresses used for the final split of Any% (see below).
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset)) { Name = "kyfc1" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset)) { Name = "kyfc2" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset)) { Name = "kyfc3" });
}

update
{
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (version == "")
		return false;
	
	// Stores the curent phase the timer is in, so we can use the old one on the next frame.
	current.timerPhase = timer.CurrentPhase;
	
	// Update all of the memory readings for the mission memory addresses.
	vars.memoryWatchers.UpdateAll(game);
	
	// Reset some variables when the timer is started, so we don't need to rely on the start action in this script.
	if (old.timerPhase != current.timerPhase && current.timerPhase == TimerPhase.Running) {
		vars.split.Clear();
	}
}

split
{
	vars.doSplit = false;
	
	// Goes through all the missions in the list, checks if their setting is enabled, if the mission has just been passed
	// and also if we haven't split for this mission yet. If so, splits.
	foreach (var mission in vars.missionList) {
		if (settings[mission] && vars.memoryWatchers[mission].Current > vars.memoryWatchers[mission].Old && !vars.split.Contains(mission)) {
			vars.doSplit = true; vars.split.Add(mission);
		}
	}
	
	// Splits for the final split of Any%.
	if (settings["btgFinalSplit"] && vars.memoryWatchers["kyfc1"].Current == 245 && vars.memoryWatchers["kyfc2"].Current > vars.memoryWatchers["kyfc3"].Current)
		vars.doSplit = true;
	
	if (vars.doSplit)
		return true;
}

start
{
	// Starts the splits when the new game load has been completed (and is not a save).
	return vars.memoryWatchers["gameState"].Old == 8+vars.gameStateShift
	&& vars.memoryWatchers["gameState"].Current == 9+vars.gameStateShift
	&& vars.memoryWatchers["notLoadingCheck"].Current == 1;
}

reset
{
	// Resets the timer when the new game load starts but only if the timer isn't over 19 seconds yet.
	return vars.memoryWatchers["gameState"].Old == 9+vars.gameStateShift
	&& vars.memoryWatchers["gameState"].Current == 8+vars.gameStateShift
	&& TimeSpan.Parse(timer.CurrentTime.RealTime.ToString()).TotalSeconds > 19;
}

isLoading
{
	// Load removing for loading screens in the game (found by Mhmd_FVC).
	return current.islandLoad > 0 || current.loadSaveLoad > 0 || current.replayLoad > 0 || current.genLoad > 0;
}