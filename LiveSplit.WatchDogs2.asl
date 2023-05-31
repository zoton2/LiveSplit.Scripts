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
	int lineId : "Disrupt_64.dll", 0x3C82108, 0x288, 0x90, 0x190, 0xB8, 0x9E8;
}

state("WatchDogs2", "v1.017.189.2.1088394")
{
	int loading1 : "Disrupt_64.dll", 0x401E824;
	int loading2 : "Disrupt_64.dll", 0x3FC34B4;
	int lineId : "Disrupt_64.dll", 0x400FA90, 0x28;
	float percent : "Disrupt_64.dll", 0x0401AC10, 0x74;
}

startup
{
	settings.Add ("Walk in the Park", true, "Walk in the Park");
	settings.Add ("Cyberdriver", true, "Cyberdriver");
	settings.Add ("False Profits", true, "False Profits");
	settings.Add ("Haum Sweet Haum", true, "Haum Sweet Haum");
	settings.Add ("Looking Glass", true, "Looking Glass");
	settings.Add ("Alphabet Soup", true, "Alphabet Soup");
	settings.Add ("Hacker War", true, "Hacker War");
	settings.Add ("W4tched", true, "W4tched");
	settings.Add ("Eye for an Eye", true, "Eye for an Eye");
	settings.Add ("Hack teh World", true, "Hack teh World");
	settings.Add ("Shanghaied", true, "Shanghaied");
	settings.Add ("Power to the Sheeple", true, "Power to the Sheeple");
	settings.Add ("Robot Wars", true, "Robot Wars");
	
	settings.CurrentDefaultParent = "Walk in the Park";
	settings.Add("Walk in the Park 1", false, "Splits after completing Walk in the Park");
		settings.SetToolTip("Walk in the Park 1", "Splits after completing Walk in the Park if you skip all lines with the guy by holding the skip button");
	settings.Add("Carcani", false, "Split for Carcani call after Walk in the Park");
		settings.SetToolTip("Carcani", "Splits for Carcani call after Walk in the Park");

	settings.CurrentDefaultParent = "Cyberdriver";
	settings.Add("Hack and Run", true, "Hack and Run");
	settings.Add("Get Smart Car", true, "Get Smart Car");
	settings.Add("Cyber Stunt Driver", true, "Cyber Stunt Driver");
	
	settings.CurrentDefaultParent = "False Profits";
	settings.Add("Sunday Schooled 1", false, "Sunday Schooled 1");
		settings.SetToolTip("Sunday Schooled 1", "Splits during 1st phone call when you've escaped the area");
	settings.Add("Sunday Schooled 2", false, "Sunday Schooled 2");
		settings.SetToolTip("Sunday Schooled 2", "Splits after both phone calls at the end of the mission");
	settings.Add("Mindfuck", true, "Mindfuck");
	settings.Add("Missing Persons", true, "Missing Persons");
	settings.Add("Blasphemer", true, "Blasphemer");

	settings.CurrentDefaultParent = "Haum Sweet Haum";
	settings.Add("Heist Sweet Heist", true, "Heist Sweet Heist");
	settings.Add("Lord of the Wifis", true, "Lord of the Wifis");
	settings.Add("Swimming Upstream", true, "Swimming Upstream");
	settings.Add("Horizontal and the Vertical", true, "Horizontal and the Vertical");

	settings.CurrentDefaultParent = "Looking Glass";
	settings.Add("Invite to Mayhem", true, "Invite to Mayhem");
	settings.Add("R&R", true, "R&R");
	
	settings.CurrentDefaultParent = "Alphabet Soup";
	settings.Add("Limp Nudle", true, "Limp Nudle");

	settings.CurrentDefaultParent = "Hacker War";
	settings.Add("Lenni's Demands", true, "Lenni's Demands");
	settings.Add("Sabotage", true, "Sabotage");
	settings.Add("Bunker Bust", true, "Bunker Bust");	

	settings.CurrentDefaultParent = "W4tched";
	settings.Add("Peeping Toms", true, "Peeping Toms");
	settings.Add("Cabbie for Hire", true, "Cabbie for Hire");
	settings.Add("Dellums Towers", true, "Dellums Towers");
	settings.Add("Wrench in the Works", true, "Wrench in the Works");

	settings.CurrentDefaultParent = "Eye for an Eye";
	settings.Add("Lost Call", true, "Lost Call");
	settings.Add("A Brutal Discovery", true, "A Brutal Discovery");
	settings.Add("Shipwreck", true, "Shipwreck");
	settings.Add("Root Canal", true, "Root Canal");
	settings.Add("A Real Dogfight", true, "A Real Dogfight");

	settings.CurrentDefaultParent = "Hack teh World";
	settings.Add("Get Cray with Ray", true, "Get Cray with Ray");
	settings.Add("Hangar On", true, "Hangar On");
	settings.Add("All-Seeing Eye", true, "All-Seeing Eye");
	
	settings.CurrentDefaultParent = "Shanghaied";
	settings.Add("Down by the Docks", true, "Down by the Docks");
	settings.Add("Chinatown Shuffle", true, "Chinatown Shuffle");
	settings.Add("Nice View", true, "Nice View");
	settings.Add("They're on a Boat", true, "They're on a Boat");
	
	settings.CurrentDefaultParent = "Power to the Sheeple";
	settings.Add("Mark Up", false, "Mark Up");
		settings.SetToolTip("Mark Up", "Splits after phone calls at the end of the mission");
	settings.Add("A Tempting Invitation", true, "A Tempting Invitation");
	settings.Add("Compromised Candidate", true, "Compromised Candidate");
	settings.Add("Voting Machinations", true, "Voting Machinations");

	settings.CurrentDefaultParent = "Robot Wars";
	settings.Add("Drop the Baby", true, "Drop the Baby");
	settings.Add("Man vs Machine", true, "Man vs Machine");

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
if (old.lineId == 658785 && settings["Walk in the Park 1"] && vars.stopwatch.ElapsedMilliseconds > 600) // Walk in the Park Finished
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 6.8 <= current.percent && current.percent <= 7.5 && settings["Carcani"]) // Carcani Call after Walk in the Park
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 8 <= current.percent && current.percent <= 8.5 && settings["Hack and Run"]) // Hack and Run
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 9 <= current.percent && current.percent <= 10 && settings["Get Smart Car"]) // Get Smart Car
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 11 <= current.percent && current.percent <= 12 && settings["Cyber Stunt Driver"]) // Cyber Stunt Driver
	return vars.isNotDoubleSplit();
if (settings["Sunday Schooled 1"] && current.lineId == 354490) // Sunday Schooled 1
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 13.5 <= current.percent && current.percent <= 14.5 && settings["Sunday Schooled 2"]) // Sunday Schooled 2
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 15 <= current.percent && current.percent <= 15.5 && settings["Mindfuck"]) // Mindfuck
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 16 <= current.percent && current.percent <= 16.5 && settings["Missing Persons"]) // Missing Persons
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 17 <= current.percent && current.percent <= 18 && settings["Blasphemer"]) // Blasphemer
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 19 <= current.percent && current.percent <= 20 && settings["Heist Sweet Heist"]) // Heist Sweet Heist
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 22 <= current.percent && current.percent <= 23 && settings["Lord of the Wifis"]) // Lord of the Wifis
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 23.1 <= current.percent && current.percent <= 23.5 && settings["Swimming Upstream"]) // Swimming Upstream
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 24 <= current.percent && current.percent <= 25 && settings["Horizontal and the Vertical"]) // Horizontal and the Vertical
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 26 <= current.percent && current.percent <= 27 && settings["Invite to Mayhem"]) // !nvite to Mayhem
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 27.5 <= current.percent && current.percent <= 28.5 && settings["R&R"]) // R&R
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 30 <= current.percent && current.percent <= 31 && settings["Limp Nudle"]) // Limp Nudle
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 32 <= current.percent && current.percent <= 33 && settings["Lenni's Demands"]) // Lenni's Demands
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 33.5 <= current.percent && current.percent <= 34 && settings["Sabotage"]) // Sabotage
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 34.5 <= current.percent && current.percent <= 35.5 && settings["Bunker Bust"]) // Bunker Bust
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 36 <= current.percent && current.percent <= 36.5 && settings["Peeping Toms"]) // Peeping Toms
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 39 <= current.percent && current.percent <= 40 && settings["Cabbie for Hire"]) // Cabbie for Hire
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 40.5 <= current.percent && current.percent <= 41 && settings["Dellums Towers"]) // Dellums Towers
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 41.5 <= current.percent && current.percent <= 42.5 && settings["Lost Call"]) // Lost Call
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 43 <= current.percent && current.percent <= 43.5 && settings["Wrench in the Works"]) // Wrench in the Works
	return vars.isNotDoubleSplit();	
if (old.percent != current.percent && 44 <= current.percent && current.percent <= 45 && settings["A Brutal Discovery"]) // A Brutal Discovery
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 45.2 <= current.percent && current.percent <= 46 && settings["Shipwreck"]) // Shipwreck
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 46.5 <= current.percent && current.percent <= 47 && settings["Root Canal"]) // Root Canal
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 47.5 <= current.percent && current.percent <= 48 && settings["A Real Dogfight"]) // A Real Dogfight
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 48.9 <= current.percent && current.percent <= 49.5 && settings["Get Cray with Ray"]) // Get Cray with Ray
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 50 <= current.percent && current.percent <= 51 && settings["Hangar On"]) // Hangar On
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 52 <= current.percent && current.percent <= 53 && settings["All-Seeing Eye"]) // All-Seeing Eye
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 54.5 <= current.percent && current.percent <= 55 && settings["Down by the Docks"]) // Down by the Docks
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 55.5 <= current.percent && current.percent <= 56.5 && settings["Chinatown Shuffle"]) // Chinatown Shuffle
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 57 <= current.percent && current.percent <= 57.5 && settings["Nice View"]) // Nice View
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 58 <= current.percent && current.percent <= 59 && settings["They're on a Boat"]) // They're on a Boat
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 60 <= current.percent && current.percent <= 61 && settings["Mark Up"]) // Mark Up
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 61 <= current.percent && current.percent <= 62 && settings["A Tempting Invitation"]) // A Tempting !nvitation
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 62.5 <= current.percent && current.percent <= 63.5 && settings["Compromised Candidate"]) // Compromised Candidate
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 64 <= current.percent && current.percent <= 64.5 && settings["Voting Machinations"]) // Voting Machinations 
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 65 <= current.percent && current.percent <= 66 && settings["Drop the Baby"]) // Drop the Baby
	return vars.isNotDoubleSplit();
if (old.percent != current.percent && 67 <= current.percent && current.percent <= 68.5 && settings["Man vs Machine"]) // Man vs Machine
	return vars.isNotDoubleSplit();
}
