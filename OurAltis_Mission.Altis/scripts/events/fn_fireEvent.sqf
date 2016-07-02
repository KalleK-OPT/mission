#include "macros.hpp"
/**
 * OurAltis_Mission - fn_fireEvent
 * 
 * Author: Raven
 * 
 * Description:
 * Fires an event of the given type
 * 
 * Parameter(s):
 * 0: The event type <String>
 * 1: Parameter to hand over to the running script. 
 *    The first element must be the ID of the client calling this function <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_type", nil, [""]],
	["_eventParameter", [], [[]]]
];

CHECK_FALSE(isNil "_type", Invalid eventType!, {})

DEBUG_EXEC(private _msg = ("OurAltis " + QVERSION + " [Event]: fired - " + str _type + " " + SCRIPT_REFERENCE); 
diag_log _msg; hint _msg;)

private _hasMatched = false;

{
	if((_x select 0) isEqualTo _type) then {
		// execute all listeners
		{
			_eventParameter call (_x select 0);
			
			nil;
		} count (_x select 1);
		
		_hasMatched = true;
	};
	// exit loop because there won't come any more matches
	if(_hasMatched) exitWith {};
} count GVAR(EventHandler);

nil;
