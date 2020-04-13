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

//=============================== TextDraw ==========================================//

new Text:BarraInicio;
new Text:BarraInicioDos;
new Text:tipoBoton[4]; // ANTERIOR 0, MUJER 1, SISGUIENTE 2, HOMBRE 3
new Text:iniciar;

new skins[2][4] = {{72,134,188,158},{69,131,192,198}};
new bool:isWoman;
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
dbSkinUno,
dbSkinDos,
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
	PlayerInfo[playerid][dbTrabajoUno] = GetPVarInt(playerid, "dbTrabajoUno");
	new Query[300];
	mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `trabajo_uno` = %i, `skin_uno` = %i WHERE `id` = %i", PlayerInfo[playerid][dbTrabajoUno], PlayerInfo[playerid][dbSkinUno], PlayerInfo[playerid][dbID]);
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
        		mysql_format(db_conn, Query, sizeof(Query), "INSERT INTO `usuarios_data` (nombre, password, trabajo_uno, trabajo_dos, vehiculo_uno, vehiculo_dos, dinero_mano, dinero_banco, skin_uno, skin_dos, rango) VALUES ('%s', '%s', 0,0,0,0,0,0,0,0,0)", GetName(playerid), inputtext);
	    		mysql_tquery(db_conn, Query, "OnPlayerRegister", "i", playerid);
			}
		}
	}

	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == tipoBoton[0]) //Anterior
    {   
        if(GetPlayerSkin(playerid) == skins[isWoman][0])
        {
            SetPlayerSkin(playerid, skins[isWoman][3]);
        }
        else
        {
            for(new a = 1; a <= 3; a++)
            {
                if(GetPlayerSkin(playerid) == skins[isWoman][a])
                {
                    SetPlayerSkin(playerid, skins[isWoman][a - 1]);
                }
            }
        }
        SendClientMessage(playerid, 0xAAFFAA, "Presionaste 'anterior'");
    }
    if(clickedid == tipoBoton[2]) //Siguiente
    {
        if(GetPlayerSkin(playerid) == skins[isWoman][3])
        {
            SetPlayerSkin(playerid, skins[isWoman][0]);
        }
        else
        {
            for(new a = 0; a < 3; a++)
            {
                if(GetPlayerSkin(playerid) == skins[isWoman][a])
                {
                    SetPlayerSkin(playerid, skins[isWoman][a + 1]);
                    break;
                }
            }
        }
        SendClientMessage(playerid, 0xAAFFAA, "Presionaste 'siguiente'");
    }
    if(clickedid == tipoBoton[1]) //Mujer
    {
        isWoman = true;
        for(new a = 0; a <= 3; a++)
        {
            if(GetPlayerSkin(playerid) == skins[0][a])
            {
                SetPlayerSkin(playerid, skins[1][a]);
            }
        }
        
    }
    if(clickedid == tipoBoton[3]) //Hombre
    {
        isWoman = false;
        for(new a = 0; a <= 3; a++)
        {
            if(GetPlayerSkin(playerid) == skins[1][a])
            {
                SetPlayerSkin(playerid, skins[0][a]);
            }
        }
    }
    if(clickedid == iniciar) //Iniciar
    {
		PlayerInfo[playerid][dbSkinUno] = GetPlayerSkin(playerid);
		PlayerInfo[playerid][dbNombre] = GetName(playerid);
        SpawnPlayerPlayer(playerid);
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
	SetRectangle(playerid, 0);
}

function:OnPlayerRegister(playerid)
{	
	PlayerInfo[playerid][dbID] = cache_insert_id(); //Obtenemos su ID para después manejar los datos del jugador.
	PlayerInfo[playerid][dbLoggedIn] = true; //Está logueado.
	SetRectangle(playerid, 1); // Sacamos las barras de inicio.
	SkinSelector(playerid); //Llamamos a selector de skins.
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
	PlayerInfo[playerid][dbVehiculoUno] = cache_get_field_content_int(0, "vehiculo_uno", db_conn);
	PlayerInfo[playerid][dbDineroMano] = cache_get_field_content_int(0, "dinero_mano", db_conn);
	PlayerInfo[playerid][dbDineroBanco] = cache_get_field_content_int(0, "dinero_banco", db_conn);
	PlayerInfo[playerid][dbSkinUno] = cache_get_field_content_int(0, "skin_uno", db_conn);

	UpdateDataPlayer(playerid);
	SetRectangle(playerid, 1);
	SpawnPlayerPlayer(playerid);
	return 1;
}

function:ResetPlayer(playerid)
{
    PlayerInfo[playerid][dbLoggedIn] = false;
    PlayerInfo[playerid][dbSkinUno] = 0;
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
	for (new i = 0; i < 4; i++)
    {
        TextDrawDestroy(tipoBoton[i]);
    }
    TextDrawDestroy(iniciar);
    CancelSelectTextDraw(playerid);
    TogglePlayerControllable(playerid, 1);

	SetSpawnInfo(playerid, 0, PlayerInfo[playerid][dbSkinUno], -1465.200683,2608.702148,55.835937, 65.2418, 0, 0, 0, 0, 0, 0 );
    SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	return 1;
}
function:SetRectangle(playerid, option) // 0 Creamos - 1 Borramos.
{

	if (option == 1)
	{
        //TextDrawHideForPlayer(playerid, BarraInicioDos);
		//TextDrawHideForPlayer(playerid, BarraInicio);
		TextDrawDestroy(BarraInicioDos);
		TextDrawDestroy(BarraInicio);
		SCM(playerid, 0xAAFFFFAA, "Desactive las barras.");
	}
	if (option == 0)
	{
		BarraInicio = TextDrawCreate(320.0, 0.0, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
    	TextDrawAlignment(BarraInicio, 2);
    	TextDrawBackgroundColor(BarraInicio, 255);
    	TextDrawFont(BarraInicio, 2);
    	TextDrawColor(BarraInicio, 0xFFFFFF);
    	TextDrawUseBox(BarraInicio, 1);
    	TextDrawBoxColor(BarraInicio, 0x000000AA);
    	TextDrawSetOutline(BarraInicio, 0);

		BarraInicioDos = TextDrawCreate(320.0, 330.0, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
    	TextDrawAlignment(BarraInicioDos, 2);
    	TextDrawBackgroundColor(BarraInicioDos, 255);
    	TextDrawFont(BarraInicioDos, 2);
    	TextDrawColor(BarraInicioDos, 0xFFFFFF);
	    TextDrawUseBox(BarraInicioDos, 1);
    	TextDrawBoxColor(BarraInicioDos, 0x000000AA);
	    TextDrawSetOutline(BarraInicioDos, 0);

		TextDrawShowForPlayer(playerid, BarraInicio);
	    TextDrawShowForPlayer(playerid, BarraInicioDos);
		SCM(playerid, 0xAAFFFFAA, "Active las barras.");
	}
	
	return 1;
}
function:SkinSelector(playerid)
{
	new botonesNombre[][] = {
        "ANTERIOR",
        "MUJER",
        "SIGUIENTE",
        "HOMBRE"
        };
    new Float:coorBotones[2] = {360.0,380.0};    

    for(new i = 0; i < 2; i++)
    {
        for(new j = 0; j < 2; j++)
        {
            if(i == 1) break;
            tipoBoton[j] = TextDrawCreate(260.0,coorBotones[j],botonesNombre[j]);
            TextDrawAlignment(tipoBoton[j], 2);
            TextDrawBackgroundColor(tipoBoton[j], 255);
            TextDrawFont(tipoBoton[j], 1);
            TextDrawLetterSize(tipoBoton[j], 0.500000, 1.000000);
            TextDrawColor(tipoBoton[j], -1);
            TextDrawSetOutline(tipoBoton[j], 0);
            TextDrawSetProportional(tipoBoton[j], 1);
            TextDrawUseBox(tipoBoton[j], 1);
            TextDrawBoxColor(tipoBoton[j], 255);
            TextDrawTextSize(tipoBoton[j], 15.000000, 90.000000);
            TextDrawSetSelectable(tipoBoton[j], 1);
	        TextDrawShowForPlayer(playerid, tipoBoton[j]);
            SendClientMessage(playerid, 0xAAFFFFAA, "Cree un boton");
        } 
        tipoBoton[i+2] = TextDrawCreate(381.0,coorBotones[i],botonesNombre[i+2]);
        TextDrawAlignment(tipoBoton[i+2], 2);
        TextDrawBackgroundColor(tipoBoton[i+2], 255);
        TextDrawFont(tipoBoton[i+2], 1);
        TextDrawLetterSize(tipoBoton[i+2], 0.500000, 1.000000);
        TextDrawColor(tipoBoton[i+2], -1);
        TextDrawSetOutline(tipoBoton[i+2], 0);
        TextDrawSetProportional(tipoBoton[i+2], 1);
        TextDrawUseBox(tipoBoton[i+2], 1);
        TextDrawBoxColor(tipoBoton[i+2], 255);
        TextDrawTextSize(tipoBoton[i+2], 15.000000, 90.000000);
        TextDrawSetSelectable(tipoBoton[i+2], 1);
        TextDrawShowForPlayer(playerid, tipoBoton[i+2]);
        SendClientMessage(playerid, 0xAAFFFFAA, "Cree otro boton");
    }
    iniciar = TextDrawCreate(320.0, 400, "I N I C I A R");
    TextDrawAlignment(iniciar, 2);
    TextDrawBackgroundColor(iniciar, 255);
    TextDrawFont(iniciar, 1);
    TextDrawLetterSize(iniciar, 0.500000, 1.300000);
    TextDrawColor(iniciar, -1);
    TextDrawSetOutline(iniciar, 0);
    TextDrawSetProportional(iniciar, 1);
    TextDrawUseBox(iniciar, 1);
    TextDrawBoxColor(iniciar, 255);
    TextDrawTextSize(iniciar, 20.000000, 210.000000);
    TextDrawSetSelectable(iniciar, 1);
    TextDrawShowForPlayer(playerid, iniciar);
    
    SelectTextDraw(playerid, 0x00FF00FF);

	SetSpawnInfo(playerid, 0, skins[0][0], -1465.704589, 2637.687988, 75.877052, 231.36, 0, 0, 0, 0, 0, 0 );
    SpawnPlayer(playerid);
    SetPlayerCameraPos(playerid, -1456.281005, 2632.042968, 77.786529);
    SetPlayerCameraLookAt(playerid, -1465.704589, 2637.687988, 76.877052-3);
    
    TogglePlayerControllable(playerid, 0);
	return 1;
}
function:UpdateDataPlayer(playerid)
{
	SetPVarString(playerid, "dbNombre", PlayerInfo[playerid][dbNombre]);
	SetPVarInt(playerid, "dbTrabajoUno", PlayerInfo[playerid][dbTrabajoUno]);
	SetPVarInt(playerid, "dbVehiculoUno", PlayerInfo[playerid][dbVehiculoUno]);
	SetPVarInt(playerid, "dbDineroMano", PlayerInfo[playerid][dbDineroMano]);
	SetPVarInt(playerid, "dbDineroBanco", PlayerInfo[playerid][dbDineroBanco]);
	return 1;
}

//===================================================================================//
