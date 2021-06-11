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

state("WatchDogs2", "v1.011.174.3.1009368")
{
	int loading1 : "Disrupt_64.dll", 0x3E67CAC;
	int loading2 : "Disrupt_64.dll", 0x3E116E4;
}

state("WatchDogs2", "v1.011.174.6.1009368")
{
	int loading1 : "Disrupt_64.dll", 0x3E69E1C;
	int loading2 : "Disrupt_64.dll", 0x3E13B34;
	int followers : "Disrupt_64.dll", 0x3E157F0, 0xD0, 0x40, 0xD0, 0x80, 0x38, 0x30, 0xC0;
	int lineId : "Disrupt_64.dll", 0x3C82108, 0x288, 0x90, 0x190, 0xB8, 0x9E8;
}

state("WatchDogs2", "v1.017.189.2.1088394")
{
	int loading1 : "Disrupt_64.dll", 0x401E824;
	int loading2 : "Disrupt_64.dll", 0x3FC34B4;
	int followers : "Disrupt_64.dll", 0x401AC10, 0xC8, 0x8, 0x168, 0xE0, 0xC0;
	int lineId : "Disrupt_64.dll", 0x400FA90, 0x28;
}

startup
{
	settings.Add("BuyPants", false, "Split for buying pants");
	settings.SetToolTip("BuyPants", "Splits after buying pants at the beginning of the game.");

	vars.stopwatch = new Stopwatch();

	Action<string> logDebug = (text) => {
		print("[Watch_Dogs 2 Autosplitter | DEBUG] " + text);
	};
	vars.logDebug = logDebug;

	vars.lastSplitTime = null;
	Func<bool> isNotDoubleSplit = () => {
		bool isDoubleSplit = false;
		if (vars.lastSplitTime != null) {
			System.TimeSpan ts = System.DateTime.Now - vars.lastSplitTime;
			if (ts.TotalSeconds < 15) {
				isDoubleSplit = true;
				vars.logDebug("Double split detected!");
			}
		}
		vars.lastSplitTime = System.DateTime.Now;
		return !isDoubleSplit;
	};
	vars.isNotDoubleSplit = isNotDoubleSplit;
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
		case 191721472:
			version = "v1.011.174.3.1009368";
			break;
		case 191381504:
			version = "v1.011.174.6.1009368";
			break;
		case 202059776:
		case 356388864: // Needs fully testing!
			version = "v1.017.189.2.1088394";
			break;
	}
}

isLoading
{
	if (version != "")
		return current.loading1 > 0 || current.loading2 > 0;
}

update
{
	if (vars.stopwatch.ElapsedMilliseconds > 10000)
		vars.stopwatch.Reset();
	if (old.lineId == 658798)
		vars.stopwatch.Start();
}

start
{
	if (current.lineId == 693964)
		vars.stopwatch.Start();
	if (current.lineId == 693964 && vars.stopwatch.ElapsedMilliseconds > 5066.67)
		return true;
}

split
{
	if (settings["Buy Pants"] && current.followers == old.followers + 2200) // Buying Pants Finished
		return true;
	if (old.lineId == 658785 && vars.stopwatch.ElapsedMilliseconds > 600) // Walk in the Park Finished
		return vars.isNotDoubleSplit();
	if (current.followers == old.followers + 46000) // Cyberdriver Finished
		return true;
	if (current.followers == old.followers + 96000) // False Profits Finished
		return true;
	if (current.followers == old.followers + 87000) // Haum Sweet Haum Finished
		return true;
	if (current.followers == old.followers + 200000) // Looking Glass or Limp Nudle Finished
		return true;
	if (current.followers == old.followers + 233000) // Hacker War Finished
		return true;
	if (current.followers == old.followers + 242000) // W4tched Finished
		return true;
	if (current.followers == old.followers + 234900) // Eye for an Eye Finished
		return true;
	if (current.followers == old.followers + 364000) // Hack teh World Finished
		return true;
	if (current.followers == old.followers + 542400) // Shanghaied Finished
		return true;
	if (current.followers == old.followers + 402800) // Power to the Sheeple Finished
		return true;
	if (current.followers == old.followers + 464000) // Robot Wars Finished
		return true;
}
