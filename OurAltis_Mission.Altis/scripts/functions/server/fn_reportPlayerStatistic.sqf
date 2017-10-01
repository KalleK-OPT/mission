#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportPlayerStatistic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send player statistic to database
 * 
 * Parameter(s):
 * 0: Fired Shots <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_parameter", [], [[]]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

// report status to the DB
private _result = ["UPDATE statistik SET treibstoff = '" + str(GVAR(fuelConsumption)) + "' WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
