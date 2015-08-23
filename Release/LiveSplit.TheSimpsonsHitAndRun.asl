state("Simpsons")
{
	int gameState : "Simpsons.exe", 0x2C9014, 0xC;
	int notLoading : "Simpsons.exe", 0x2C9018, 0x1D58;
	int paused : "Simpsons.exe", 0x2C8428, 0x18;
	int mainMenu : "Simpsons.exe", 0x2C9018, 0x1A18;
}

isLoading
{
	return current.gameState == 8 || (current.gameState == 10 && current.notLoading == 0 && current.paused != 1) || (current.gameState == 2 && current.mainMenu == 0);
}