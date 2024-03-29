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
    FormatMssg(playerid, 1, "Creaste un veh�culo.", " ");
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

    format(string, sizeof(string), "Tu posici�n es : (%f), (%f), (%f)", x,y,z);
    FormatMssg(playerid, 1, string, " ");
    return 1;
}
CMD:jetpack(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreatePickup(370, 4, x, y, z);
    FormatMssg(playerid, 1, "Creaste un jetpack", " ")
    return 1;
}
CMD:rotation(playerid, params[])
{
    new Float:Angle, string[26];
    GetPlayerFacingAngle(playerid, Angle);
    format(string, sizeof(string), "tu rotaci�n es: %0.2f", Angle);
    FormatMssg(playerid, 1, string, " ");
    return 1;
}
CMD:irv(playerid, params[])
{
    if(isnull(params))
    {
        FormatMssg(playerid, 1, "Us� /irv <ID del veh�culo>", " ");
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

CMD:experiencia(playerid, params[])
{
	new cantidad, string[128];
	if(sscanf(params, "i", cantidad))
	{
		SendClientMessage(playerid, -1, "Us�: /experiencia (cantidad)");
	}
	else 
	{
        CallRemoteFunction("SetExpPlayer", "ii", playerid, cantidad);
		//SetExpPlayer(playerid, cantidad);
		format(string, sizeof(string), "Modificaste tu experiencia ( %i )", cantidad);
		FormatMssg(playerid, 1, string, " ");
	}
	return 1;
}

CMD:nivel(playerid, params[])
{
    new cantidad, string[128];
	if(sscanf(params, "i", cantidad))
	{
		FormatMssg(playerid, 0, "Us�: /nivel (nivel)", " ");
	}
    else
    {
        CallRemoteFunction("SetLevelPlayer", "ii", playerid, cantidad);
		format(string, sizeof(string), "Modificaste tu nivel ( %i )", cantidad);
		FormatMssg(playerid, 1, string, " ");
    }
    return 1;
}
CMD:money(playerid, params[])
{
    new cantidad, string[128];
	if(sscanf(params, "i", cantidad))
	{
		FormatMssg(playerid, 0, "Us�: /money (cantidad)", " ");
	}
    else
    {
        CallRemoteFunction("SetMoneyPlayer", "iii", playerid, 0, cantidad);
		format(string, sizeof(string), "Modificaste tu dinero en mano ( %i )", cantidad);
		FormatMssg(playerid, 1, string, " ");
    }
    return 1;
}