#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/utilitis.inc"
#include "../include/pickups.inc"

new SkinsCamionero[3] = {182,261,100};

public OnFilterScriptInit()
{
    print("\n Comandos de jugadores cargados.\n");
	return 1;
}

CMD:cuenta(playerid, params[])
{
    new dbNombre[MAX_PLAYER_NAME+1];
    new dbTrabajoUno;
    new dbVehiculoUno;
    new dbDineroMano;
    new dbDineroBanco;
    new string[32];

    GetPVarString(playerid, "dbNombre", dbNombre, sizeof(dbNombre));
    dbTrabajoUno = GetPVarInt(playerid, "dbTrabajoUno");
    dbVehiculoUno = GetPVarInt(playerid, "dbVehiculoUno");
    dbDineroMano = GetPVarInt(playerid, "dbDineroMano");
    dbDineroBanco = GetPVarInt(playerid, "dbDineroBanco");

    format(string, sizeof(string), "Tu nombre es: %s", dbNombre);
    SendClientMessage(playerid, 0xFFFFCC, string);
    
    if (dbTrabajoUno == 0)
    {
        SendClientMessage(playerid, 0xFFFFCC, "Estás desempleado.");
    }
    if (dbTrabajoUno == 1)
    {
        SendClientMessage(playerid, 0xFFFFCC, "Estás trabajando como camionero.");
    }
    if (dbVehiculoUno == 0)
    {
        SendClientMessage(playerid, 0xFFFFCC, "No tenés vehículos.");
    }

    format(string, sizeof(string), "Tenés $%i en mano.", dbDineroMano);
    SendClientMessage(playerid, 0xFFFFCC, string);

    format(string, sizeof(string), "Tenés $%i en banco.", dbDineroBanco);
    SendClientMessage(playerid, 0xFFFFCC, string);

    return 1;
}

CMD:renunciar(playerid, params[])
{
    new trabajo = GetPVarInt(playerid, "dbTrabajoUno");

    if (trabajo == 0)
    {
        SendClientMessage(playerid, 0xFFFFAA, "No tenés trabajo al cual renunciar.");
    }else
    {
        SendClientMessage(playerid, 0xFFFFAA, "Renunciaste a tu trabajo. Ahora estás desempleado");
        SetPVarInt(playerid, "dbTrabajoUno", 0);
    }
    return 1;
}

CMD:uniforme(playerid, params[])
{
    if(isnull(params))
    {
        return SendClientMessage(playerid, -1, "Usá: /uniforme [nombre-del-trabajo]");
    }
    if (!strcmp(params, "camionero", true))
    {
        if(GetPVarInt(playerid, "dbTrabajoUno") == 1)
        {
            if (IsPlayerInRangeOfPoint(playerid, 2,
                    coorPickCamionerosV[0],
                    coorPickCamionerosV[1],
                    coorPickCamionerosV[2]))
            {
                if (GetPVarInt(playerid, "dbSkinDos") == 0)
                {
                    SendClientMessage(playerid, 0x003300, "Se cambió de ropa y está listo para trabajar");
                    SetPVarInt(playerid, "dbSkinDos", SkinsCamionero[random(3)]);
                    SetPVarInt(playerid, "dbSkinActual", 1);
                    SetPlayerSkin(playerid, GetPVarInt(playerid, "dbSkinDos"));
                }
                else
                {
                    SendClientMessage(playerid, 0xAAFFFFAA, "Error, ya tenes puesto un uniforme. Primero usá /vestirse.");
                }
            }
            else
            {
                SendClientMessage(playerid, 0xAAFFFFAA, "No estás en el lugar adecuado.");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xAAFFAA, "No tenés el /trabajo camionero.");
        }
    }
    return 1;
}

CMD:vestirse(playerid, params[])
{
    if (GetPVarInt(playerid, "dbSkinDos") > 0)
    {
        SetPVarInt(playerid, "dbSkinDos", 0);
        SetPVarInt(playerid, "dbSkinActual", 0);
        SetPlayerSkin(playerid, GetPVarInt(playerid, "dbSkinUno"));
        SendClientMessage(playerid, 0x003300, "Se cambio de ropa.");
    }
    else
    {
        SendClientMessage(playerid, 0xAAFFFFAA, "No tenés puesto ningún uniforme.");
    }
    return 1;
}