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