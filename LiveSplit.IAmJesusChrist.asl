state("Level1")
{
  // unknown/default version
}

// I Am Jesus Christ: Prologue
// https://steamdb.info/patchnotes/10094678/
state("Level1", "Patch2")
{
  int loading : 0xBB603D8; // 0 when not loading, above 0 when loading
}

init
{
  switch (modules.First().ModuleMemorySize)
  {
    case 212201472:
      version = "Patch2";
      break;
  }

  // Workaround to reject the process if it doesn't match.
  // This is needed when the "launcher" EXE and the game "EXE" are named identically.
  // Source: https://github.com/LiveSplit/LiveSplit.ScriptableAutoSplit/issues/56
  if (version == "") {
    var allComponents = timer.Layout.Components;
    // Grab the autosplitter from splits
    if (timer.Run.AutoSplitter != null && timer.Run.AutoSplitter.Component != null) {
      allComponents = allComponents.Append(timer.Run.AutoSplitter.Component);
    }
    foreach (var component in allComponents) {
      var type = component.GetType();
      if (type.Name == "ASLComponent") {
        // Could also check script path, but renaming the script breaks that, and
        // running multiple autosplitters at once is already just asking for problems
        var script = type.GetProperty("Script").GetValue(component);
        script.GetType().GetField(
          "_game",
          BindingFlags.NonPublic | BindingFlags.Instance
        ).SetValue(script, null);
      }
    }
  }
}

startup
{
  // Stolen some several other scripts; asks the user if they want to switch to
  // Game Time when the script loads if needed.
  if (timer.CurrentTimingMethod == TimingMethod.RealTime) {
    var timingMessage = MessageBox.Show(
      "This game uses Time without Loads (Game Time) as the main timing method.\n"+
      "LiveSplit is currently set to show Real Time (RTA).\n"+
      "Would you like to set the timing method to Game Time?",
      "LiveSplit | I Am Jesus Christ",
      MessageBoxButtons.YesNo, MessageBoxIcon.Question
    );
    if (timingMessage == DialogResult.Yes)
      timer.CurrentTimingMethod = TimingMethod.GameTime;
  }
}

isLoading
{
  if (version != "")
    return current.loading > 0;
}

exit
{
  // Unpauses the timer on exit;
  // makes sure if it crashes during a load it doesn't stay paused.
  timer.IsGameTimePaused = false;
}
