# "Watch_Dogs 2" Load Remover

**How to install:**

1. In the LiveSplit splits editor, make sure your game is set to "Watch_Dogs 2" (without quotes) and then click the "Activate" button.
2. Disable **EasyAntiCheat** for the game; this can be done by adding the `-eac_launcher` command line option. This is needed because it blocks the game's memory from being read. The game should alert you that this has worked on start up; if it doesn't, try restarting your computer and then launching the game again.
    - See [this PCGamingWiki article](http://pcgamingwiki.com/wiki/Glossary:Command_line_arguments) for most ways of doing this (Steam, shortcuts, etc.)
    - **uPlay:** On the game's page in your library go to the "Properties" tab (on the left), scroll down to the "Game launch arguments" section, click "Edit", put in the option and click "Save".
3. In LiveSplit, set "Game Time" as your main timing method; right-click the main window > Compare Against > Game Time. (Both real time and time without loads are stored in your splits regardless.)

**Versions supported:**

This load remover *should* work for copies bought from any storefront. Your current version is visible in the main menu and the pause menu. I advise you disable automatic updating of your game if possible, because new versions will not be supported straight away.
- v1.05.134.981608
- v1.06.135.3.982778