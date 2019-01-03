state("gta3")
{
	int versionCheck10 : 0x1C1E70; // 1407551829 if we're on version 1.0.
	int versionCheck11 : 0x1C2130; // 1407551829 if we're on version 1.1.
}

// These need to exist so they are actually found as versions by the code below.
state("gta3", "1.0") {}
state("gta3", "1.1") {}
state("gta3", "Steam") {}

startup
{
	// List of mission memory addresses (for Steam, see below for where offsets get added).
	vars.missionAddresses = new Dictionary<int, string> {
		{0x35B75C, "Give Me Liberty and Luigi's Girls"},
		{0x35B76C, "Don't Spank Ma Bitch Up"},
		{0x35B770, "Drive Misty For Me"},
		{0x35B80C, "The Crook"},
		{0x35B810, "The Thieves"},
		{0x35B814, "The Wife"},
		{0x35B818, "Her Lover"},
		{0x35B780, "Mike Lips Last Lunch"},
		{0x35B784, "Farewell 'Chunky' Lee Chong"},
		{0x35B788, "Van Heist"},
		{0x35B78C, "Cipriani's Chauffeur"},
		{0x35B79C, "Taking Out the Laundry"},
		{0x35B790, "Dead Skunk in the Trunk"},
		{0x35B838, "Turismo"},
		{0x35B794, "The Getaway"},
		{0x35B7A0, "The Pick-Up"},
		{0x35B970, "Patriot Playground"},
		{0x35B7A4, "Salvatore's Called a Meeting"},
		{0x35B7B4, "Chaperone"},
		{0x35B7B8, "Cutting the Grass"},
		{0x35B7A8, "Triads and Tribulations"},
		{0x35B774, "Pump-Action Pimp"},
		{0x35B9EC, "RC Diablo Destruction"},
		{0x35B778, "The Fuzz Ball"},
		{0x35B7E4, "I Scream, You Scream"},
		{0x35B7E8, "Trial By Fire"},
		{0x35B7EC, "Big 'N' Veiny"},
		{0x35B9F0, "RC Mafia Massacre"},
		{0x35B7AC, "Blow Fish"},
		{0x35B7BC, "Bomb Da Base: Act I"},
		{0x35B7C0, "Bomb Da Base: Act II"},
		{0x35B7C4, "Last Requests"},
		{0x35B878, "Sayonara Salvatore"},
		{0x35B8D4, "Bling-Bling Scramble"},
		{0x35B87C, "Under Surveillance"},
		{0x35B8AC, "Kanbu Bust Out"},
		{0x35B9F8, "RC Casino Calamity"},
		{0x35B8B0, "Grand Theft Auto"},
		{0x35B8D8, "Uzi Rider"},
		{0x35B97C, "Multistorey Mayhem"},
		{0x35B880, "Paparazzi Purge"},
		{0x35B884, "Payday For Ray"},
		{0x35B890, "Silence The Sneak"},
		{0x35B888, "Two-Faced Tanner"},
		{0x35B8B4, "Deal Steal"},
		{0x35B8B8, "Shima"},
		{0x35B8BC, "Smack Down"},
		{0x35B974, "A Ride In The Park"},
		{0x35B894, "Arms Shortage"},
		{0x35B898, "Evidence Dash"},
		{0x35B89C, "Gone Fishing"},
		{0x35B8DC, "Gangcar Round-Up"},
		{0x35B8A0, "Plaster Blaster"},
		{0x35B8E0, "Kingdom Come"},
		{0x35B8C4, "Liberator"},
		{0x35B8C8, "Waka-Gashira Wipeout"},
		{0x35B8CC, "A Drop In The Ocean"},
		{0x35B8FC, "Grand Theft Aero"},
		{0x35B8A4, "Marked Man"},
		{0x35B900, "Escort Service"},
		{0x35B9F4, "RC Rumpo Rampage"},
		{0x35B924, "Uzi Money"},
		{0x35B928, "Toyminator"},
		{0x35B92C, "Rigged to Blow"},
		{0x35B930, "Bullion Run"},
		{0x35B910, "Bait"},
		{0x35B904, "Decoy"},
		{0x35B908, "Love's Disappearance"},
		{0x35B914, "Espresso-2-Go!"},
		{0x35B918, "S.A.M. + Ransom"},
		{0x35B948, "The Exchange"},
		{0x35B934, "Rumble"},
		{0x35B978, "Gripped!"}
	};
	
	settings.Add("Missions", false, "Missions");
	
	// Adds missions to the settings and also to a separate list for easier checking later.
	vars.missionList = new List<string>();
	foreach (var address in vars.missionAddresses) {
		settings.Add(address.Value, false, address.Value, "Missions");
		vars.missionList.Add(address.Value);
	}
	
	// Setting for final split of Any%.
	settings.Add("btgFinalSplit", false, "Any% Final Split");
	settings.SetToolTip("btgFinalSplit", "Splits once you lose control on \"The Exchange\".");
	
	// Setting for final split of 100%.
	settings.Add("hundoFinalSplit", false, "100% Final Split");
	settings.SetToolTip("hundoFinalSplit", "Splits once you reach 100% game completion.");
}

init
{
	vars.offset = 0;
	vars.split = new List<string>();
	
	// Detects current game version if Steam.
	if (modules.First().ModuleMemorySize == 6197248)
	{
		version = "Steam";
		vars.offset = 0;
	}
	
	// 1.0 version check.
	else if (current.versionCheck10 == 1407551829) {
		version = "1.0";
		vars.offset = -0x10140;
	}
	
	// 1.1 version check.
	else if (current.versionCheck11 == 1407551829) {
		version = "1.1";
		vars.offset = -0x10140;
	}
	
	// Adds mission memory addresses (with the correct offset) to the watcher list.
	vars.memoryWatchers = new MemoryWatcherList();
	foreach (var address in vars.missionAddresses)
		vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(address.Key+vars.offset)) { Name = address.Value });
	
	// Add memory address for the "game state" to the watcher list.
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x505A2C+vars.offset)) { Name = "gameState" });
	
	// Memory addresses used for the final split of Any% (see below).
	vars.memoryWatchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x35F6B8+vars.offset)) { Name = "teHelipad" });
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x35BA2C+vars.offset)) { Name = "teTimer" });
	
	// Memory address used for percentage checking 
	vars.memoryWatchers.Add(new MemoryWatcher<int>(new DeepPointer(0x50651C+vars.offset)) { Name = "progressMade" });
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
	if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running)
		vars.split.Clear();
}

split
{
	// Goes through all the missions in the list, checks if their setting is enabled, if the mission has just been passed
	// and also if we haven't split for this mission yet. If so, splits.
	foreach (var mission in vars.missionList) {
		if (settings[mission] && vars.memoryWatchers[mission].Current > vars.memoryWatchers[mission].Old && !vars.split.Contains(mission)) {
			vars.split.Add(mission);
			return true;
		}
	}
	
	// Splits for the final split of Any%.
	if (settings["btgFinalSplit"] && vars.memoryWatchers["teHelipad"].Current == 1 && vars.memoryWatchers["teTimer"].Current != vars.memoryWatchers["teTimer"].Old)
		return true;
	if (settings["hundoFinalSplit"] && vars.memoryWatchers["progressMade"].Current == 154 && vars.memoryWatchers["progressMade"].Old != vars.memoryWatchers["progressMade"].Current)
		return true;
}

start
{
	// Starts the splits after the loading bar disappears.
	return vars.memoryWatchers["gameState"].Old == 8
	&& vars.memoryWatchers["gameState"].Current == 9;
}

reset
{
	// Resets the timer when the new game load starts.
	return vars.memoryWatchers["gameState"].Old == 9
	&& vars.memoryWatchers["gameState"].Current == 8;
}