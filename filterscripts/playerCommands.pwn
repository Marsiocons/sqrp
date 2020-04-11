#include <a_samp>
#include <sscanf2>
#include <zcmd>

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
        SendClientMessage(playerid, 0xFFFFCC, "Est�s desempleado.");
    }
    if (dbTrabajoUno == 1)
    {
        SendClientMessage(playerid, 0xFFFFCC, "Est�s trabajando como camionero.");
    }
    if (dbVehiculoUno == 0)
    {
        SendClientMessage(playerid, 0xFFFFCC, "No ten�s veh�culos.");
    }

    format(string, sizeof(string), "Ten�s $%i en mano.", dbDineroMano);
    SendClientMessage(playerid, 0xFFFFCC, string);

    format(string, sizeof(string), "Ten�s $%i en banco.", dbDineroBanco);
    SendClientMessage(playerid, 0xFFFFCC, string);

    return 1;
}

CMD:renunciar(playerid, params[])
{
    new trabajo = GetPVarInt(playerid, "dbTrabajoUno");

    if (trabajo == 0)
    {
        SendClientMessage(playerid, 0xFFFFAA, "No ten�s trabajo al cual renunciar.");
    }else
    {
        SendClientMessage(playerid, 0xFFFFAA, "Renunciaste a tu trabajo. Ahora est�s desempleado");
        SetPVarInt(playerid, "dbTrabajoUno", 0);
    }
    return 1;
}