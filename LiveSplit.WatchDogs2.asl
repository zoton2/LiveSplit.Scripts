// you need to add -eac_launcher to your launch options so the memory can be read

state("WatchDogs2")
{
	// unknown/default version
}

state("WatchDogs2", "v1.06.135.3.982778")
{
	int loading : "Disrupt_64.dll", 0x3D591E4;
}

init
{
	switch (modules.FirstOrDefault(m => m.ModuleName.ToLower() == "disrupt_64.dll").ModuleMemorySize)
	{
		case 188690432:
			version = "v1.06.135.3.982778";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading > 0;
}