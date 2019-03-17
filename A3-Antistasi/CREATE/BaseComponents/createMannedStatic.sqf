if (!isServer and hasInterface) exitWith{};
params [
    "_typeOfStatic",
    ["_sideOrGroup",objNull],
    "_position",
    ["_angle",false],
    ["_facilityMarker",""]
];
private ["_pos","_side","_group","_staticClassName","_initialPos","_typesOfUnit"];

_markersOpacity = if (debug) then {1} else {0};

switch (typeName _sideOrGroup) do {
    case "SIDE" : {
        _side = _sideOrGroup;
        _group = createGroup _side;
    };
    case "GROUP" : {
        _group = _sideOrGroup;
        _side = side _group;
    };
};

switch (_side) do {
    case malos : {
        _typesOfUnit = staticCrewmalos;
        _staticClassName = switch (_typeOfStatic) do {
            case "AT" : {staticATmalos};
            case "AA" : {staticAAMalos};
            case "mortar" : {NATOMortar};
            case "raised" : {selectRandom NATORaisedStatics};
        };
    };
    case muyMalos : {
        _typesOfUnit = staticCrewMuyMalos;
        _staticClassName = switch (_typeOfStatic) do {
            case "AT" : {staticATmuyMalos};
            case "AA" : {staticAAmuyMalos};
            case "mortar" : {CSATMortar};
            case "raised" : {selectRandom CSATRaisedStatics};
        };
    };
};
if (!([_staticClassName] call A3A_fnc_vehAvailable)) exitWith {false};

//IF ELEVATED POSITION CHECK BUILDING ISN'T RUINED. WE CAN'T PLACE STATIC ON RUINED BUILDING
if ((_position select 2 > 0.5) and !(alive nearestBuilding (_x select 0))) exitWith {false};

_initialPos = if(count _facilityMarker > 0) then {getMarkerPos _facilityMarker} else {_position};

_veh = createVehicle [_staticClassName, _initialPos, [], 0, "CAN_COLLIDE"];
_veh allowDamage false;
_veh setPosATL _position;
if(_angle) then {_veh setDir _angle;};

_typeOfUnit = if (_side == malos) then {selectRandom staticCrewmalos} else {selectRandom staticCrewMuyMalos};
_unit = _group createUnit [_typeOfUnit, _initialPos, [], 0, "NONE"];
_unit allowDamage false;
[_unit,_facilityMarker] call A3A_fnc_NATOinit;
[_veh, side _unit] call A3A_fnc_AIVEHinit;
_unit moveInGunner _veh;
if(_typeOfStatic == "mortar") then {_nul = [_veh] execVM "scripts\UPSMON\MON_artillery_add.sqf";};
sleep 1;

_veh allowDamage true;
_unit allowDamage true;
[_veh, _unit, _group]