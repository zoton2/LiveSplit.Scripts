// Works with the RELOADED cracked EXE.

state("SawGame")
{
	int loading : 0x16C5070, 0xB4;
	int video : "binkw32.dll", 0x2E594;
}

isLoading
{
	return current.loading > 0 && current.video == 0;
}