// Some of this script requires the use of the "asl-help" library.
// This will be loaded automatically if using this script from within the splits editor.
// https://github.com/just-ero/asl-help

state("Level1")
{
  // unknown/default version
}

// I Am Jesus Christ: Prologue
// https://steamdb.info/patchnotes/10094678
state("Level1", "Patch2")
{
  bool loading : 0xBB603D8; // 0 when not loading, above 0 when loading
}

init
{
  switch ((int)vars.Helper.GetMemorySize())
  {
    case 0xCA5F000:
      version = "Patch2";
      break;
    default:
      vars.Helper.Game = null;
      return;
  }
}

startup
{
  Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
  vars.Helper.AlertLoadless();
}

isLoading
{
  if (version != "")
    return current.loading;
}

exit
{
  // Unpauses the timer on exit;
  // makes sure if it crashes during a load it doesn't stay paused.
  timer.IsGameTimePaused = false;
}
