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

state("GTA5", "RGSC5052")
{
	int loading : 0x21ED980;
}

state("GTA5", "Steam5052")
{
	int loading : 0x21F1C00;
}

state("GTA5", "RGSC5731")
{
	int loading : 0x2209F30;
}

state("GTA5", "Steam5731")
{
	int loading : 0x220E020;
}

state("GTA5", "RGSC6171")
{
	int loading : 0x220D0B0;
}

state("GTA5", "Steam6171")
{
	int loading : 0x22102B0;
}

init
{
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
		case 70279168:
			version = "RGSC5052";
			break;
		case 70773760:
			version = "Steam5052";
			break;
		case 70818816:
			version = "RGSC5731";
			break;
		case 70642176:
			version = "Steam5731";
			break;
		case 72008704:
			version = "RGSC6171";
			break;
		case 70954496:
			version = "Steam6171";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading > 0;
}