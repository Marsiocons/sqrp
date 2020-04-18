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
// ERROR 0 || WELLDONE 1 || ME 2 || DO 3 || $$$ + 4 || %%% - 5 || S 6 || G 7 || I 8 || SMS 9 ||
stock FormatMssg(playerid, type, string[])
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
			format(newString, 256, "{F1C40F}* %s %s", GetName(playerid), string);
			SendClientMessage(playerid, 0xFFFFFFFF, newString);
		}
		case 3:
		{
			format(newString, 256, "{F1C40F}* %s ( %s )", string, GetName(playerid));
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
		default: print("Es un número no conocido.");
	}
}