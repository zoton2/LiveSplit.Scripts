// Should work, just needs checking if this works the same as the external app already available.

state("GTA5")
{
	// unknown/default version
}

state("GTA5", "RGSC3722")
{
	int loading : 0x2153C30;
}

state("GTA5", "RGSC3934")
{
	int loading : 0x21C94C0;
}

state("GTA5", "Steam3934")
{
	int loading : 0x21CC740;
}

state("GTA5", "RGSC4631")
{
	int loading : 0x21D3DB0;
}

state("GTA5", "Steam4631")
{
	int loading : 0x21D7010;
}

init
{
	// Declaring variables.
	vars.isLoading = true;
	
	switch (modules.First().ModuleMemorySize)
	{
		case 70718464:
			version = "RGSC3722";
			break;
		case 70944768:
			version = "RGSC3934";
			break;
		case 71725056:
			version = "Steam3934";
			break;
		case 70275072:
			version = "RGSC4631";
			break;
		case 70901760:
			version = "Steam4631";
			break;
	}
}

update
{
	if (version == "")
		return;
	
	vars.isLoading = true;
		
	if (current.loading == 0) {vars.isLoading = false;}
}

isLoading {return vars.isLoading;}