# "Grand Theft Auto: Vice City" Autosplitter

**How to install:**

1. Download the latest script from [here](https://raw.githubusercontent.com/zoton2/LiveSplit.Scripts/master/LiveSplit.GTAVC.asl) (right-click > Save As...); save it somewhere memorable.
2. Add the script to your LiveSplit layout: right-click > Edit Layout... > + > Control > Scriptable Auto Splitter, then double-click it in the list and browse for the script, wherever you saved it.
3. *(Optional)* Edit the script to change what missions you want to split for (you will probably want to do this if you intend to use it for All Missions); open the file in a text editor (e.g. Notepad) and look at the comments.
4. Make sure you save your layout if you always want the autosplitter to be active!

**What is Autosplit? (by default):**

- Starting split (after the new game loading is finished).
- Every mission that is required for Any% (Japanese run) or Shakedown, if your category is set to that in LiveSplit.
- Ending split (on "Keep Your Friends Close..."; loss of control for Any% and after credits for anything else. Also some other things for misc. categories; see below).
- Reset if starting a new game while currently in the game from the pause menu, if timer is currently running.

**Categories supported:**

To make these work, just make sure your category is set correctly in your splits.
- Any%/Beat the Game (splits for every mission required in the Japanese run; can also split for Checkpoint Charlie.)
- All Missions (needs some editing of the script for the missions you want to split for.)
- Beat Shakedown (splits for every mission required)
- 100 Hidden Packages (by default, splits after collecting all)
- All Robberies (by default, splits on doing all)
- All Unique Stunt Jumps (by default, splits on doing all)
- All Rampages (by default, splits on doing all)
- Anything else splits after the credits.

**Versions that should work:**

- 1.0 (needs testing)
- 1.1 (needs testing)
- Steam (could do with some more testing)
- Japanese (most common version)

**Known bugs:**

- If the timer is running and you boot the game up fresh and start a new game, the timer will not be reset. This is a side effect of us fixing the "loading a save after your game has crashed/closed will restart the splits" bug, but is actually useful for certain things (e.g. SRL races) so it will stay this way for now.

**Thanks to:**

- Lighnat0r for the memory addresses.
- Pitpo for adding basic category support/All Missions support, also fixed some bugs.
