#include <foreach>

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}
stock isVehicleCamionero(playerid)
{
	new validado;

    new vehicleid = GetPlayerVehicleID(playerid);
    if (IsPlayerInAnyVehicle(playerid))
    {
        if (GetVehicleModel(vehicleid) == 440)
		{
		validado = 1;
		}else
		{
		validado = 0;
		}
    }
    return validado;
}
stock KickEx(playerid)
{
    return SetTimerEx("KickTimer", 100, false, "i", playerid);
}
stock Float:GetCoorPlayer(playerid, position)
{
	new Float:x;
	new Float:y;
	new Float:z;
	new Float:Angle;
	
	new Float: coor;

    GetPlayerFacingAngle(playerid, Angle);
	GetPlayerPos(playerid, x, y, z);
	if (position == 0)
	{
		coor= x;
	}
	if (position == 1)
	{
		coor= y;	
	}
	if (position == 2)
	{
		coor= z;
	}
	if (position == 3)
	{
		coor= Angle;
	}
	return coor;
}
stock GetVehID(playerid)
{
	return GetPlayerVehicleID(playerid);
}
stock Float:GetHealth(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	return health;
}
stock Float:GetArmour(playerid)
{
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	return armour;
}
// ERROR 0 || WELLDONE 1 || ME 2 || DO 3 || $$$ + 4 || $$$ - 5 || S 6 || G 7 || B 8 || I 9 ||
stock FormatMssg(playerid, type, string[], playername[])
{
	new newString[256];
	switch(type)
	{
		case 0: 
		{
			format(newString, 256, "{C0392B}<!>{FFFFFF} %s", string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 1:
		{
			format(newString, 256, "{196D3C}<!>{FFFFFF} %s", string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 2:
		{
			format(newString, 256, "{F1C40F}* %s %s", playername, string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 3:
		{
			format(newString, 256, "{F1C40F}* %s ( %s )", string, playername);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 4:
		{
			format(newString, 256, "{1E8449}<$> {FFFFFF}Se agregaron {1E8449}( %s ) {FFFFFF}a tu cuenta.", string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 5:
		{
			format(newString, 256, "{850A0A}<$> {FFFFFF}Se quitaron {850A0A}( %s ) {FFFFFF}de tu cuenta.", string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 6:
		{
			format(newString, 256, "{FFFFFF} %s susurra: %s", playername, string)
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 7:
		{
			format(newString, 256, "{FFFFFF} %s grita: ¡¡%s!!", playername, string)
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 8:
		{
			format(newString, 256, "{FFFFFF} %s (%i) (( %s ))", playername, playerid, string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 9:
		{
			format(newString, 256, "{F39C12}<i> [Info] {006E6E}%s (%i) : %s", GetName(playerid), playerid, string)
			SendClientMessageToAll(0xFFFFFFFF, newString);
		}
		case 10:
		{
			format(newString, 256, "{FFFFFF} %s : %s", playername, string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		default: print("Es un número no conocido.");
	}
}

stock DetectarProxim(playerid, Float:radio, string[], type)
{
	new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
	new name[MAX_PLAYER_NAME+1];
	name = GetName(playerid);
	if (type == 2)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 2, string, name);
		}
	}
	if (type == 3)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 3, string, name);
		}
	}
	if (type == 6)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 6, string, name);
		}
	}
	if (type == 7)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 7, string, name);
		}
	}
	if(type == 8)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 8, string, name);
		}
	}
	if(type == 10)
	{
		foreach(Player,i)
		{
			if(IsPlayerInRangeOfPoint(i,radio,x,y,z)) FormatMssg(i, 10, string, name);
		}
	}
}



/*function:SetLevelPlayer(playerid, newlevel)
{
	new Query[256];
	new oldlevel, levelupdate;
	levelupdate = oldlevel + newlevel;
	mysql_format(db_conn, Query, sizeof(Query), "UPDATE `usuarios_data` SET `nivel` = %i WHERE `id` = %i", levelupdate, PlayerInfo[playerid][dbID]);
	mysql_tquery(db_conn, Query, "DataBaseUpdate", "i", playerid);

	SetTimerEx("CalcularExp", 400, false, "i", playerid);
}*/