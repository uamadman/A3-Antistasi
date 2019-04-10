if (!isServer and hasInterface) exitWith{};
params [
    "_side",
    "_position",
    ["_angle",false],
    ["_facilityMarker",""]
];
private ["_pos","_side","_group","_staticClassName","_initialPos","_typesOfUnit"];

_vehType = switch (_side) do {
    case malos : { NATOAmmoBox };
    case muyMalos : { CSATAmmoBox };
};

_veh = (selectRandom _vehType) createVehicle _position;
if(_angle) then {_veh setDir _angle};
_nul = [_veh,_side] call A3A_fnc_fillAmmoCrate;
_veh call jn_fnc_logistics_addAction;

_veh