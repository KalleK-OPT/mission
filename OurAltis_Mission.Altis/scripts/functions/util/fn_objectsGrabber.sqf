/*
	File: objectGrabber.sqf
	Author: Joris-Jan van 't Land modified by PhilipJFry

	Description:
	Converts a set of placed objects to an object array for the objects mapper function.
	The array is stored in the clipboard.

	Parameter(s):
	_this select 0: list of objects (Array)
	_this select 1: name of object which will be the entry point of the object mapper to calculate all koordinates (String)
	
	Returns:
	[classname, relative positiom, direction, variable name, init value, enable simulation, is simple object] (Array)
*/

params [
	["_objects", [], [[]]],
	["_refObj", "", [""]]
];

private ["_br", "_tab", "_outputText", "_refPos"];

_br = toString [13, 10];
_tab = toString [9];

_outputText = "/*" + _br + _tab + "Grab data:" + _br;
_outputText = _outputText + _tab + "Mission: " + (if (missionName == "") then {"Unnamed"} else {missionName}) + _br;
_outputText = _outputText + _tab + "World: " + worldName + _br;
_outputText = _outputText + "*/" + _br + _br;
_outputText = _outputText + "[" + _br;

_refPos = {
	private _name = (_x get3DENAttribute "name") select 0;
	if (_name isEqualTo _refObj) exitWith {_x get3DENAttribute "position"};
} count _objects;

{
	private ["_type", "_objPos", "_dX", "_dY", "_z", "_azimuth", "_varName", "_init", "_simulation", "_outputArray"];	

	_type = typeOf _x;
	_objPos = _x get3DENAttribute "position";
	_dX = ((_objPos select 0) select 0) - ((_refPos select 0) select 0);
	_dY = ((_objPos select 0) select 1) - ((_refPos select 0) select 1);
	_z = if (abs ((_objPos select 0) select 2) < 0.01) then {0} else {(_objPos select 0) select 2};
	_azimuth = if (((_x get3DENAttribute "rotation") select 0) select 2 < 0.01) then {0} else {((_x get3DENAttribute "rotation") select 0) select 2};
	_varName = if (((_x get3DENAttribute "name") select 0) isEqualTo _refObj) then {""} else {(_x get3DENAttribute "name") select 0};
	_init = (_x get3DENAttribute "init") select 0;
	_simulation = (_x get3DENAttribute "enableSimulation") select 0;
	_isSimpleObject = (_x get3DENAttribute "objectIsSimple") select 0;
	
	_outputArray = [_type, [_dX, _dY, _z], _azimuth, _varName, _init, _simulation, _isSimpleObject];
	_outputText = _outputText + _tab + (str _outputArray);
	_outputText = if (_forEachIndex < ((count _objects) - 1)) then {_outputText + ", " + _br} else {_outputText + _br};

	debugLog (format ["Log: objectGrabber: %1", _outputArray]);
} forEach _objects;

_outputText = _outputText + "]";
copyToClipboard _outputText;
