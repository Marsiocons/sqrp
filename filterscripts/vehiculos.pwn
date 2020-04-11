#include <a_samp>
#include "../include/vehiculos.inc"

new cantVehiculos = 0;

public OnFilterScriptInit()
{
    print("\n Vehículos cargados\n");
	return 1;
}
public OnGameModeInit()
{
    /* ---------------------------------------- CAMIONES ---------------------------------------- */

    for (new a = 0; a < 4; a++) {
    
        CreateVehicle(modeloCamion,
         coorCamion[a][0],
         coorCamion[a][1],
         coorCamion[a][2],
         coorCamion[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    /* ---------------------------------------- BICILETAS ---------------------------------------- */

    for (new a = 0; a < 4; a++) {
    
        CreateVehicle(modeloBici,
         coorBici[a][0],
         coorBici[a][1],
         coorBici[a][2],
         coorBici[a][3], color1, color2, 100);
        cantVehiculos++;
    }

    new string[32];
    format(string, sizeof(string), "Cargué %i vehículos.", cantVehiculos);
    print(string);
}
