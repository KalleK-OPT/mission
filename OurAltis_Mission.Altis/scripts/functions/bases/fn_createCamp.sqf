#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createCamp
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a camp at the given position and adds it to the given side
 * 
 * Parameter(s):
 * 0: Position <Position3D, Position2D>
 * 1: BaseSide <Side>
 * 2: ID <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params[
		["_position", nil, [[]], [2, 3]],
		["_side", nil, [sideUnknown]],
		["_id", nil, [""]]
	];

CHECK_TRUE(_success, Invalid parameters!, {})

nil;
