#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/utilitis.inc"
#include "../include/pickups.inc"


#define   function:%0(%1) forward %0(%1); public %0(%1)


public OnFilterScriptInit()
{
    print("\n Trabajos cargados\n");
	return 1;
}

public OnGameModeInit()
{
    CreateObject(1457, -2408.03345, 2388.98438, 9.00038,   11.28000, 2.52000, -3.72001);
    CreateObject(1452, -2411.72510, 2388.29053, 8.37882,   7.00000, 0.00000, 0.00000);
    CreateObject(18862, -2373.41602, 2371.14380, 6.86773,   0.00000, 0.00000, 0.00000);
}
new RECORRIDOCAMIONERO;



CMD:recorrido(playerid, params[])
{
    if(isnull(params))
    {
        return SendClientMessage(playerid, -1, "Usa: /recorrido [nombre-del-trabajo]");
    }
    if (!strcmp(params, "camionero", true))
    {
        if (GetPVarInt(playerid, "dbTrabajoUno") == 1)
        {
            if (isVehicleCamionero(playerid) == 1)
            {
  	            SendClientMessage(playerid, 0xFFFFFF, "Dirigete al punto para cagar el camión.");
                SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
                RECORRIDOCAMIONERO = 0;
            }else
            {
                SendClientMessage(playerid, 0xFFFFFF, "No estás en el vehículo adecuado.");
	        }
        }else
        {
            SendClientMessage(playerid, 0xFFFFFF, "No tenés el trabajo de camionero.");
        }
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {

    /* ================================  CAMIONEROS  ========================================== */

    if (isVehicleCamionero(playerid) == 1)
    {
        // Primero comprobamos si el recorrido estÃ¡ en la Ãºltima instancia.
        // Si es asÃ­, desactivamos cp, respawneamos el vehÃ­culo y le decimos al jugador.
        if (RECORRIDOCAMIONERO == 2)
        {
            new VehID;
            VehID = GetPlayerVehicleID(playerid);
            DisablePlayerCheckpoint(playerid);
            SetVehicleToRespawn(VehID);
            SetVehicleParamsEx(VehID, 0, 0, 0, 0, 0, 0, 0);
            SendClientMessage(playerid, 0xFFFFFF, "Completaste el trabajo, acá esta la paga.");
            RECORRIDOCAMIONERO = 0;

        // Comprobamos si ya cargÃ³ el camiÃ³n. Desactivamos cp anterior y le decimos al jugador.
        }else if (RECORRIDOCAMIONERO == 1)
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
            SendClientMessage(playerid, 0xFFFFFF, "Bien hecho!, volvé a la sucursal para devolver el camión y obtener tu paga.");
            RECORRIDOCAMIONERO = 2;
        }else
        {
            // AcÃ¡ empieza todo.
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -1519.365844, 2572.802490, 55.835937, 10);
            SendClientMessage(playerid, 0xFFFFFF, "Vehículo cargado. Ve al punto para entregar la carga.");
            RECORRIDOCAMIONERO = 1;
        }
    }
}


//SetTimerEx("ActivarControl",5000,false,"i",playerid);



// ======================== FUNCTIONS ========================= //

function:ActivarControl(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}