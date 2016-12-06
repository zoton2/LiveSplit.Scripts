/* IMPORTANT:
You need to add -eac_launcher to your launch options (in uPlay/Steam/shortcut) so the memory can be read.
This disables EasyAntiCheat (and online MP). If this doesn't seem to work, try restarting your PC.
(I know this sounds crazy but it actually worked for me and others online.)
*/

state("WatchDogs2")
{
	// unknown/default version
}

state("WatchDogs2", "v1.05.134")
{
	int loading1 : "Disrupt_64.dll", 0x3D59E34;
	int loading2 : "Disrupt_64.dll", 0x3D061CC;
}

state("WatchDogs2", "v1.06.135.3")
{
	int loading1 : "Disrupt_64.dll", 0x3D591E4;
	int loading2 : "Disrupt_64.dll", 0x3D0550C;
}

init
{
	switch (modules.FirstOrDefault(m => m.ModuleName.ToLower() == "disrupt_64.dll").ModuleMemorySize)
	{
		case 190935040:
			version = "v1.05.134";
			break;
		case 188690432:
			version = "v1.06.135.3";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading1 > 0 || current.loading2 > 0;
}