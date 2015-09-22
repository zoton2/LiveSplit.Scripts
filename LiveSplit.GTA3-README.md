# "Grand Theft Auto 3/III" Autosplitter

**How to install:**

1. Download the latest script from [here](https://raw.githubusercontent.com/zoton2/LiveSplit.Scripts/master/LiveSplit.GTA3.asl) (right-click > Save As...); save it somewhere memorable.
2. Add the script to your LiveSplit layout: right-click > Edit Layout... > + > Control > Scriptable Auto Splitter, then double-click it in the list and browse for the script, wherever you saved it.
3. *(Optional)* Edit the script to change what missions you want to split for (you will probably want to do this if you intend to use it for All Missions); open the file in a text editor (e.g. Notepad) and look at the comments.
4. Make sure you save your layout if you always want the autosplitter to be active!

**What is Autosplit? (by default):**

- Starting split (once the initial cutscene is skipped or finished).
- Every mission that is required for Any% or "Kingdom Come", if your category is set to that in LiveSplit.
- ***(Not on Any%)*** Ending Split: by default, after the credits for All Missions and any other category; after "Kingdom Come" for that category.
- Reset if starting a new game while currently in the game from the pause menu, if timer is currently running.

**Categories supported:**

To make these work, just make sure your category is set correctly in your splits.
- Any%/Beat the Game (splits for every mission required, *although doesn't split for the last split yet*.)
- All Missions (needs some editing of the script for the missions you want to split for.)
- Beat "Kingdom Come" (splits for every mission required)
- Anything else splits after the credits.

**Versions that should work:**

- 1.0 (needs testing, no one really uses this version)
- 1.1 (could do with some more testing)
- Steam (could do with some more testing)

**Known bugs:**

- No split for the ending of Any% yet; still need to find some reliable memory address for it. Just split for it manually yourself for now.
- If the timer is running and you boot the game up fresh and start a new game, the timer will not be reset. This is so that if the game closes/crashes and you load a save while in a run, the timer is not reset. It is also useful for other things (e.g. SRL races) so it will stay this way for now.

**Thanks to:**

- Lighnat0r for the memory addresses.
- Pitpo for work on the "Grand Theft Auto: Vice City" autosplitter, which some of the code for this is based off.
