#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createAddAction
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds an action to something
 * 
 * Parameter(s):
 * 0: Object <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_object", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (!alive _object || isNull _object) exitWith {NOTIFICATION_LOG(Object is not there!)};

if (_object isKindOf "Man") then {
	GVAR(spyAddAction) = _object addAction [localize "OurA_str_Action", {_this call FUNC(askSpy)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3"];
};

if (_object isKindOf "Car") then {
	private _actionID = _object addAction [localize "OurA_str_buildCamp", {_this call FUNC(checkFOBPosition)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3 && (vehicle _this) isEqualTo _this"];
	_object setVariable [QGVAR(FOBAddAtion), _actionID];
};

nil
