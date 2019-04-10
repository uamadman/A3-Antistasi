params ["_tipo"];
private ["_cant"];
if (_tipo == "") exitWith {false};

if (_tipo in ([vehCSATPatrolHeli,vehNATOPatrolHeli,vehCSATRBoat,vehNATORBoat] + vehCSATTrucks + vehNATOTrucks)) exitWith {true};
_cant = timer getVariable _tipo;
if (isNil "_cant") exitWith {true};
if (_cant <= 1) exitWith {false};
if ({typeOf _x == _tipo} count vehicles >= (floor _cant)) exitWith {false};
true