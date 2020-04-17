#include <a_samp>
#include <sscanf2>
#include <zcmd>

public OnFilterScriptInit()
{
    print("\n Comandos de administrador cargados.\n");
	return 1;
}

CMD:vehiculo(playerid, params[])
{
    SendClientMessage(playerid, 0xADFFFFAD, "Creaste un vehï¿½culo.");
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
    SendClientMessage(playerid, 0xFFFFFFF, string);
    return 1;
}
CMD:jetpack(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    CreatePickup(370, 4, x, y, z);
    return 1;
}
CMD:rotation(playerid, params[])
{
    new Float:Angle, string[26];
    GetPlayerFacingAngle(playerid, Angle);
    format(string, sizeof(string), "tu rotacion es: %0.2f", Angle);
    SendClientMessage(playerid, 0xFFFFFFFF, string);
    return 1;
}
CMD:irv(playerid, params[])
{
    if(isnull(params))
    {
        return SendClientMessage(playerid, -1, "Usá /irv <ID del vehículo>");
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
CMD:anim(playerid, params[])
{
    ApplyAnimation(playerid, "baseball", "Bat_4", 1.0, 0, 1, 1, 0, 3000, 1);
    
    return 1;
}