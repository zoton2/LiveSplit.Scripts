state("TOD")
{
	// unknown/default version
}

state("TOD", "GOG")
{
	int loading : 0x63DFF0, 0x2F8, 0xD0, 0x38, 0x348, 0x124;
}

init
{
	switch (modules.First().ModuleMemorySize)
	{
		case 7045120:
			version = "GOG";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading > 0;
}