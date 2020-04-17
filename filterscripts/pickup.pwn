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
    Create3DTextLabel("/Trabajo camionero", 0x008080FF,
     coorPickCamioneros[0],
     coorPickCamioneros[1],
     54.434780, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Para obtener el trabajo.", 0x008080FF,
     coorPickCamioneros[0],
     coorPickCamioneros[1],
     54.284780, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ CAMIONERO V ---------------------- //

    CreatePickup(1275, 1,
	 coorPickCamionerosV[0],
	 coorPickCamionerosV[1],
	 coorPickCamionerosV[2], -1);
    print("\n Cree un pickup \n");
    Create3DTextLabel("Usá el /uniforme camionero", 0x008080FF,
     coorPickCamionerosV[0],
     coorPickCamionerosV[1],
     54.434780, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Y obtené un extra de $$$", 0x008080FF,
     coorPickCamionerosV[0],
     coorPickCamionerosV[1],
     54.284780, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ OBRERO --------------------------- //

    CreatePickup(1210, 1,
	 coorPickObrero[0],
	 coorPickObrero[1],
	 coorPickObrero[2], -1);
    print("\n Cree un pickup \n");
    Create3DTextLabel("/Trabajo obrero", 0x008080FF,
     coorPickObrero[0],
     coorPickObrero[1],
     9.103454, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Para obtener el trabajo.", 0x008080FF,
     coorPickObrero[0],
     coorPickObrero[1],
     8.953454, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ OBRERO V --------------------------- //

    CreatePickup(1275, 1,
	 coorPickObreroV[0],
	 coorPickObreroV[1],
	 coorPickObreroV[2], -1);
    print("\n Cree un pickup \n");
    Create3DTextLabel("Usá el /uniforme obrero", 0x008080FF,
     coorPickObreroV[0],
     coorPickObreroV[1],
     8.808266, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Y obtené un extra de $$$", 0x008080FF,
     coorPickObreroV[0],
     coorPickObreroV[1],
     8.658266, 20, 0, 0);
    print("\n Cree un Text Label \n");

    // ------------------------ MINERO T --------------------------- //

    Create3DTextLabel("Usá /juntar para comenzar a trabajar.", 0x00FF00FF, coorJobObreroJ[0], coorJobObreroJ[1], 6.973837, 20, 0, 0);
    Create3DTextLabel("Usá /descartar para deshacerte de los escombros.", 0x00FF00FF, coorJobObreroT[0], coorJobObreroT[1], coorJobObreroT[2], 20, 0, 0);
    // ------------------------ HOSPITAL ------------------------- //

    CreatePickup(1240, 1,
    coorPickHospital[0],
    coorPickHospital[1],
    coorPickHospital[2], -1);
    Create3DTextLabel("/Donar esperma", 0xAAFFAA,
     coorPickHospital[0],
     coorPickHospital[1],
     56.337692, 20, 0, 0);
    print("\n Cree un Text Label \n");
    Create3DTextLabel("Para obtener experiencia extra.", 0xAAFFAA,
     coorPickHospital[0],
     coorPickHospital[1],
     56.187692, 20, 0, 0);

	return 1;
}