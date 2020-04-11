#include <a_samp>
#include "../include/vehiculos.inc"

new cantVehiculos = 0;

public OnFilterScriptInit()
{
    print("\n Vehï¿½culos cargados\n");
	return 1;
}
public OnGameModeInit()
{
    /* ---------------------------------------- CAMIONES ---------------------------------------- */

    for (new a = 0; a < 4; a++)
    {
    
        CreateVehicle(modeloCamion,
         coorCamion[a][0],
         coorCamion[a][1],
         coorCamion[a][2],
         coorCamion[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    /* ---------------------------------------- BICILETAS ---------------------------------------- */

    for (new a = 0; a < 8; a++)
    {
    
        CreateVehicle(modeloBici,
         coorBici[a][0],
         coorBici[a][1],
         coorBici[a][2],
         coorBici[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    /* -------------------------------------- AMBULANCIA ---------------------------------------- */  

    for (new a = 0; a < 4; a++)
    {
    
        CreateVehicle(modeloAmbulancia,
         coorAmbulancia[a][0],
         coorAmbulancia[a][1],
         coorAmbulancia[a][2],
         coorAmbulancia[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }

    /* -------------------------------------- POLICIA ------------------------------------------- */  

    for (new a = 0; a < 2; a++)
    {
        CreateVehicle(modeloPoliciaUno,
        coorPoliciaUno[a][0],
        coorPoliciaUno[a][1],
        coorPoliciaUno[a][2],
        coorPoliciaUno[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }
    for (new a = 0; a < 2; a++)
    {
        CreateVehicle(modeloPoliciaDos,
        coorPoliciaDos[a][0],
        coorPoliciaDos[a][1],
        coorPoliciaDos[a][2],
        coorPoliciaDos[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }
    for (new a = 0; a < 2; a++)
    {
        CreateVehicle(modeloPoliciaTres,
        coorPoliciaTres[a][0],
        coorPoliciaTres[a][1],
        coorPoliciaTres[a][2],
        coorPoliciaTres[a][3], color1, color2, 100, 1);
        cantVehiculos++;
    }

    /* ------------------------------------------------------------------------------------------ */  

    new string[32];
    format(string, sizeof(string), "Cargué %i vehículos.", cantVehiculos);
    print(string);
}
