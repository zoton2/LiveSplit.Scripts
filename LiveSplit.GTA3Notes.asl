// Change this to whatever game you want it to detect.
state("gta3") {}

init
{
	// Location where the file will be saved.
	vars.fileLocation = @"E:\Node_Apps\NodeCG\bundles\livesplit-split-notes\data.txt";
	
	// Sets up the split index variable.
	vars.lastSplitIndex = -1;
	
	// Writes a blank file.
	File.WriteAllText(vars.fileLocation, "", Encoding.UTF8);
}

update
{
	// Check if the splits are running before getting the split name and saving it.
	if (timer.CurrentPhase.ToString() == "Running") 
	{
		// Checks if we are on a new split yet; if so saves it to the file.
		if (timer.CurrentSplitIndex != vars.lastSplitIndex)
		{
			var stringToSave = timer.CurrentSplitIndex.ToString() + ":::" + timer.CurrentSplit.Name.ToLower();
			File.WriteAllText(vars.fileLocation, stringToSave, Encoding.UTF8);
		}
	}
	
	else
	{
		if (timer.CurrentSplitIndex != vars.lastSplitIndex)
		{
			// Writes a blank file if not running splits.
			File.WriteAllText(vars.fileLocation, "", Encoding.UTF8);
		}
	}
	
	// Updates this for check on next frame.
	vars.lastSplitIndex = timer.CurrentSplitIndex;
}