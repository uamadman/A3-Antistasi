params ["_veh"];

sleep 5;

if (isNull _veh) exitWith {};

if (!alive _veh) then {
	_veh hideObjectGlobal true;
	deleteVehicle _veh;
};
