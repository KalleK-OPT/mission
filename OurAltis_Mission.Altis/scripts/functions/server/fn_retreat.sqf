#include "macros.hpp"
/**
 * OurAltis_Mission - fn_retreat
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * End mission if someone decide to retreat 
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 1: Client ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_side", sideUnknown, [west]],
	["_clientID", -1, [0]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

if (PGVAR(retreat)) exitWith {NOTIFICATION_LOG(Retreat in Progress!)};

PGVAR(retreat) = true;
publicVariable QPGVAR(retreat);

[_side] remoteExecCall [QFUNC(deleteRadioMsg), -2];

private _winnerSide = if (_side isEqualTo west) then {east} else {west};

[
	{
		diag_log "Ending mission because of reatreat";
		(_this select 0) call FUNC(endMission);
	},
	[_winnerSide],
	30
] call CBA_fnc_waitAndExecute;

nil
