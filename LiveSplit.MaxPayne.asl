state("maxpayne")
{
	// unknown/default version
}

state("maxpayne", "Steam")
{
	int loading : 0x46B994, 0x48, 0xB4;
	int comic : "e2mfc.dll", 0x651DC;
}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case 6377472: // Steam (DRM)
		case 6025216: // Steam (Steamless)
			version = "Steam";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading > 0 && current.comic == 0;
}