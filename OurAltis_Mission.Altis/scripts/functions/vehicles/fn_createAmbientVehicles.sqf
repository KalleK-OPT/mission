#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createAmbientVehicles
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates the vehicles at economy buildings
 * 
 * Parameter(s):
 * 0: Helipads <Array> - format [Objects <Object>]
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_vehPosObj", [], [[]]]
]; 

CHECK_TRUE(_success, Invalid parameters!)

diag_log _vehPosObj;

{
	private _vehGroup = toLower(_x getVariable [VEHICLE_TYPE, ""]);
	_vehGroup = if ((_vehGroup find "military") > -1) then {toLower(_vehGroup + "_" + str GVAR(defenderSide))};
	diag_log _vehGroup;
	
	private _vehArray = switch (_vehGroup) do {
		case "civil_pkw": {VEHICLE_CIVIL_PKW};
		case "civil_lkw": {VEHICLE_CIVIL_LKW};
		case "military_lkw_west": {VEHICLE_MILITARY_LKW_WEST};
		case "military_lkw_east": {VEHICLE_MILITARY_LKW_EAST};
		case "military_tank_west": {VEHICLE_MILITARY_TANK_WEST};
		case "military_tank_east": {VEHICLE_MILITARY_TANK_EAST};
		case "military_heli_west": {VEHICLE_MILITARY_HELI_WEST};
		case "military_heli_east": {VEHICLE_MILITARY_HELI_EAST};
		default {[]};
	};
	
	diag_log _vehArray;
	
	if ((count _vehArray) isEqualTo 0) exitWith {NOTIFICATION_LOG(No vehicle type defined!)};
	
	private _obj = createVehicle [selectRandom _vehArray, _x, [], 0, "CAN_COLLIDE"];
	_obj setDir (getDir _x);
	_obj lock (if ((_vehGroup find "military") > -1) then {3} else {0});
	
	nil
} count _vehPosObj;

nil
