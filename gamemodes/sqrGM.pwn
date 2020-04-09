#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <a_mysql>
#include "../include/utilitis.inc"

// Conexión mysql

#define MYSQL_HOST  "localhost"
#define MYSQL_USER  "root"
#define MYSQL_DB    "sqrp_db"
#define MYSQL_PASS  "5K4T3F0R1IF3a"

new db_conn;

//---------------------------------------------------------------------

#define function:%0(%1) forward %0(%1); public %0(%1)
#define SCM SendClientMessage

new maxErrorPassword;

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
public OnPlayerConnect(playerid)
{	
	new Query[300];
	mysql_format(db_conn, Query, sizeof(Query), "SELECT * FROM usuarios_data WHERE nombre = '%s'", getName(playerid));
	mysql_tquery(db_conn, Query, "Login", "i", playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, -1465.200683, 2608.702148, 55.835937);
	return 1;
}

function:Login(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, db_conn);
	if (rows)
	{
		SCM(playerid, 0xFFFFFA, "Usuario registrado.")	
		SCM(playerid, 0xFFFFFA, "Usa /login [contraseña].")	
	}else
	{
		SCM(playerid, 0xFFFFFF, "Usuario no registrado");
		SCM(playerid, 0xFFFFFF, "Usa /registrar [contraseña]");
	}
}

CMD:registrar(playerid, params[])
{
	new password[40];
	if(sscanf(params, "s[40]", password))
    {
        return SCM(playerid, 0xFACC2E, "Usa: /registrar [password]");
    } else
    {
		new Query[300];
        mysql_format(db_conn, Query, sizeof(Query), "INSERT INTO `usuarios_data` (nombre, password, trabajo_uno, trabajo_dos, vehiculo_uno, vehiculo_dos, dinero_mano, dinero_banco, rango) VALUES ('%s', '%s', 0,0,0,0,0,0,0)", getName(playerid), password);
	    mysql_tquery(db_conn, Query, "OnPlayerRegister", "i", playerid);

    }
	return 1;
}

function:OnPlayerRegister(playerid)
{
	SCM(playerid, 0xFFFFFF, "Usuario registrado");
}

CMD:login(playerid, params[])
{
	new password[40];
	new Query[300];

	if(sscanf(params, "s[40]", password))
    {
        return SCM(playerid, 0xFACC2E, "Usa: /login [password]");
    } else
	{
		mysql_format(db_conn, Query, sizeof(Query), "SELECT id FROM usuarios_data WHERE nombre = '%s' AND password = '%s'", getName(playerid), password);
	    mysql_tquery(db_conn, Query, "OnPlayerLoginIn", "i", playerid);
	}
	return 1;
}

function:OnPlayerLoginIn(playerid)
{
	if (maxErrorPassword == 2)
		{
			SendClientMessage(playerid,0xFFFFFC, "Intentaste demasiadas veces.");
			Kick(playerid)
		}

	new rows, fields;
	cache_get_data(rows, fields, db_conn);

	if (rows)
	{
		SCM(playerid,0xFFFFFC, "Sesión iniciada.");
	}else
	{
		SCM(playerid,0xFFFFFC, "Contraseña erronea, intente de nuevo.");
		maxErrorPassword++;
	}
}