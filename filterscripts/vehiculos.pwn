#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include "../include/vehiculos.inc"


new IDVeh[MAX_VEHICLES];
new cantVehiculos = 0;

public OnFilterScriptInit()
{
    print("\n Vehículos cargados\n");
	return 1;
}
public OnGameModeInit()
{
    /* -------------------------------------- CONCESIONARIO ------------------------------------- */  

    IDVeh[cantVehiculos+1] = AddStaticVehicleEx(modeloWalton, coorWalton[0], coorWalton[1], coorWalton[2], coorWalton[3], color1, color2, -1);
    cantVehiculos++;
    IDVeh[cantVehiculos+1] = AddStaticVehicleEx(modeloGlendale, coorGlendale[0], coorGlendale[1], coorGlendale[2], coorGlendale[3], color1, color2, -1);
    cantVehiculos++;
    IDVeh[cantVehiculos+1] = AddStaticVehicleEx(modeloSadler, coorSadler[0], coorSadler[1], coorSadler[2], coorSadler[3], color1, color2, -1);
    cantVehiculos++;
    IDVeh[cantVehiculos+1] = AddStaticVehicleEx(modeloFaggio, coorFaggio[0], coorFaggio[1], coorFaggio[2], coorFaggio[3], color1, color2, 1);
    cantVehiculos++;
    /* ---------------------------------------- CAMIONES ---------------------------------------- */
    for (new a = 0; a < 4; a++)
    {
    
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloCamion,
         coorCamion[a][0],
         coorCamion[a][1],
         coorCamion[a][2],
         coorCamion[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    /* ---------------------------------------- BICILETAS ---------------------------------------- */

    for (new a = 0; a < 8; a++)
    {
    
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloBici,
         coorBici[a][0],
         coorBici[a][1],
         coorBici[a][2],
         coorBici[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    /* -------------------------------------- AMBULANCIA ---------------------------------------- */  

    for (new a = 0; a < 4; a++)
    {
    
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloAmbulancia,
         coorAmbulancia[a][0],
         coorAmbulancia[a][1],
         coorAmbulancia[a][2],
         coorAmbulancia[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }

    /* -------------------------------------- POLICIA ------------------------------------------- */  

    for (new a = 0; a < 2; a++)
    {
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloPoliciaUno,
        coorPoliciaUno[a][0],
        coorPoliciaUno[a][1],
        coorPoliciaUno[a][2],
        coorPoliciaUno[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }
    for (new a = 0; a < 2; a++)
    {
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloPoliciaDos,
        coorPoliciaDos[a][0],
        coorPoliciaDos[a][1],
        coorPoliciaDos[a][2],
        coorPoliciaDos[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }
    for (new a = 0; a < 2; a++)
    {
        IDVeh[cantVehiculos+1] = CreateVehicle(modeloPoliciaTres,
        coorPoliciaTres[a][0],
        coorPoliciaTres[a][1],
        coorPoliciaTres[a][2],
        coorPoliciaTres[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }
    

    /* ------------------------------------------------------------------------------------------ */ 
    
    for(new i = 0; i <= cantVehiculos; i++)
    {
        SetVehicleParamsEx(IDVeh[i], 0, 0, 0, 0, 0, 0, 0);
    }

    new string[32];
    format(string, sizeof(string), "Cargué %i vehículos.", cantVehiculos);
    print(string);
}
