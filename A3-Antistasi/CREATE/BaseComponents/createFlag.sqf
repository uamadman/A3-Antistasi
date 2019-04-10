if (!isServer and hasInterface) exitWith{};
params ["_side","_position",["_angle",false],["_addAction",true]];
private ["_typeOfFlag"];

_typeOfFlag = switch(_side) do {
    case malos: {NATOFlag};
    case muyMalos: {CSATFlag};
    case buenos: {FIAFlag};
};
_flag = createVehicle [_typeOfFlag, _position, [],0, "CAN_COLLIDE"];
_flag allowDamage false;
_flag setPosATL _position;
if(_angle) then {_flag setDir _angle;};
if(_addAction) then {[_flag,"take"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_flag];};
sleep 1;
_flag