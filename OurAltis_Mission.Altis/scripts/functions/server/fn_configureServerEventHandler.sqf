#include "macros.hpp"
/**
 * OurAltis_Mission - fn_configureServerEventHandler
 * 
 * Author: Raven
 * 
 * Description:
 * Configures all server event handler
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// handler for providing the base list on request
[
	EVENT_BASE_LIST_REQUEST,
	{
		params [
			["_clientID", nil, [0]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		// send the base list to the respective client
		[EVENT_BASE_LIST_RECEIVED, GVAR(BaseList), _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for providing the infantry list on request
[
	EVENT_INFANTRY_LIST_REQUEST,
	{
		params [
			["_clientID", nil, [0]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		// send the base list to the respective client
		[EVENT_INFANTRY_LIST_RECEIVED, GVAR(Infantry), _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for respawn requests
[
	EVENT_REQUEST_RESPAWN,
	{
		params [
			["_clientID", nil, [0]],
			["_respawnInfo", [], [[]]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		private _allow = false;
		private _extraParams = ["!Respawn error!"];
		
		CHECK_TRUE(count _respawnInfo == 2, Invalid respawn information!, {})
		
		_respawnInfo params [
			"_base",
			"_role"
		];
		
		diag_log ("Respawn request for role: " + str _role);
		diag_log ("Internal role name: " + str ([_role] call FUNC(getInternalClassName)));
		
		private _msg = [_base, [_role] call FUNC(getInternalClassName)] call FUNC(checkRespawn);
		
		_allow = _msg isEqualTo "";
		_extraParams = [_msg];
		
		
		if(_allow) then {
			// decrease the reinforcements of that role
			[_base, _role] call FUNC(decreaseRoleReinforcements);
		};
		
		
		// send the base list to the respective client
		[EVENT_ANSWER_REQUEST_RESPAWN, [_allow, _extraParams], _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

nil;
