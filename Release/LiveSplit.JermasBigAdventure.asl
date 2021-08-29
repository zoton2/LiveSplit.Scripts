state("Jerma's Big Adventure")
{
  // unknown/default version
}

startup
{
  vars.Dbg = (Action<dynamic>) ((output) => print("[LiveSplit.JermasBigAdventure] " + output));
  vars.cancelSource = null;

  settings.Add("check0", false, "Above Ground");
  settings.Add("check1", false, "Cave Start");
  settings.Add("check2", false, "Raptor Tutorial");
  settings.Add("check3", false, "Raptor Region 1");
  settings.Add("check4", false, "Raptor Region 2");
  settings.Add("check5", false, "Target Region");
  settings.Add("check6", false, "Warlock Region 1");
  settings.Add("check7", false, "Warlock Region 2");
  settings.Add("check8", false, "Pre-Boss Region");
  settings.Add("check9", false, "Boss Region");
  settings.Add("check10", true, "Post-Boss Region");
}

init
{
  var dataPtr = IntPtr.Zero;
  vars.cancelSource = new CancellationTokenSource();

  vars.scanThread = new Thread(() =>
  {
    Func<SigScanTarget, IntPtr> scanPages = (target) =>
    {
      var result = IntPtr.Zero;
      foreach (var page in game.MemoryPages())
      {
        var scanner = new SignatureScanner(game, page.BaseAddress, (int)page.RegionSize);
        if ((result = scanner.Scan(target)) != IntPtr.Zero) break;
      }
      return result;
    };

    vars.Dbg("Starting scan thread");
    var dataTrg = new SigScanTarget(0xA, "00 00 37 13 37 13 37 13 37 13");

    while (!vars.cancelSource.Token.IsCancellationRequested)
    {
      if (dataPtr == IntPtr.Zero && (dataPtr = scanPages(dataTrg)) != IntPtr.Zero)
        vars.Dbg("Found AutoSplitterData class at 0x" + dataPtr.ToString("X"));

      if (new[] { dataPtr }.All(ptr => ptr != IntPtr.Zero))
      {
        vars.Dbg("Found all pointers successfully");
        vars.autoSplitterData = new MemoryWatcherList {
          new MemoryWatcher<double>(new DeepPointer((IntPtr)dataPtr + 0x00)) { Name = "inGameTime" },
          // new MemoryWatcher<int>(new DeepPointer((IntPtr)dataPtr + 0x08)) { Name = "isLoading" },
          new MemoryWatcher<int>(new DeepPointer((IntPtr)dataPtr + 0x0C)) { Name = "levelID" },
          new MemoryWatcher<int>(new DeepPointer((IntPtr)dataPtr + 0x10)) { Name = "isRunning" }
        };
        break;
      }

      vars.Dbg("Not all pointers found, retrying");
      Thread.Sleep(2000);
    }

    vars.Dbg("Exiting scan thread");
  });

  vars.scanThread.Start();
}

update
{
  if (vars.scanThread.IsAlive) return false;
  vars.autoSplitterData.UpdateAll(game);
}

start
{
  return vars.autoSplitterData["isRunning"].Old == 0 && vars.autoSplitterData["isRunning"].Current == 1;
}

split
{
  return settings["check"+vars.autoSplitterData["levelID"].Old.ToString()]
    && (vars.autoSplitterData["levelID"].Current > vars.autoSplitterData["levelID"].Old
    || vars.autoSplitterData["isRunning"].Old == 1 && vars.autoSplitterData["isRunning"].Current == 2);
}

reset
{
  return vars.autoSplitterData["isRunning"].Old != 0 && vars.autoSplitterData["isRunning"].Current == 0;
}

gameTime
{
  return TimeSpan.FromSeconds(vars.autoSplitterData["inGameTime"].Current);
}

isLoading
{
  return true;
}

exit
{
  if (vars.cancelSource != null) vars.cancelSource.Cancel();
}

shutdown
{
  if (vars.cancelSource != null) vars.cancelSource.Cancel();
}
