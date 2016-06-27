state("FGUY")
{
	// unknown/default version
}

state("FGUY", "SKIDROW")
{
	byte loading : 0x7ADEB0;  // 0/1 if not loading/loading (the loading screen with Brian/Stewie).
	byte level : 0x6DCAA0;  // 0-10, 0 for the menu and 1-10 depending on what level you're on. >10 are for non-storyline stuff.
	byte videoPlaying : "binkw32.dll", 0x282EC; // 0/1 if a video not playing/playing.
	string4 lastVideoLoaded : 0x6CD828;  // Name of the last video that game loaded.
}

startup
{
	settings.Add("Level1", true, "1: It's All Greek To Me");
	settings.Add("Level2", true, "2: Something's Amish");
	settings.Add("Level3", true, "3: Handicapable");
	settings.Add("Level4", true, "4: Pussy Whipped");
	settings.Add("Level5", true, "5: No Cheese, Please");
	settings.Add("Level6", true, "6: Legend of Long John Peter");
	settings.Add("Level7", true, "7: Santa's Sweatshop");
	settings.Add("Level8", true, "8: Chickens in Space");
	settings.Add("Level9", true, "9: Chicken Fight!");
	settings.Add("Level10", true, "10: There's No Place Like Home");
	settings.SetToolTip("Level10", "Splits when you finish/skip the credits.");
}

init
{
	// Version checking.
	switch (modules.First().ModuleMemorySize)
	{
		case 8720384:
			version = "SKIDROW";
			break;
	}
}

update
{
	// Disables all the action blocks below in the code if the user is using an unsupported version.
	if (version == "")
		return false;
	
	vars.doResetStart = false;
	
	// Stores the curent phase the timer is in, so we can use the old one on the next frame.
	current.timerPhase = timer.CurrentPhase;
	
	// Starts when the player is on the 1st level and the "Family Guy intro" video has been loaded and playing.
	if (current.level == 1 && current.lastVideoLoaded == "V099" && old.videoPlaying < current.videoPlaying) {
		vars.doResetStart = true;
	}
	
	// Reset some variables when the timer is started, so we don't need to rely on the start action in this script.
	if ((old.timerPhase != current.timerPhase || vars.doResetStart) && current.timerPhase == TimerPhase.Running) {
		vars.watchingCredits = false;
		vars.highestLevel = 1;
	}
}

split
{
	vars.doSplit = false;
	
	// Splits when progressing to next level.
	if (vars.highestLevel+1 == current.level) {
		if (settings["Level"+vars.highestLevel])
			vars.doSplit = true;
		
		vars.highestLevel = current.level;
	}
	
	// Sets this variable to true when the credits are loaded in and are actually playing.
	if (current.level == 10 && current.lastVideoLoaded == "V999" && old.videoPlaying < current.videoPlaying)
		vars.watchingCredits = true;
	
	// Splits once the credits have been skipped/finished.
	if (settings["Level10"] && vars.watchingCredits && old.videoPlaying > current.videoPlaying)
		vars.doSplit = true;
	
	if (vars.doSplit)
		return true;
}

start
{
	return vars.doResetStart;
}

reset
{
	return vars.doResetStart;
}

isLoading
{
	return current.loading > 0;
}