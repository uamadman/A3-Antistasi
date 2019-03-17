if (!isServer and hasInterface) exitWith{};
params [
    "_mainMarker",
    ["_soldiers",[]],
    ["_vehicles",[]],
    ["_markers",[]]
];
private ["_group","_groups","_mainMarkerSize"];
_groups = [];
{
    if (alive _x) then {
        _group = group _x;
        if(!(_group in _groups)) then {
            _groups pushBack (group _x);
        };
    };
} forEach _soldiers;

waitUntil {sleep 1; (spawner getVariable _mainMarker == 2)};

{
    if (alive _x) then {
	    deleteVehicle _x
    };
} forEach _soldiers;
{deleteGroup _x} forEach _groups;
{deleteMarker _x} forEach _markers;
_mainMarkerSize = [_mainMarker] call A3A_fnc_sizeMarker;
{
    if (!(_x in staticsToSave)) then {
	    if ((!([distanciaSPWN-_mainMarkerSize,1,_x,buenos] call A3A_fnc_distanceUnits))) then {deleteVehicle _x}
	};
} forEach _vehicles;