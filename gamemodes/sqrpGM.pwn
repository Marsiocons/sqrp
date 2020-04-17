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

#define   DIALOG_REGISTER	   (0)
#define   DIALOG_LOGIN		   (1)
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
bool:dbLoggedIn,
dbVehUnoID,
dbVehDosID,
Float:dbSalud,
Float:dbBlindaje,
Float:dbX,
Float:dbY,
Float:dbZ,
Float:dbR
}
new PlayerInfo[MAX_PLAYERS][PlayerData];
//=============================== MAIN ==============================================//

main()
{
	print("\n----------------------------------");
	print("San Quebrado V Beta 0.03");
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
	new Query[300];
	mysql_format(db_conn, Query, sizeof(Query), "SELECT password FROM usuarios_data WHERE nombre = '%s'", GetName(playerid));
	mysql_tquery(db_conn, Query, "Bienvenida", "i", playerid);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	SavePlayerData(playerid);
	DestroyVehicle(PlayerInfo[playerid][dbVehUnoID]);
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
				SendClientMessage(playerid,0xAA3333AA, "Fuiste expulsado del servidor por evitar el login.")
				KickEx(playerid);
			}
			else
			{
				new Query[300];
				mysql_format(db_conn, Query, sizeof(Query), "SELECT id, vehiculo_uno, vehiculo_dos FROM usuarios_data WHERE nombre = '%s' AND password = '%s'", GetName(playerid), inputtext);
	    		mysql_tquery(db_conn, Query, "OnPlayerLoginIn", "i", playerid);
			}
		}
		case DIALOG_REGISTER:
		{
			if (!response)
			{
				SendClientMessage(playerid, 0xAA3333AA, "Fuiste expulsado del servidor por evitar el registro.");
				KickEx(playerid);
			}
			else
			{
				new Query[512];
        		mysql_format(db_conn, Query, sizeof(Query), "INSERT INTO `usuarios_data` (nombre, password, trabajo_uno, trabajo_dos, vehiculo_uno, vehiculo_dos, dinero_mano, dinero_banco, skin_uno, skin_dos, skin_actual, posicion_x, posicion_y, posicion_z, posicion_r, salud, blindaje, rango) VALUES ('%s', '%s', 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)", GetName(playerid), inputtext);
	    		mysql_tquery(db_conn, Query, "OnPlayerRegister", "i", playerid);
				mysql_format(db_conn, Query, sizeof(Query), "INSERT INTO `vehiculos_data` (propietario, modelo_uno, salud_uno, pos_x_uno, pos_y_uno, pos_z_uno, pos_r_uno, seguro_uno, combustible_uno, motor_estado_uno, modelo_dos, salud_dos, pos_x_dos, pos_y_dos, pos_z_dos, pos_r_dos, seguro_dos, combustible_dos, motor_estado_dos) VALUES ('%s',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)", GetName(playerid));
				mysql_tquery(db_conn, Query, "OnVehicleRegister", "i", playerid);
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
		new skinid = GetPlayerSkin(playerid);
		SetSkinsPlayer(playerid,0,skinid,0);
		SetTimerEx("SpawnPlayerPlayer", 400, false, "i", playerid);
    }
    return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (ispassenger == 0)
	{
		if (vehicleid >= 5) //No es un vehículo de concesionaria.
		{
			if (GetVehicleModel(vehicleid) != 481) // No es una bici.
			{
				SetPVarInt(playerid, "VehValido", 1);
			}
			else //Es una bici, le habilitamos el "motor".
			{
				SetPVarInt(playerid, "VehValido", 0);
				SetVehicleParamsEx(vehicleid, 1, 0, 0, 0, 0, 0, 0);
			}
		}
		else //Es un vehículo de concesionaria, mandamos un msj.
		{
			SendClientMessage(playerid, 0x00FF00, "Usá </comprar vehiculo> para obtener este vehículo.");
			SetPVarInt(playerid, "VehValido", 0);
		}
	}
	return 1;
}

// ======================== FUNCTIONS ======================== //

function:Bienvenida(playerid)
{
	ResetPlayer(playerid);

	new rows, fields;
	cache_get_data(rows, fields, db_conn);
	if (rows)
	{
		SendClientMessage(playerid, 0xFFFFFA, "Usuario registrado.")	
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta está registrada.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Iniciar", "Cancelar");
	}else
	{
		SendClientMessage(playerid, 0xFFFFFF, "Usuario no registrado");
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta no está registrada.\n\nIngresa una contraseña válida para continuar.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Registrar", "Cancelar");
	}
	SetRectangle(playerid, 0);
}

function:OnPlayerRegister(playerid)
{	
	PlayerInfo[playerid][dbID] = cache_insert_id(); //Obtenemos su ID para despuï¿½s manejar los datos del jugador.
	PlayerInfo[playerid][dbLoggedIn] = true; //está logueado.
	SetRectangle(playerid, 1); // Sacamos las barras de inicio.
	SkinSelector(playerid); //Llamamos a selector de skin.
}

function:OnVehicleRegister(playerid)
{
	new string[128];
	format(string, 128, "El usuario %s, registró un vehículo.", GetName(playerid));
	print(string);
	return 1;
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
		new string[128];
		PlayerInfo[playerid][dbID] = cache_get_field_content_int(0, "id", db_conn);
		PlayerInfo[playerid][dbLoggedIn] = true;
		format(string, sizeof(string), "Sesión iniciada. (ID DB = %i", PlayerInfo[playerid][dbID]);
		SendClientMessage(playerid,0xFFFFFC, string);
		if (cache_get_field_content_int(0, "vehiculo_uno", db_conn) == 1) CreateVehiclePlayer(playerid, 0);
		if (cache_get_field_content_int(0, "vehiculo_dos", db_conn) == 1) SetTimerEx("CreateVehiclePlayer", 400, false, "ii", playerid,1);
		GetPlayerData(playerid);
		SetRectangle(playerid, 1);
		SpawnPlayerPlayer(playerid);
	}
	else
	{
		SendClientMessage(playerid,0xAA3333AA, "Contraseña erronea, intente de nuevo.");
		maxErrorPassword++;
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "           San Quebrados Roleplay", "Tu cuenta está registrada.\nTIP: Por favor reportá los bugs que encuentres.\nGracias por contribuir con SQRP!\n\n           Ingresá tu contraseña:", "Iniciar", "Cancelar");
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

function:SpawnPlayerPlayer(playerid)
{
	for (new i = 0; i < 4; i++)
    {
        TextDrawDestroy(tipoBoton[i]);
    }
    TextDrawDestroy(iniciar);
    CancelSelectTextDraw(playerid);
    TogglePlayerControllable(playerid, 1);
	if (GetSkinsPlayer(playerid, 2) == 0)
	{
		SetSpawnInfo(playerid, 0, GetSkinsPlayer(playerid,0), PlayerInfo[playerid][dbX],
		 PlayerInfo[playerid][dbY],PlayerInfo[playerid][dbZ], PlayerInfo[playerid][dbR], 0, 0, 0, 0, 0, 0 );
	}
	else
	{
		SetSpawnInfo(playerid, 0, GetSkinsPlayer(playerid,1), PlayerInfo[playerid][dbX],
		 PlayerInfo[playerid][dbY],PlayerInfo[playerid][dbZ], PlayerInfo[playerid][dbR], 0, 0, 0, 0, 0, 0 );
	}
	SetPlayerHealth(playerid, PlayerInfo[playerid][dbSalud]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][dbBlindaje]);
    SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	return 1;
}

function:SavePlayerData(playerid)
{
	PlayerInfo[playerid][dbX] = GetCoorPlayer(playerid, 0);
	PlayerInfo[playerid][dbY] = GetCoorPlayer(playerid, 1);
	PlayerInfo[playerid][dbZ] = GetCoorPlayer(playerid, 2);
	PlayerInfo[playerid][dbR] = GetCoorPlayer(playerid, 3);
	PlayerInfo[playerid][dbSalud] = GetHealth(playerid);
	PlayerInfo[playerid][dbBlindaje] = GetArmour(playerid);

	new Query[256];
	mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `posicion_x` = %f, `posicion_y` = %f, `posicion_z` = %f, `posicion_r` = %f, `salud` = %f, `blindaje` = %f WHERE `id` = %i",
	 PlayerInfo[playerid][dbX], PlayerInfo[playerid][dbY], PlayerInfo[playerid][dbZ], PlayerInfo[playerid][dbR], PlayerInfo[playerid][dbSalud], PlayerInfo[playerid][dbBlindaje], PlayerInfo[playerid][dbID]);
	mysql_tquery(db_conn, Query, "DataPlayerSaved", "i", playerid);
}

function:GetPlayerData(playerid)
{
	new Query[256];
	new rows, fields;
	mysql_format(db_conn, Query, sizeof(Query), "SELECT posicion_x, posicion_y, posicion_z, posicion_r, salud, blindaje FROM usuarios_data WHERE id = %i", PlayerInfo[playerid][dbID]);
	new Cache:result = mysql_query(db_conn, Query);
	cache_get_data(rows, fields, db_conn);

	PlayerInfo[playerid][dbSalud] = cache_get_field_content_int(0, "salud", db_conn);
	PlayerInfo[playerid][dbBlindaje] = cache_get_field_content_int(0, "blindaje", db_conn);
	PlayerInfo[playerid][dbX] = cache_get_field_content_int(0, "posicion_x", db_conn);
	PlayerInfo[playerid][dbY] = cache_get_field_content_int(0, "posicion_y", db_conn);
	PlayerInfo[playerid][dbZ] = cache_get_field_content_int(0, "posicion_z", db_conn);
	PlayerInfo[playerid][dbR] = cache_get_field_content_int(0, "posicion_r", db_conn);

	cache_delete(result);
}

function:ResetPlayer(playerid)
{
	PlayerInfo[playerid][dbID] = 0;
	PlayerInfo[playerid][dbLoggedIn] = false;
	PlayerInfo[playerid][dbVehUnoID] = 0;
	PlayerInfo[playerid][dbVehDosID] = 0;
	PlayerInfo[playerid][dbX] = -1465.200683;
	PlayerInfo[playerid][dbY] = 2608.702148;
	PlayerInfo[playerid][dbZ] = 55.835937;
	PlayerInfo[playerid][dbR] = 182.3;
	PlayerInfo[playerid][dbSalud] = 100;
	PlayerInfo[playerid][dbBlindaje] = 0;
	SendClientMessage(playerid, 0xf0f0f0, "Limpié los datos del usuario");
}

function:SetRectangle(playerid, option) // 0 Creamos - 1 Borramos.
{

	if (option == 1)
	{
        //TextDrawHideForPlayer(playerid, BarraInicioDos);
		//TextDrawHideForPlayer(playerid, BarraInicio);
		TextDrawDestroy(BarraInicioDos);
		TextDrawDestroy(BarraInicio);
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
	}
	
	return 1;
}
function:CreateVehiclePlayer(playerid, typevehicle)
{
	new Query[512];
	new rows, fields;
	mysql_format(db_conn, Query, sizeof(Query), "SELECT * FROM vehiculos_data WHERE propietario = '%s'", GetName(playerid));
	new Cache:result = mysql_query(db_conn, Query);
	cache_get_data(rows, fields, db_conn);
	switch(typevehicle)
	{
		case 0:
		{
			PlayerInfo[playerid][dbVehUnoID] = AddStaticVehicleEx(cache_get_field_content_int(0, "modelo_uno", db_conn),
	 		 cache_get_field_content_int(0, "pos_x_uno", db_conn),
			 cache_get_field_content_int(0, "pos_y_uno", db_conn),
			 cache_get_field_content_int(0, "pos_z_uno", db_conn),
			 cache_get_field_content_int(0, "pos_r_uno", db_conn), -1, -1, -1);
			SetVehicleParamsEx(PlayerInfo[playerid][dbVehUnoID], cache_get_field_content_int(0, "motor_estado_uno", db_conn), 0, 0, 0, 0, 0, 0);
			print("Creé un vehículo");
		}
		case 1:
		{
			PlayerInfo[playerid][dbVehDosID] = AddStaticVehicleEx(cache_get_field_content_int(0, "modelo_dos", db_conn),
	 		 cache_get_field_content_int(0, "pos_x_dos", db_conn),
			 cache_get_field_content_int(0, "pos_y_dos", db_conn),
			 cache_get_field_content_int(0, "pos_z_dos", db_conn),
			 cache_get_field_content_int(0, "pos_r_dos", db_conn), -1, -1, -1);
			SetVehicleParamsEx(PlayerInfo[playerid][dbVehDosID], cache_get_field_content_int(0, "motor_estado_dos", db_conn), 0, 0, 0, 0, 0, 0);
			print("Creé un vehículo");
		}
	}
	cache_delete(result)
}
function:IsPlayerInHisVehicle(playerid,vehicleid)
{
	new bool:answer;
	if(vehicleid == PlayerInfo[playerid][dbVehUnoID]) answer = true;
	if(vehicleid == PlayerInfo[playerid][dbVehDosID]) answer = true;

	return answer;
}
function:OnPlayerStopVehicle(playerid, vehicleid, vehiclemodel)
{
	new Float:x;
	new Float:y;
	new Float:z;
	new Float:r;
	new Float:health;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, r);
	GetVehicleHealth(vehicleid, health);

	new Query[512];

	if(vehicleid == PlayerInfo[playerid][dbVehUnoID])
	{
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `vehiculos_data` SET `modelo_uno` = %i, `salud_uno` = %f, `pos_x_uno` = %f, `pos_y_uno` = %f, `pos_z_uno` = %f, `pos_r_uno` = %f WHERE `propietario` = '%s'", vehiclemodel, health, x,y,z,r, GetName(playerid));
		mysql_tquery(db_conn, Query, "SaveVehicle", "i", playerid);
	}
	if(vehicleid == PlayerInfo[playerid][dbVehDosID])
	{
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `vehiculos_data` SET `modelo_uno` = %i, `salud_dos` = %f, `pos_x_dos` = %f, `pos_y_dos` = %f, `pos_z_dos` = %f, `pos_r_dos` = %f WHERE `propietario` = '%s'", vehiclemodel, health, x,y,z,r, GetName(playerid));
	}
}
function:OnPlayerBuyVehicle(playerid,vehiclemodel)
{
	if (PlayerInfo[playerid][dbVehUnoID] == 0)
	{
		PlayerInfo[playerid][dbVehUnoID] = AddStaticVehicleEx(vehiclemodel, -1291.750122, 2677.588623, 49.658771, 178.95, -1, -1, -1);
		PutPlayerInVehicle(playerid, PlayerInfo[playerid][dbVehUnoID], 0);
		SetVehicleParamsEx(PlayerInfo[playerid][dbVehUnoID], 0, 0, 0, 0, 0, 0, 0);
		SetTimerEx("OnPlayerStopVehicle", 500, false, "iii", playerid, PlayerInfo[playerid][dbVehUnoID], vehiclemodel);
		SetPVarInt(playerid, "VehValido", 1);

		new Query[256];
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `vehiculo_uno` = %i WHERE id = %i", 1, PlayerInfo[playerid][dbID]);
		mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
	}
	else if(PlayerInfo[playerid][dbVehDosID] == 0)
	{
		PlayerInfo[playerid][dbVehDosID] = AddStaticVehicleEx(vehiclemodel, -1291.750122, 2677.588623, 49.658771, 178.95, -1, -1, -1);
		PutPlayerInVehicle(playerid, PlayerInfo[playerid][dbVehDosID], 0);
		SetVehicleParamsEx(PlayerInfo[playerid][dbVehDosID], 0, 0, 0, 0, 0, 0, 0);
		SetTimerEx("OnPlayerStopVehicle", 500, false, "iii", playerid, PlayerInfo[playerid][dbVehDosID], vehiclemodel);
		SetPVarInt(playerid, "VehValido", 1)

		new Query[256];
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `vehiculo_dos` = %i WHERE id = %i", 1, PlayerInfo[playerid][dbID]);
		mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
	}
	else
	{
		SendClientMessage(playerid, 0xF00F00, "Podés comprar hasta dos (2) vehículos. Adquirí VIP para comprar más.");
	}
}
function:SaveVehicle(playerid)
{
	new string[128];
	format(string, 128, "Vehículo de %s guardado.", GetName(playerid));
	print(string);
}
function:SetPlayerCamera(playerid)
{
	SetPlayerCameraPos(playerid, 2019.1145, 1202.9185, 42.3246);
    SetPlayerCameraLookAt(playerid, 2019.9889, 1202.4272, 42.2945);
}

function:GetJobsPlayer(playerid)
{
	new Query[256];
	new rows, fields;
	new jobToReturn;

	mysql_format(db_conn, Query, sizeof(Query), "SELECT trabajo_uno FROM usuarios_data WHERE id = %i", PlayerInfo[playerid][dbID]);
	new Cache:result = mysql_query(db_conn, Query);
	cache_get_data(rows, fields, db_conn);
	jobToReturn = cache_get_field_content_int(0, "trabajo_uno", db_conn);
	cache_delete(result)
	return jobToReturn;
}
function:SetJobsPlayer(playerid, idjob)
{
	new Query[256];
	mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `trabajo_uno` = %i WHERE `id` = %i",idjob,PlayerInfo[playerid][dbID]);
	mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
}

function:GetSkinsPlayer(playerid, typeskin)
{
	new Query[256];
	new rows, fields;
	new skinToReturn;
	mysql_format(db_conn, Query, sizeof(Query), "SELECT skin_uno, skin_dos, skin_actual FROM usuarios_data WHERE id = %i", PlayerInfo[playerid][dbID]);
	new Cache:result = mysql_query(db_conn, Query);
	cache_get_data(rows, fields, db_conn);
	
	switch(typeskin)
	{
		case 0: skinToReturn = cache_get_field_content_int(0, "skin_uno", db_conn);
		case 1: skinToReturn = cache_get_field_content_int(0, "skin_dos", db_conn);
		case 2: skinToReturn = cache_get_field_content_int(0, "skin_actual", db_conn);
	}
	cache_delete(result);
	return skinToReturn;
}
function:SetSkinsPlayer(playerid, typeskin, skinid, skinactual)
{
	new Query[256];
	if (typeskin == 0)
	{
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `skin_uno` = %i, `skin_actual` = %i WHERE `id` = %i", skinid, skinactual, PlayerInfo[playerid][dbID]);
		mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
	}
	if (typeskin == 1)
	{
		mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `skin_dos` = %i, `skin_actual` = %i WHERE `id` = %i", skinid, skinactual, PlayerInfo[playerid][dbID]);
		mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
	}
}
function:GetEngineState(playerid, typevehicle)
{
	new Query[256];
	new rows, fields;
	new stateToReturn;

	mysql_format(db_conn, Query, sizeof(Query), "SELECT motor_estado_uno, motor_estado_dos FROM vehiculos_data WHERE propietario = '%s'", GetName(playerid));
	new Cache:result = mysql_query(db_conn, Query);
	cache_get_data(rows, fields, db_conn);

	if (typevehicle == 0) stateToReturn = cache_get_field_content_int(0, "motor_estado_uno", db_conn);
	if (typevehicle == 1) stateToReturn = cache_get_field_content_int(0, "motor_estado_dos", db_conn);
	cache_delete(result);
	return stateToReturn;
}
function:SetEngineState(playerid, typevehicle, stateengine)
{
	new Query[256];
	switch(typevehicle)
	{
		case 0: mysql_format(db_conn, Query, sizeof(Query), "UPDATE `vehiculos_data` SET `motor_estado_uno` = %i WHERE `propietario` = '%s'", stateengine, GetName(playerid));
		case 1: mysql_format(db_conn, Query, sizeof(Query), "UPDATE `vehiculos_data` SET `motor_estado_dos` = %i WHERE `propietario` = '%s'", stateengine, GetName(playerid));
	}
	mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);
}


function:DataBaseUpdate(playerid)
{
	new string[128];
	format(string, 128, "Actualicé la db (%s)", GetName(playerid));
	print(string);
}
function:DataPlayerSaved(playerid)
{
	new string[128];
	format(string, 128, "Se guardaron los datos de: (%s)", GetName(playerid));
	print(string);
	ResetPlayer(playerid);
}