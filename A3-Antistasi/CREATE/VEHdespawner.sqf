params ["_veh"];
_inside = _veh getVariable "inDespawner";
if (!isNil "_inside") exitWith {};

_veh setVariable ["inDespawner",true,true];


while {alive _veh} do {
	if ((!([distanciaSPWN,1,_veh,buenos] call A3A_fnc_distanceUnits)) and
	    (!([distanciaSPWN,1,_veh,muyMalos] call A3A_fnc_distanceUnits)) and
	    (!([distanciaSPWN,1,_veh,malos] call A3A_fnc_distanceUnits)) and
	    (!(_veh in staticsToSave)) and
	    (_veh distance getMarkerPos respawnBuenos > 100)) then {
		if (_veh in reportedVehs) then {
		    reportedVehs = reportedVehs - [_veh]; publicVariable "reportedVehs"
		};
		deleteVehicle _veh;
	};
	sleep 60;
};