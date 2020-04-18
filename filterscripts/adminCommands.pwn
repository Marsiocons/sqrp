#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/utilitis.inc"


public OnFilterScriptInit()
{
    print("\n Comandos de administrador cargados.\n");
	return 1;
}

CMD:vehiculo(playerid, params[])
{
    FormatMssg(playerid, 1, "Creaste un vehículo.");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    CreateVehicle(494, x, y, z, 0, -1, -1, 100)
    return 1;
}
CMD:coor(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    new string[128];
    GetPlayerPos(playerid, x, y, z);

    format(string, sizeof(string), "Tu posiciï¿½n es : (%f), (%f), (%f)", x,y,z);
    FormatMssg(playerid, 1, string);
    return 1;
}
CMD:jetpack(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreatePickup(370, 4, x, y, z);
    FormatMssg(playerid, 1, "Creaste un jetpack")
    return 1;
}
CMD:rotation(playerid, params[])
{
    new Float:Angle, string[26];
    GetPlayerFacingAngle(playerid, Angle);
    format(string, sizeof(string), "tu rotación es: %0.2f", Angle);
    FormatMssg(playerid, 1, string);
    return 1;
}
CMD:irv(playerid, params[])
{
    if(isnull(params))
    {
        FormatMssg(playerid, 1, "Usá /irv <ID del vehículo>");
    }
    else
    {
        new Float:x;
        new Float:y;
        new Float:z;
        GetVehiclePos(0, x, y, z);
        SetPlayerPos(playerid, x, y, z);
    }

    return 1;
}