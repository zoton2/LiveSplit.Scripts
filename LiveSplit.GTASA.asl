state("gta_sa")
{
	int versionCheck10US : 0x42457C;   // Version 1.0 US
	int versionCheck10EU : 0x4245BC;   // Version 1.0 EU/AUS or 1.0 US Hoodlum or 1.0 Downgraded
	int versionCheck101US : 0x4252FC;  // Version 1.01 US
	int versionCheck101EU : 0x42533C;  // Version 1.01 EU/AUS or 1.01 Deviance or 1.01 Downgraded
}

// These need to exist so they are actually found as versions by the code below.
state("gta_sa", "1.0") {}
state("gta_sa", "1.01") {}
state("gta_sa", "steam3.0") {}  // filename is usually gta_sa, need to find out a way to check for that.

init
{
	// Declaring variables.
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	vars.offset = 0;
	vars.startGameVal = 1;
	
	// Read category from split file
	vars.category = timer.Run.CategoryName.ToLower();
	
	// Workaround for identifying the Steam version correctly.
	// If the game is started after LiveSplit, the other method doesn't work.
	/*if (modules.First().ModuleMemorySize == 6905856)
	{
		version = "steam";
		vars.offset = -0xFF8;
	}*/
	
	// Detects current game version if not Steam.
	//else
	//{
		if (current.versionCheck10US == 38079 || current.versionCheck10EU == 38079)
		{
			version = "1.0";
			vars.offset = 0;
		}
		
		else if (current.versionCheck101US == 38079 || current.versionCheck101EU == 38079)
		{
			version = "1.01";
			vars.offset = 0x2680;
		}
	//}
	
	vars.watchers = new MemoryWatcherList();
	
	if (version == "steam3.0")
	{
		// i will do these at some point
	}
	
	//NOT TESTED FOR 1.01
	else
	{
		vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x77CEDC+vars.offset)) { Name = "StartGame_A" });
		vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x7A67A5+vars.offset)) { Name = "LoadingGame_A" });
		vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x7A68A5+vars.offset)) { Name = "NewGameDialog_A" });
		vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(0x7A67A4+vars.offset)) { Name = "IsInMenu_A" });
	}
	
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A060+vars.offset)) { Name = "Intro_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A070+vars.offset)) { Name = "Sweet_A1" });         // First set of sweet's adresses
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A088+vars.offset)) { Name = "Sweet_A2" });         // 2nd set
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A32C+vars.offset)) { Name = "Sweet_A3" });         // LS2 part 1
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A334+vars.offset)) { Name = "Sweet_A4" });         // LS2 part 2
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A074+vars.offset)) { Name = "Ryder_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A078+vars.offset)) { Name = "BigSmoke_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A07C+vars.offset)) { Name = "OGLoc_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A080+vars.offset)) { Name = "CRASH_A1" });         // LS1 part of C.R.A.S.H.
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A114+vars.offset)) { Name = "CRASH_A2" });         // RC & W part
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A1E8+vars.offset)) { Name = "CRASH_A3" });         // SF part (search when value is 2, 1 is for 555 WE TIP)
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A2B8+vars.offset)) { Name = "CRASH_A4" });         // LV part
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A084+vars.offset)) { Name = "Cesar_A1" });         // LS1 of Cesar Vialpando
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64BB2C+vars.offset)) { Name = "Cesar_A2" });         // RC & W King In Exile cutscene
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64BDC8+vars.offset)) { Name = "Cesar_A3" });         // RC & W Part 2
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x649A60+vars.offset)) { Name = "Catalina_A0" });      // General addresses for all missions (Not used)
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A488+vars.offset)) { Name = "Catalina_A1" });      // Local Liquor Store
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A48C+vars.offset)) { Name = "Catalina_A2" });      // Small Town Bank
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A490+vars.offset)) { Name = "Catalina_A3" });      // Tanker Commander
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A494+vars.offset)) { Name = "Catalina_A4" });      // Against all Odds
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A10C+vars.offset)) { Name = "Truth_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A1D4+vars.offset)) { Name = "Doherty" });          // 555 WE TIP not included search for CRASH_A3 = 1
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A1E4+vars.offset)) { Name = "TriadsLoco_A" });     // Loco part is from when value is {3,4,5}
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A1DC+vars.offset)) { Name = "WuZiMu_A" });
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A2A4+vars.offset)) { Name = "Toreno_A" });         // Learning to Fly included (value 5), Verdant Meadows included value = {6,7,8,9}
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x68EA6C+vars.offset)) { Name = "Flight_A" });         // Propery Bought address
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A2B4+vars.offset)) { Name = "FourDragonsCP_A" });  // Caligula's included value = {5,6,8,9}
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A2BC+vars.offset)) { Name = "MaddDogg_A1" });      // LV part
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x64A328+vars.offset)) { Name = "MaddDogg_A2" });      // LS2 part (FourDragon's mission included value = 1)
	vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(0x651698+vars.offset)) { Name = "EndGame_A" });        // Something to do with last mission;
}

update
{
	vars.doStart = false;
	vars.doReset = false;
	vars.doSplit = false;
	
	// unknown version, don't do anything
	if (version == "")
		return;
	
	vars.watchers.UpdateAll(game);
	
	// Works out the current real time in seconds, so it can be compared to.
	var currentRealTime = timer.CurrentTime.RealTime.ToString();
	var currentRealTimeInSeconds = TimeSpan.Parse(currentRealTime).TotalSeconds;
	
	if (vars.watchers["StartGame_A"].Current == vars.startGameVal)
	{
		vars.doStart = true;
	}
	
	// this resets the splits if the game closes
	else if (vars.watchers["StartGame_A"].Current == 0 && vars.watchers["StartGame_A"].Old > 0)
	{
		if (vars.startGameVal != 2) {vars.startGameVal = 2;}
		vars.doReset = true;
	}
}

start {return vars.doStart;}
reset {return vars.doReset;}
split {return vars.doSplit;}