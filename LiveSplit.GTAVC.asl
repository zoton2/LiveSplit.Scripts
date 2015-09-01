state("gta-vc")
{
	byte gameVersion : 0x208578;
}

// These need to exist so they are actually found as versions by the code below.
state("gta-vc", "1.0") {}
state("gta-vc", "1.1") {}
state("gta-vc", "steam") {}
state("gta-vc", "jp") {}

init
{
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
	
	vars.missionsDone = 0;
	
	// Used to know when the player starts a new game.
	vars.gameState = new MemoryWatcher<int>(new DeepPointer(0x5B5F10+vars.offset));
	
	// Lawyer
	vars.l1 = new MemoryWatcher<int>(new DeepPointer(0x421600+vars.offset));  // The Party
	vars.l2 = new MemoryWatcher<int>(new DeepPointer(0x421604+vars.offset));  // Back Alley Brawl
	vars.l3 = new MemoryWatcher<int>(new DeepPointer(0x421608+vars.offset));  // Jury Fury
	vars.l4 = new MemoryWatcher<int>(new DeepPointer(0x42160C+vars.offset));  // Riot
	
	// Kent Paul
	vars.kp1 = new MemoryWatcher<int>(new DeepPointer(0x421648+vars.offset));  // Death Row
	
	// Diaz
	vars.d1 = new MemoryWatcher<int>(new DeepPointer(0x42162C+vars.offset));  // The Chase
	vars.d2 = new MemoryWatcher<int>(new DeepPointer(0x421630+vars.offset));  // Phnom Penh '86
	vars.d3 = new MemoryWatcher<int>(new DeepPointer(0x421634+vars.offset));  // The Fastest Boat
	vars.d4 = new MemoryWatcher<int>(new DeepPointer(0x421638+vars.offset));  // Supply and Demand
	vars.d5 = new MemoryWatcher<int>(new DeepPointer(0x42163C+vars.offset));  // Rub Out
	
	// Vercetti
	vars.v1 = new MemoryWatcher<int>(new DeepPointer(0x4216A8+vars.offset));  // Shakedown
	vars.v2 = new MemoryWatcher<int>(new DeepPointer(0x4216AC+vars.offset));  // Bar Brawl
	vars.v3 = new MemoryWatcher<int>(new DeepPointer(0x4216B0+vars.offset));  // Cop Land
	vars.v4 = new MemoryWatcher<int>(new DeepPointer(0x4216B4+vars.offset));  // Cap the Collector
	
	// Colonel Cortez
	vars.c1 = new MemoryWatcher<int>(new DeepPointer(0x421614+vars.offset));  // Treacherous Swine
	vars.c2 = new MemoryWatcher<int>(new DeepPointer(0x421618+vars.offset));  // Mall Shootout
	vars.c3 = new MemoryWatcher<int>(new DeepPointer(0x42161C+vars.offset));  // Guardian Angels
	vars.c4 = new MemoryWatcher<int>(new DeepPointer(0x421620+vars.offset));  // Sir Yes Sir
	
	// Printworks
	vars.pw1 = new MemoryWatcher<int>(new DeepPointer(0x4216C0+vars.offset));  // Spilling the Beans
	vars.pw2 = new MemoryWatcher<int>(new DeepPointer(0x4216C4+vars.offset));  // Hit the Courier
	
	// Last split stuff on Keep Your Friends Close, not exactly sure what the values represent but they work!
	vars.kyfc1 = new MemoryWatcher<byte>(new DeepPointer(0x426104+vars.offset));
	vars.kyfc2 = new MemoryWatcher<int>(new DeepPointer(0x425DAC+vars.offset));
	vars.kyfc3 = new MemoryWatcher<int>(new DeepPointer(0x426100+vars.offset));
}

update
{
	// unknown version, don't do anything
	if (version == "")
		return;
	
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	
	// Updating all of the memory address values (probably a cleaner way to do this).
	vars.gameState.Update(game);
	vars.l1.Update(game);
	vars.l2.Update(game);
	vars.l3.Update(game);
	vars.l4.Update(game);
	vars.kp1.Update(game);
	vars.d1.Update(game);
	vars.d2.Update(game);
	vars.d3.Update(game);
	vars.d4.Update(game);
	vars.d5.Update(game);
	vars.v1.Update(game);
	vars.v2.Update(game);
	vars.v3.Update(game);
	vars.v4.Update(game);
	vars.c1.Update(game);
	vars.c2.Update(game);
	vars.c3.Update(game);
	vars.c4.Update(game);
	vars.pw1.Update(game);
	vars.pw2.Update(game);
	vars.kyfc1.Update(game);
	vars.kyfc2.Update(game);
	vars.kyfc3.Update(game);
	
	// Starting the splits after the initial new game load is done.
	if (vars.gameState.Old == 12 && vars.gameState.Current == 13) {
		vars.missionsDone = 0;
		vars.doStart = true;
	}
	
	// Resetting the splits if needed.
	if (vars.gameState.Old != 12 && vars.gameState.Current == 12) {
		vars.missionsDone = 0;
		vars.doReset = true;
	}
	
	// Splitting for missions (probably a cleaner way to do this).
	if (vars.missionsDone == 0 && vars.l1.Old == 0 && vars.l1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 1 && vars.l2.Old == 0 && vars.l2.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 2 && vars.l3.Old == 0 && vars.l3.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 3 && vars.l4.Old == 0 && vars.l4.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 4 && vars.c1.Old == 0 && vars.c1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 5 && vars.c2.Old == 0 && vars.c2.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 6 && vars.c3.Old == 0 && vars.c3.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 7 && vars.d1.Old == 0 && vars.d1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 8 && vars.d2.Old == 0 && vars.d2.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 9 && vars.d3.Old == 0 && vars.d3.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 10 && vars.d4.Old == 0 && vars.d4.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 11 && vars.c4.Old == 0 && vars.c4.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 12 && vars.kp1.Old == 0 && vars.kp1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 13 && vars.d5.Old == 0 && vars.d5.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 14 && vars.v1.Old == 0 && vars.v1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 15 && vars.v2.Old == 0 && vars.v2.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 16 && vars.v3.Old == 0 && vars.v3.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 17 && vars.pw1.Old == 0 && vars.pw1.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 18 && vars.pw2.Old == 0 && vars.pw2.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	if (vars.missionsDone == 19 && vars.v4.Old == 0 && vars.v4.Current == 1) {vars.doSplit = true; vars.missionsDone++;}
	
	// Final split (when control is lost on Keep Your Friends Closer).
	if (vars.missionsDone == 20 && vars.kyfc1.Current == 245 && vars.kyfc2.Current > vars.kyfc3.Current) {vars.doSplit = true;}
}

start
{
	return vars.doStart;
}

reset
{
	return vars.doReset;
}

split
{
	return vars.doSplit;
}