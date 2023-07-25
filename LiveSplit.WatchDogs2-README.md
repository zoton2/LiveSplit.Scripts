# "Watch_Dogs 2" Autosplitter and Load Remover

## How to install

1. In the LiveSplit splits editor, make sure your game is set to "Watch_Dogs 2" (without quotes) and then click the "Activate" button.
2. Disable **EasyAntiCheat** for the game; this can be done by adding the `-eac_launcher` command line option. This is needed because it blocks the game's memory from being read. The game should alert you that this has worked on start up; if it doesn't, try restarting your computer and then launching the game again.
    - See [this PCGamingWiki article](http://pcgamingwiki.com/wiki/Glossary:Command_line_arguments) for how to go about doing this.
3. In LiveSplit, set "Game Time" as your main timing method; right-click the main window > Compare Against > Game Time. (Both real time and time without loads are stored in your splits regardless.)

## What is autosplit?

*(All autospliting is based on percentage for your current save/playthrough, except for starting split, "Walk in the Park," and "Sunday Schooled 1," which are based on subtitles)*
- Must have No Compromise and Human Conditions DLC uninstalled for the percentages to match up with the atuosplitter script. Must also follow the speedrun route in the WR.
  
- Starting split (once you gain control of Marcus).
- Splits for most individual main missions, and has options to enable/disable them.
- Splits for "Walk in the Park",  "Sunday Schooled", and "Mark Up" if enabled in settings (default is disabled). "Walk in the Park" and "Sunday Schooled 1" do not always split properly due to subtitles being skipped. 
- Still have to manual split for the last split when completing Motherload (last mission).
  
Does not support splitting for these individual missions/cutscenes & calls:
- Intro mission/stuff before "Walk in the Park"
- Newly Dawned ("False Profits")
- ICU (Wrench cutscene at start of "Heist Sweet Heist")
- Zero Days ("Heist Sweet Heist")
- Trouble at Home ("Looking Glass")
- Second Wind ("Alphabet Soup")
- Nine Lives ("Hacker War")
- Café Culture ("W4tched")
- The Waiting Game ("Hack teh World")
- Spinal Tap ("Shanghaied")
- Social Media and the Congressman ("Power to the Sheeple")
- Like Minds ("Robot Wars")
- Motherload call (for mission to show up)

## Versions supported

This load remover *should* work for copies bought from any storefront. Your current version is visible in the main menu and the pause menu. I advise you disable automatic updating of your game if possible, because new versions will not be supported straight away. **Autosplitting is not supported on all versions! (see notes below)**
- v1.05.134.981608
- v1.06.135.3.982778
- v1.06.135.7.982778
- v1.07.141.6.988937
- v1.09.152.2.996015
- v1.09.154.1001103
- v1.011.174.3.1009368
- v1.011.174.6.1009368 
- v1.017.189.2.1088394 (**supports autosplitting**, [final patch?](https://www.reddit.com/r/watch_dogs/comments/6r7vbr/title_update_117_bug_fix_patch_notes/))

## Contributors

- Random_Machine *(autosplitting)*
- Andreii *(percentage autosplitting)*
