state("EFLC")
{
	uint missions : 0xDA58B0, 0x10;
}

startup
{
	vars.missionCount = 0;
}

update
{
	vars.doSplit = false;
	
	// Stores the curent phase the timer is in, so we can use the old one on the next frame.
	current.timerPhase = timer.CurrentPhase;
	
	// Reset some variables when the timer is started.
	if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running) {
		vars.missionCount = 0;
	}
	
	// Does this stuff if the timer is currently running.
	if (current.timerPhase == TimerPhase.Running) {
		// If we have progressed to the next mission, increment the count and split.
		// This fixes if the "missions" address goes back by 1 and then forward again by 1.
		if (current.missions == vars.missionCount+1) {
			vars.missionCount++;
			vars.doSplit = true;
		}
	}
}

split
{
	return vars.doSplit;
}