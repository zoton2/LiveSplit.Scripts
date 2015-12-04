// Tested to work with the GOG version; not sure about other versions just yet.

state("TOD")
{
	int loading : 0x63DFF0, 0x2F8, 0xD0, 0x38, 0x348, 0x124;
}

isLoading
{
	return current.loading > 0;
}