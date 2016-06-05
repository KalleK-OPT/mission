#include "macros.hpp"
/**
 * OurAltis_Mission - fn_OurAltisInit
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes the OurAltis framework
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// only initialize on server
if(!isServer) exitWith {};

// variable init
GVAR(BaseList) = [];
GVAR(operationName) = "Operation Beispiel";


// erstellt ein Feldlager und eine Basis
[[[253, 786], west, "Conner", false], [[584, 352], independent, "Maxwell", true]] call FUNC(createBases);

/*// sch�nes Wetter mit Nebel tags�ber
[0,1,0] call FUNC(setWheather);

// Infanterie hinzuf�gen
[["Rifleman", 5, "Conner"], ["Medic", 2, "Maxwell"]] call FUNC(configureInfantery);

// F�gt einFahrzeug mit vollem Tank und voller Gesundheit hinzu
[["KlassenNameDesFahrzeugsDerMirGradNichtEinf�llt", "ID1", 1, 0, "Conner"], [...]] call FUNC(configureVehicles);*/
