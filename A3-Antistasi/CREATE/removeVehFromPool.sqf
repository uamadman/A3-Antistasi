params["_veh"];
private ["_vehType"];

_vehType = typeOf _veh;

if !(_vehType in vehUnlimited) then {
	_cant = timer getVariable _vehType;
	if !(isNil _cant) then {
		if !(_cant isEqualType 0) then {_cant = 1};
		timer setVariable [_vehType,_cant -1,true];
	} else {
		if !(_vehType in vehUnlimited) then {
			timer setVariable [_vehType,0,true];
		};
	};
};