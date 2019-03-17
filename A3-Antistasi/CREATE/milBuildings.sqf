private ["_posicion","_size","_buildings","_grupo","_lado","_building","_tipoB","_frontera","_tipoVeh",
"_veh","_vehiculos","_soldados","_pos","_ang","_marcador","_unit","_return"];
_marcador = _this select 0;
_posicion = getMarkerPos _marcador;
_size = _this select 1;
_buildings = nearestObjects [_posicion, listMilBld, _size * 1.2, true];

if (count _buildings == 0) exitWith {[grpNull,[],[]]};

_lado = _this select 2;
_frontera = _this select 3;

_vehiculos = [];
_soldados = [];

_grupo = createGroup _lado;

for "_i" from 0 to (count _buildings) - 1 do {
	if (spawner getVariable _marcador == 2) exitWith {};
	_building = _buildings select _i;
	/*
	if !(_building getVariable ["conEH",false]) then
		{
		_building setVariable ["conEH",true,true];
		_building addEventHandler ["Killed",{
			_building = _this select 0;
			destroyedBuildings pushBackUnique (getPos _building);
			publicVariable "destroyedBuildings";
			}
			];
		};*/
	_tipoB = typeOf _building;

    switch(true) do {
        case ((_tipoB == "Land_HelipadSquare_F") and (!_frontera)): {
            _tipoVeh = if (_lado == malos) then {vehNATOPatrolHeli} else {vehCSATPatrolHeli};
    		_veh = createVehicle [_tipoVeh, position _building, [],0, "CAN_COLLIDE"];
    		_veh setDir (getDir _building);
    		_vehiculos pushBack _veh;
        };
        case (_tipoB in ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F"]): {
			_mannedStatic = ['AA', _grupo,
			    [getPos _building select 0, getPos _building select 1,(_building buildingPos 8) select 2],
			    (getDir _building), _marcador] call A3A_fnc_createMannedStatic;
            _soldados pushBack (_mannedStatic select 1);
			_vehiculos pushBack (_mannedStatic select 0);

        };
        case (_tipoB in ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V3_F"]): {
            _mannedStatic = ['raised', _grupo,
			    [_building buildingPos 1, 2.5, (getDir _building) - 180] call BIS_Fnc_relPos,
			    (getDir _building) - 180, _marcador] call A3A_fnc_createMannedStatic;
            _soldados pushBack (_mannedStatic select 1);
			_vehiculos pushBack (_mannedStatic select 0);
        };
        case (_tipoB in listbld): {

            _mannedStatic = ['raised', _grupo,
			    (_building buildingPos 11),
			    false, _marcador] call A3A_fnc_createMannedStatic;
            _soldados pushBack (_mannedStatic select 1);
			_vehiculos pushBack (_mannedStatic select 0);
			sleep 0.5;

            _mannedStatic = ['raised', _grupo,
			    (_building buildingPos 13),
			    false, _marcador] call A3A_fnc_createMannedStatic;
            _soldados pushBack (_mannedStatic select 1);
			_vehiculos pushBack (_mannedStatic select 0);
        };
    };
};
[_grupo,_vehiculos,_soldados]