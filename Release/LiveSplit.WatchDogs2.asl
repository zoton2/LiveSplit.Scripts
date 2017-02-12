/* IMPORTANT:
You need to add -eac_launcher to your launch options (in uPlay/Steam/shortcut) so the memory can be read.
This disables EasyAntiCheat (and online MP). If this doesn't seem to work, try restarting your PC.
(I know this sounds crazy but it actually worked for me and others online.)
See LiveSplit.WatchDogs2-README for more information.
*/

state("WatchDogs2")
{
	// unknown/default version
}

state("WatchDogs2", "v1.05.134.981608")
{
	int loading1 : "Disrupt_64.dll", 0x3D59E34;
	int loading2 : "Disrupt_64.dll", 0x3D061CC;
}

state("WatchDogs2", "v1.06.135.3.982778")
{
	int loading1 : "Disrupt_64.dll", 0x3D591E4;
	int loading2 : "Disrupt_64.dll", 0x3D0550C;
}

state("WatchDogs2", "v1.06.135.7.982778")
{
	int loading1 : "Disrupt_64.dll", 0x3D56984;
	int loading2 : "Disrupt_64.dll", 0x3D02B84;
}

state("WatchDogs2", "v1.07.141.6.988937")
{
	int loading1 : "Disrupt_64.dll", 0x3D13ECC;
	int loading2 : "Disrupt_64.dll", 0x3CBFB04;
}

state("WatchDogs2", "v1.09.152.2.996015")
{
	int loading1 : "Disrupt_64.dll", 0x3D19EBC;
	int loading2 : "Disrupt_64.dll", 0x3D07650;
}

state("WatchDogs2", "v1.09.154.1001103")
{
	int loading1 : "Disrupt_64.dll", 0x3D15AAC;
	int loading2 : "Disrupt_64.dll", 0x3D03270;
}

init
{
	switch (modules.FirstOrDefault(m => m.ModuleName.ToLower() == "disrupt_64.dll").ModuleMemorySize)
	{
		case 190935040:
			version = "v1.05.134.981608";
			break;
		case 188690432:
			version = "v1.06.135.3.982778";
			break;
		case 195903488:
			version = "v1.06.135.7.982778";
			break;
		case 188157952:
			version = "v1.07.141.6.988937";
			break;
		case 190164992:
			version = "v1.09.152.2.996015";
			break;
		case 187817984:
			version = "v1.09.154.1001103";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading1 > 0 || current.loading2 > 0;
}