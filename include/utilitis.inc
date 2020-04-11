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