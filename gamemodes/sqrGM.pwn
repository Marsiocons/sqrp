#include <a_samp>

#define function:%0(%1) forward %0(%1); public %0(%1)

main()
{
	print("\n----------------------------------");
	print("San Quebrado V 0");
	print("----------------------------------\n");
}

public OnGameModeInit()
{

}
public OnGameModeExit() 
{
    
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, -1465.200683, 2608.702148, 55.835937);
	return 1;
}