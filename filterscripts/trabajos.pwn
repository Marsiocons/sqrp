#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/utilitis.inc"
#include "../include/pickups.inc"

public OnFilterScriptInit()
{
    print("\n Trabajos cargados\n");
	return 1;
}

new RECORRIDOCAMIONERO;

CMD:trabajo(playerid, params[])
{
    if(isnull(params))
    {
        return SendClientMessage(playerid, -1, "Usa: /trabajo [nombre-del-trabajo]");
    }
    if (!strcmp(params, "camionero", true))
    {
        if (IsPlayerInRangeOfPoint(playerid, 2,
         coorPickCamioneros[0],
         coorPickCamioneros[1],
         coorPickCamioneros[2]))
        {
            SendClientMessage(playerid, 0xFFFFFF, "Obtuviste el trabajo de camionero.");
 	        SendClientMessage(playerid, 0xFFFFFF, "Usa /recorrido camionero");
  	        SendClientMessage(playerid, 0xFFFFFF, "Para empezar a trabajar.");
        }else
        {
  	        SendClientMessage(playerid, 0xFFFFFF, "No estás en el lugar adecuado.");
        }
    }
    return 1;
}

CMD:recorrido(playerid, params[])
{
    if(isnull(params))
    {
        return SendClientMessage(playerid, -1, "Usa: /recorrido [nombre-del-trabajo]");
    }
    if (!strcmp(params, "camionero", true))
    {
        if (isVehicleCamionero(playerid) == 1)
        {
  	        SendClientMessage(playerid, 0xFFFFFF, "Dirigete al punto para cagar el camion.");
            SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
            RECORRIDOCAMIONERO = 0;
        }else
        {
            SendClientMessage(playerid, 0xFFFFFF, "No estas en el vehiculo adecuado.");
	    }
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {

    /* ================================  CAMIONEROS  ========================================== */

    if (isVehicleCamionero(playerid) == 1)
    {
        // Primero comprobamos si el recorrido está en la última instancia.
        // Si es así, desactivamos cp, respawneamos el vehículo y le decimos al jugador.
        if (RECORRIDOCAMIONERO == 2)
        {
            DisablePlayerCheckpoint(playerid);
            SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            SendClientMessage(playerid, 0xFFFFFF, "Completaste el trabajo, aca esta la paga.");
            RECORRIDOCAMIONERO = 0;

        // Comprobamos si ya cargó el camión. Desactivamos cp anterior y le decimos al jugador.
        }else if (RECORRIDOCAMIONERO == 1)
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
            SendClientMessage(playerid, 0xFFFFFF, "Bien hecho!, vuelve a la sucursal para devolver el camión y obtener tu paga.");
            RECORRIDOCAMIONERO = 2;
        }else
        {
            // Acá empieza todo.
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -1519.365844, 2572.802490, 55.835937, 10);
            SendClientMessage(playerid, 0xFFFFFF, "Vehiculo cargado. Ve al punto para entregar la carga.");
            RECORRIDOCAMIONERO = 1;
        }
    }
}