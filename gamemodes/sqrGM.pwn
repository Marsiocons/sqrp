#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <a_mysql>

// Conexión mysql

#define MYSQL_HOST  "localhost"
#define MYSQL_USER  "root"
#define MYSQL_DB    "sv_database"
#define MYSQL_PASS  "5K4T3F0R1IF3a"

new db_conn;

//---------------------------------------------------------------------

#define function:%0(%1) forward %0(%1); public %0(%1)

main()
{
	print("\n----------------------------------");
	print("San Quebrado V 0");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	db_conn = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	if(mysql_errno(db_conn) != 0)
    {
		print("No se pudo conectar a la base de datos.");
	}else
	{
		print("Conexión exitosa");
	}
	return 1;
}
public OnGameModeExit() 
{
    mysql_close(db_conn);
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, -1465.200683, 2608.702148, 55.835937);
	return 1;
}