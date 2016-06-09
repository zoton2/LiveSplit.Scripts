state("OLGame")
{
	// unknown/default version
}

state("OLGame", "Patch2")
{
	int video : 0x01FFBCC8, 0x118;
}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case 35831808:
			version = "Patch2";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.video > 0;
}