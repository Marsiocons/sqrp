#include <a_samp>
#include "../include/pickups.inc"

public OnFilterScriptInit()
{
    print("\n Pickups cargados\n");

    // ------------------------ CAMIONERO ------------------------ //

    CreatePickup(1210, 1,
	 coorPickCamioneros[0],
	 coorPickCamioneros[1],
	 coorPickCamioneros[2], -1);
    print("\n Cree un pickup \n");
    Create3DTextLabel("/Trabajo camionero", 0xFACC2E,
     coorPickCamioneros[0],
     coorPickCamioneros[1],
     55.43478 , 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Para obtener el trabajo.", 0xFACC2E,
     coorPickCamioneros[0],
     coorPickCamioneros[1],
     coorPickCamioneros[2] + 1, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ CAMIONERO V ---------------------- //

    CreatePickup(1275, 1,
	 coorPickCamionerosV[0],
	 coorPickCamionerosV[1],
	 coorPickCamionerosV[2], -1);
    print("\n Cree un pickup \n");
    Create3DTextLabel("Usá el /uniforme camionero", 0xFACC2E,
     coorPickCamionerosV[0],
     coorPickCamionerosV[1],
     55.43478, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Y obtene un extra de $$$", 0xFACC2E,
     coorPickCamionerosV[0],
     coorPickCamionerosV[1],
     coorPickCamionerosV[2] + 1, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ HOSPITAL ------------------------- //

    CreatePickup(1240, 1,
    coorPickupHospital[0],
    coorPickupHospital[1],
    coorPickupHospital[2], -1);
    Create3DTextLabel("/Donar esperma", 0xAAFFAA,
     coorPickupHospital[0],
     coorPickupHospital[1],
     57.337692, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Para obtener experiencia extra.", 0xAAFFAA,
     coorPickupHospital[0],
     coorPickupHospital[1],
     coorPickupHospital[2] + 1, 20, 0, 0);

	return 1;
}