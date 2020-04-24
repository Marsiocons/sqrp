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
        FormatMssg(playerid, 0, "Usa: /recorrido [nombre-del-trabajo]", " ");
    }
    if (!strcmp(params, "camionero", true))
    {
        if (CallRemoteFunction("GetJobsPlayer", "i", playerid) == 1)
        {
            if (isVehicleCamionero(playerid) == 1)
            {
  	            FormatMssg(playerid, 1, "Dirigete al punto para cagar el cami�n.", " ");
                SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
                RECORRIDOCAMIONERO = 0;
            }else
            {
                FormatMssg(playerid, 0, "No est�s en el veh�culo adecuado.", " ");
	        }
        }else
        {
            FormatMssg(playerid, 0, "No ten�s el trabajo de camionero.", " ");
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
            new VehID;
            VehID = GetPlayerVehicleID(playerid);
            DisablePlayerCheckpoint(playerid);
            SetVehicleToRespawn(VehID);
            SetVehicleParamsEx(VehID, 0, 0, 0, 0, 0, 0, 0);
            FormatMssg(playerid, 1, "Completaste el trabajo, ac� est� la paga.", " ");
            CallRemoteFunction("CalcularDineroJob", "i", playerid);
            
            
            RECORRIDOCAMIONERO = 0;

        // Comprobamos si ya cargó el camión. Desactivamos cp anterior y le decimos al jugador.
        }else if (RECORRIDOCAMIONERO == 1)
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -554.442199, 2617.287841, 53.515625, 10);
            FormatMssg(playerid, 1, "Bien hecho!, volv� a la sucursal para devolver el cami�n y obtener tu paga.", " ");
            RECORRIDOCAMIONERO = 2;
        }else
        {
            // Acá empieza todo.
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, -1519.365844, 2572.802490, 55.835937, 10);
            FormatMssg(playerid, 1, "Veh�culo cargado. Ve al punto para entregar la carga.", " ");
            RECORRIDOCAMIONERO = 1;
        }
    }
}

// ======================== FUNCTIONS ========================= //

function:ActivarControl(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}