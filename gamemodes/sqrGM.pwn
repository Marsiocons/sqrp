#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <a_mysql>
#include "../include/utilitis.inc"

//======================= MySQL Connection ==========================================//

#define MYSQL_HOST  "localhost"
#define MYSQL_USER  "root"
#define MYSQL_DB    "sqrp_db"
#define MYSQL_PASS  "5K4T3F0R1IF3a"

new db_conn;

//===================================================================================//

//============================== DEFINE =============================================//

#define   DIALOG_REGISTER (0)
#define   DIALOG_LOGIN    (1)
#define   SCM             SendClientMessage
#define   function:%0(%1) forward %0(%1); public %0(%1)

//===================================================================================//

//================================= Player Info =====================================//

enum PlayerData
{
dbID,
dbNombre[MAX_PLAYER_NAME+1],
dbTrabajoUno,
dbTrabajoDos,
dbVehiculoUno,
dbVehiculoDos,
dbDineroMano,
dbDineroBanco,
dbRango,
dbSkin,
bool:dbLoggedIn
}

new PlayerInfo[MAX_PLAYERS][PlayerData];

//===================================================================================//

//=============================== MAIN ==============================================//

main()
{
	print("\n----------------------------------");
	print("San Quebrado V 0");
	print("----------------------------------\n");
}

//===================================================================================//

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
	ResetPlayer(playerid);
	new Query[300];
	mysql_format(db_conn, Query, sizeof(Query), "SELECT * FROM usuarios_data WHERE nombre = '%s'", GetName(playerid));
	mysql_tquery(db_conn, Query, "Bienvenida", "i", playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	new Query[300];
	mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `trabajo_uno` = %i WHERE `id` = %i", GetPVarInt(playerid, "dbTrabajoUno"), PlayerInfo[playerid][dbID]);
	mysql_tquery(db_conn, Query, "PlayerDisconnect", "i", playerid); 
	ResetPlayer(playerid);
}
  

public OnPlayerRequestClass(playerid, classid)
{
	if (PlayerInfo[playerid][dbLoggedIn] == false)
	{
		SetSpawnInfo( playerid, 0, 0, 563.3157, 3315.2559, 0, 269.15, 0, 0, 0, 0, 0, 0 );
		TogglePlayerSpectating(playerid, true);
    	TogglePlayerSpectating(playerid, false);
		SetPlayerCamera(playerid);
		return 1;
	}
	
	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
    {
		case DIALOG_LOGIN:
        {
			if (!response)
            {
				SCM(playerid,0xAA3333AA, "Fuiste expulsado del servidor por evitar el login.")
				KickEx(playerid);
			}
			else
			{
				new Query[300];
				mysql_format(db_conn, Query, sizeof(Query), "SELECT * FROM usuarios_data WHERE nombre = '%s' AND password = '%s'", GetName(playerid), inputtext);
	    		mysql_tquery(db_conn, Query, "OnPlayerLoginIn", "i", playerid);
			}
		}
		case DIALOG_REGISTER:
		{
			if (!response)
			{
				SCM(playerid, 0xAA3333AA, "Fuiste expulsado del servidor por evitar el registro.");
				KickEx(playerid);
			}
			else
			{
				new Query[300];
        		mysql_format(db_conn, Query, sizeof(Query), "INSERT INTO `usuarios_data` (nombre, password, trabajo_uno, trabajo_dos, vehiculo_uno, vehiculo_dos, dinero_mano, dinero_banco, rango) VALUES ('%s', '%s', 0,0,0,0,0,0,0)", GetName(playerid), inputtext);
	    		mysql_tquery(db_conn, Query, "OnPlayerRegister", "i", playerid);
			}
		}
	}

	return 1;
}


//============================ FUNCTIONS ============================================//

function:Bienvenida(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, db_conn);
	if (rows)
	{
		SCM(playerid, 0xFFFFFA, "Usuario registrado.")	
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta está registrada.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Iniciar", "Cancelar");
	}else
	{
		SCM(playerid, 0xFFFFFF, "Usuario no registrado");
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta no está registrada.\n\nIngresa una contraseña válida para continuar.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Registrar", "Cancelar");
	}
}

function:OnPlayerRegister(playerid)
{
	SCM(playerid, 0xFFFFFF, "Usuario registrado");
	PlayerInfo[playerid][dbLoggedIn] = true;
	SpawnPlayerPlayer(playerid);
}

function:OnPlayerLoginIn(playerid)
{
	new maxErrorPassword;

	if (maxErrorPassword == 2)
		{
			SendClientMessage(playerid,0xFFFFFC, "Intentaste demasiadas veces.");
			KickEx(playerid);
		}

	new rows, fields;
	cache_get_data(rows, fields, db_conn);

	if (rows)
	{
		SCM(playerid,0xFFFFFC, "Sesión iniciada.");
		PlayerInfo[playerid][dbLoggedIn] = true;
	}else
	{
		SCM(playerid,0xAA3333AA, "Contraseña erronea, intente de nuevo.");
		maxErrorPassword++;
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta está registrada.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Iniciar", "Cancelar");
	}

	PlayerInfo[playerid][dbID] = cache_get_field_content_int(0, "id", db_conn);
	PlayerInfo[playerid][dbNombre] = GetName(playerid);
	PlayerInfo[playerid][dbTrabajoUno] = cache_get_field_content_int(0, "trabajo_uno", db_conn);
	PlayerInfo[playerid][dbVehiculoUno] = cache_get_field_content_int(5, "vehiculo_uno", db_conn);
	PlayerInfo[playerid][dbDineroMano] = cache_get_field_content_int(7, "dinero_mano", db_conn);
	PlayerInfo[playerid][dbDineroBanco] = cache_get_field_content_int(8, "dinero_banco", db_conn);

	SetPVarString(playerid, "dbNombre", PlayerInfo[playerid][dbNombre]);
	SetPVarInt(playerid, "dbTrabajoUno", PlayerInfo[playerid][dbTrabajoUno]);
	SetPVarInt(playerid, "dbVehiculoUno", PlayerInfo[playerid][dbVehiculoUno]);
	SetPVarInt(playerid, "dbDineroMano", PlayerInfo[playerid][dbDineroMano]);
	SetPVarInt(playerid, "dbDineroBanco", PlayerInfo[playerid][dbDineroBanco]);

	SpawnPlayerPlayer(playerid);
	return 1;
}

function:ResetPlayer(playerid)
{
    PlayerInfo[playerid][dbLoggedIn] = false;
    PlayerInfo[playerid][dbSkin] = 0;
    return 1;
}

function:PlayerDisconnect(playerid)
{
	print("Usuario guardado");
}

function:SetPlayerCamera(playerid)
{
	SetPlayerCameraPos(playerid, 2019.1145, 1202.9185, 42.3246);
    SetPlayerCameraLookAt(playerid, 2019.9889, 1202.4272, 42.2945);
}
function:SpawnPlayerPlayer(playerid)
{
	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][dbSkin], -1465.200683,2608.702148,55.835937, 65.2418, 0, 0, 0, 0, 0, 0 );
    SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	return 1;
}

//===================================================================================//
