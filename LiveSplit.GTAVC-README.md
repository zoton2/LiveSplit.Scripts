# "Grand Theft Auto: Vice City" Autosplitter

**How to install:**

1. Download the latest script from [here](https://raw.githubusercontent.com/zoton2/LiveSplit.Scripts/master/LiveSplit.GTAVC.asl) (right-click > Save As...); save it somewhere memorable.
2. Add the script to your LiveSplit layout: right-click > Edit Layout... > + > Control > Scriptable Auto Splitter, then double-click it in the list and browse for the script, wherever you saved it.
3. *(Optional)* Edit the script to change what missions you want to split for (you will probably want to do this if you intend to use it for All Missions); open the file in a text editor (e.g. Notepad) and look at the comments.
4. Make sure you save your layout if you always want the autosplitter to be active!

**What is Autosplit? (by default):**

- Starting split (after the new game loading is finished).
- Every mission that is required for Any%, if your category is set to that in LiveSplit.
- Ending split (on "Keep Your Friends Close..."; loss of control for Any% and after credits for anything else).
- Reset on the main loading screen (includes loading a save after a fresh start of the game; see bug below), if timer is currently running.

**Versions known to work:**

- 1.0
- 1.1
- Steam
- Japanese

**Known bugs:**

- Loading a save after your game has crashed/closed will restart the splits. See [this issue](https://github.com/zoton2/LiveSplit.Scripts/issues/2).

**Thanks To:**

- Lighnat0r for the memory addresses.
- Pitpo for adding basic category support/All Missions support.