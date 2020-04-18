#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/utilitis.inc"
#include "../include/pickups.inc"

#define   function:%0(%1) forward %0(%1); public %0(%1)


new SkinsCamionero[3] = {182,261,100};
new SkinsObrero[3] = {16,27,153};

public OnFilterScriptInit()
{
    print("\n Comandos de jugadores cargados.\n");
	return 1;
}

CMD:cuenta(playerid, params[])
{
    new string[300];
    format(string, sizeof(string), "Tu trabajo es: %i", CallRemoteFunction("GetJobsPlayer", "i", playerid));
    FormatMssg(playerid, 1, string);
    return 1;
}

CMD:renunciar(playerid, params[])
{

    if (CallRemoteFunction("GetJobsPlayer", "i", playerid) == 0)
    {
        FormatMssg(playerid, 0, "No ten�s trabajo al cual renunciar.");
    }else
    {
        FormatMssg(playerid, 1, "Renunciaste a tu trabajo. Ahora est�s desempleado");
        CallRemoteFunction("SetJobsPlayer", "ii", playerid, 0);
    }
    return 1;
}

CMD:uniforme(playerid, params[])
{
    if(isnull(params))
    {
        FormatMssg(playerid, 0, "Us�: /uniforme [nombre-del-trabajo]");
    }
    if (!strcmp(params, "camionero", true))
    {
        if(CallRemoteFunction("GetJobsPlayer", "i", playerid) == 1)
        {
            if (IsPlayerInRangeOfPoint(playerid, 2,
                    coorPickCamionerosV[0],
                    coorPickCamionerosV[1],
                    coorPickCamionerosV[2]))
            {
                if (CallRemoteFunction("GetSkinsPlayer", "ii", playerid, 1) == 0)
                {
                    new string[128];
                    new skinid = SkinsCamionero[random(3)];
                    CallRemoteFunction("SetSkinsPlayer", "iiii", playerid, 1, skinid, 1);

                    format(string, sizeof(string), "%s se cambi� de ropa (%i) y est� listo para trabajar.", GetName(playerid), skinid);
                    FormatMssg(playerid, 1, string);
                    SetPlayerSkin(playerid, skinid);
                }
                else
                {
                    FormatMssg(playerid, 0, "Error, ya tenes puesto un uniforme. Primero us� /vestirse.");
                }
            }
            else
            {
                FormatMssg(playerid, 0, "No est�s en el lugar adecuado.");
            }
        }
        else
        {
            FormatMssg(playerid, 0, "No ten�s el /trabajo camionero.");
        }
    }
    if (!strcmp(params, "obrero", true))
    {
        if(CallRemoteFunction("GetJobsPlayer", "i", playerid) == 2)
        {
            if (IsPlayerInRangeOfPoint(playerid, 2,
                    coorPickObreroV[0],
                    coorPickObreroV[1],
                    coorPickObreroV[2]))
            {
                if (CallRemoteFunction("GetSkinsPlayer", "ii", playerid, 1) == 0)
                {
                    new string[128];
                    new skinid = SkinsObrero[random(3)];
                    CallRemoteFunction("SetSkinsPlayer", "iiii", playerid, 1, skinid, 1);

                    format(string, sizeof(string), "%s se cambi� de ropa (%i) y est� listo para trabajar.", GetName(playerid), skinid);
                    FormatMssg(playerid, 1, string);
                    SetPlayerSkin(playerid, skinid);
                }
                else
                {
                    FormatMssg(playerid, 0, "Error, ya tenes puesto un uniforme. Primero us� /vestirse.");
                }
            }
            else
            {
                FormatMssg(playerid, 0, "No est�s en el lugar adecuado.");
            }
        }
        else
        {
            FormatMssg(playerid, 0, "No ten�s el /trabajo obrero.");
        }
    }

    return 1;
}

CMD:vestirse(playerid, params[])
{
    if (CallRemoteFunction("GetSkinsPlayer", "ii", playerid, 1) > 0)
    {
        new string[128];

        CallRemoteFunction("SetSkinsPlayer", "iiii", playerid, 1, 0, 0);
        SetPlayerSkin(playerid, CallRemoteFunction("GetSkinsPlayer", "ii", playerid, 0));

        format(string, sizeof(string), "%s se cambi� de ropa.", GetName(playerid));
        FormatMssg(playerid, 1, string);
    }
    else
    {
        FormatMssg(playerid, 0, "No ten�s puesto ning�n uniforme.");
    }
    return 1;
}

CMD:trabajo(playerid, params[])
{
    if(isnull(params))
    {
        FormatMssg(playerid, 0, "Us�: /trabajo [nombre-del-trabajo]");
    }
    if (CallRemoteFunction("GetJobsPlayer", "i", playerid) != 0)
    {
        FormatMssg(playerid, 0, "Error, ya ten�s un trabajo. Us� /renunciar.");
    }
    else
    {
        if (!strcmp(params, "camionero", true))
        {
            if (CallRemoteFunction("GetJobsPlayer", "i", playerid) != 1)
            {
                if (IsPlayerInRangeOfPoint(playerid, 2,
                coorPickCamioneros[0],
                coorPickCamioneros[1],
                coorPickCamioneros[2]))
                {
                    FormatMssg(playerid, 1, "Obtuviste el trabajo de camionero.");
                    FormatMssg(playerid, 1, "Us� /recorrido camionero");
                    FormatMssg(playerid, 1, "Para empezar a trabajar.");
                    CallRemoteFunction("SetJobsPlayer", "ii", playerid, 1);
                }else
                {
                    FormatMssg(playerid, 0, "No est�s en el lugar adecuado.");
                }
            }
            else
            {
                FormatMssg(playerid, 0, "Error, ya ten�s el trabajo de camionero. Us� /cuenta");
            }
        }
        if (!strcmp(params, "obrero", true))
        {
            if (CallRemoteFunction("GetJobsPlayer", "i", playerid) != 2)
            {
                if (IsPlayerInRangeOfPoint(playerid, 2,
                coorPickObrero[0],
                coorPickObrero[1],
                coorPickObrero[2]))
                {
                    FormatMssg(playerid, 1, "Obtuviste el trabajo de obrero.");
                    FormatMssg(playerid, 1, "Us� /juntar para empezar a trabajar.");
                    FormatMssg(playerid, 1, "Para empezar a trabajar.");
                    CallRemoteFunction("SetJobsPlayer", "ii", playerid, 2);
                }
                else
                {
                    FormatMssg(playerid, 0, "No est�s en el lugar adecuado.");
                }

            }
            else
            {
                FormatMssg(playerid, 0, "Error, ya ten�s el trabajo de obrero. (/cuenta)");
            }
        }

    }
    return 1;
}

CMD:comprar(playerid, params[])
{
    if(isnull(params))
    {
        FormatMssg(playerid, 0, "Us�: /comprar [art�culo]");
    }
    if (!strcmp(params, "vehiculo", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehicleid;
            new vehiclemodel;
            vehicleid = GetPlayerVehicleID(playerid);
            vehiclemodel = GetVehicleModel(vehicleid);
            if (vehicleid <= 4)
            {
                FormatMssg(playerid, 1, "Felicitaciones, compraste un veh�culo!")
                CallRemoteFunction("OnPlayerBuyVehicle", "ii", playerid,vehiclemodel);
            }
        }
        else
        {
            FormatMssg(playerid, 0, "No est�s en ning�n veh�culo.")
        }
    }
    return 1;
}

CMD:arrancar(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(GetPVarInt(playerid, "VehValido") == 1)
        {
			new motor, luces, alarma, puertas, capo, baul, arrow, vehicleid;
            vehicleid = GetPlayerVehicleID(playerid)
            GetVehicleParamsEx(vehicleid, motor, luces, alarma, puertas, capo, baul, arrow);
			if(motor == 0)
			{
                if(CallRemoteFunction("IsPlayerInHisVehicle", "ii", playerid,vehicleid)) CallRemoteFunction("SetEngineState", "iii", playerid, 0, 1);
				SetVehicleParamsEx(vehicleid, 1, 1, 0, 0, 0, 0, 0);
				FormatMssg(playerid, 1, "Arranque exitoso.");
			}
			else
			{
				FormatMssg(playerid, 0, "El veh�culo ya est� en marcha.")
			}
        }
        else
        {
            FormatMssg(playerid, 0, "No pod�s manipular este veh�culo.")
        }
    }
    else
    {
        FormatMssg(playerid, 0, "No est�s en ning�n veh�culo.")
    }
    return 1;
}

CMD:detener(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
    {
		if(GetPVarInt(playerid, "VehValido") == 1)
        {
            new motor, luces, alarma, puertas, capo, baul, arrow, vehicleid;
			vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleParamsEx(vehicleid, motor, luces, alarma, puertas, capo, baul, arrow);
			if(motor == 1)
			{
				if(CallRemoteFunction("IsPlayerInHisVehicle", "ii", playerid,vehicleid)) CallRemoteFunction("SetEngineState", "iii", playerid, 0, 0);
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
	            FormatMssg(playerid, 1, "Veh�culo apagado.");
			}
			else
			{
				FormatMssg(playerid, 0, "El veh�culo ya est� apagado.");
			}
		}
		else
        {
            FormatMssg(playerid, 0, "Este veh�culo no se puede manipular.")
        }	
	}
	else
    {
        FormatMssg(playerid, 0, "No est�s en ning�n veh�culo.")
    }
	return 1;
}

CMD:estacionar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
    {
		if(GetPVarInt(playerid, "VehValido") == 1)
        {
			new motor, luces, alarma, puertas, capo, baul, arrow, vehicleid, vehiclemodel;
			vehicleid = GetPlayerVehicleID(playerid);
            vehiclemodel = GetVehicleModel(vehicleid);
            GetVehicleParamsEx(vehicleid, motor, luces, alarma, puertas, capo, baul, arrow);
			if(CallRemoteFunction("IsPlayerInHisVehicle", "ii", playerid,vehicleid))
			{
				if(motor == 0)
				{
                    CallRemoteFunction("OnPlayerStopVehicle", "iii", playerid, vehicleid, vehiclemodel);
					SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
					FormatMssg(playerid, 1, "Veh�culo estacionado.");
				}
				else
				{
					FormatMssg(playerid, 0, "Primero ten�s que /detener tu veh�culo.");
				}
			}
			else
			{
				FormatMssg(playerid, 0, "Este veh�culo no te pertenece.");
			}
		}
		else
        {
            FormatMssg(playerid, 0, "Este veh�culo no se puede manipular.")
        }	
	}
	else
    {
        FormatMssg(playerid, 0, "No est�s en ning�n veh�culo.")
    }	
	return 1;
}

CMD:juntar(playerid, params[])
{
    if(isnull(params))
    {
        if(CallRemoteFunction("GetJobsPlayer", "i", playerid) == 2)
        {
            if (IsPlayerInRangeOfPoint(playerid, 3,
                    coorJobObreroJ[0],
                    coorJobObreroJ[1],
                    coorJobObreroJ[2]))
            {
                if(GetPVarInt(playerid, "OnPlayerPickBox") == 0)
                {
                    ApplyAnimation(playerid, "BASEBALL", "Bat_4", 1.0, false, 1, 1, 0, 5000, 1);
                    CallRemoteFunction("OnPlayerPickBox", "i", playerid);
                    SetPVarInt(playerid, "OnPlayerPickBox", 1);
                }
                else
                {
                    FormatMssg(playerid, 0,"Error, ya juntaste escombros, ahora descartalos en el contenedor");
                }
            }
            else
            {
                FormatMssg(playerid, 0,"No est�s en el lugar adecuado.");
            }
        }
        else
        {
            FormatMssg(playerid, 0,"No ten�s el /trabajo obrero.");
        }
    }
    else
    {
        FormatMssg(playerid, 0,"Utiliz� �nicamente /juntar");
    }
    return 1;
}
CMD:descartar(playerid, params[])
{
    if(isnull(params))
    {
        if(CallRemoteFunction("GetJobsPlayer", "i", playerid) == 2)
        {
            if (IsPlayerInRangeOfPoint(playerid, 3,
                    coorJobObreroT[0],
                    coorJobObreroT[1],
                    coorJobObreroT[2]))
            {
                if (GetPVarInt(playerid, "OnPlayerPickBox") == 1)
                {
                    CallRemoteFunction("OnPlayerDropBox", "i", playerid);
                    SetPVarInt(playerid, "OnPLayerPickBox", 0);
                    FormatMssg(playerid, 4, "150")
                }
                else
                {
                    FormatMssg(playerid, 0, "Primero ten�s que /juntar los escombros");
                }
            }
            else
            {
                FormatMssg(playerid, 0, "No est�s en el lugar adecuado.");
            }
        }
        else
        {
            FormatMssg(playerid, 0, "No ten�s el /trabajo obrero.");
        }
    }
    else
    {
        FormatMssg(playerid, 0, "Utiliz� �nicamente /descartar");
    }
    return 1;
}
CMD:prueba(playerid, params[])
{
    new string[128];
    if(isnull(params))
    {
        format(string, 128, "Utiliz� /prueba <texto>");
        FormatMssg(playerid, 0, string);
        print("Ejecut� FormatMssg");
    }
    if (!strcmp(params, "uno", true))
    {
        format(string, 128, "Felicidades, conseguiste un trabajo!");
        FormatMssg(playerid, 1, string);
    }
    if (!strcmp(params, "dos", true))
    {
        format(string, 128, "se cae al suelo");
        FormatMssg(playerid, 2, string);
    }
    if (!strcmp(params, "tres", true))
    {
        format(string, 128, "Su ropa ahora estar�a toda manchada");
        FormatMssg(playerid, 3, string);
    }
    if (!strcmp(params, "cuatro", true))
    {
        format(string, 128, "$1200");
        FormatMssg(playerid, 4, string);
    }
    if (!strcmp(params, "cinco", true))
    {
        format(string, 128, "$600");
        FormatMssg(playerid, 5, string);
    }
    return 1;
}