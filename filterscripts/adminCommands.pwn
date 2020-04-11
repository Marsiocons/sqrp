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
    SendClientMessage(playerid, 0xADFFFFAD, "Creaste un vehículo.");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    CreateVehicle(494, x, y, z, 0, -1, -1, 100)
    return 1;
}