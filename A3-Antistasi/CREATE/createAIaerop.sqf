if (!isServer and hasInterface) exitWith{};

private ["_pos","_marcador","_vehiculos","_grupos","_soldados","_posicion","_busy","_buildings","_pos1","_pos2",
"_grupo","_cuenta","_tipoVeh","_veh","_unit","_arrayVehAAF","_nVeh","_frontera","_size","_ang","_mrk","_tipogrupo",
"_flag","_perro","_tipoUnit","_garrison","_lado","_cfg","_max","_vehicle","_vehCrew","_grupoVeh","_roads","_dist",
"_road","_roadscon","_roadcon","_dirveh","_bunker","_tipoGrupo","_posiciones","_posMG","_posMort","_posTank",
"_sentryGroup","_dog","_typeSentryGroup","_tankType","_markers","_markersOpacity","_typesOfVeh"];

_markersOpacity = if (debug) then {1} else {0};

_marcador = _this select 0;

_vehiculos = [];
_grupos = [];
_soldados = [];
_markers = [];

_posicion = getMarkerPos (_marcador);
_pos = [];

_size = [_marcador] call A3A_fnc_sizeMarker;
//_garrison = garrison getVariable _marcador;

_frontera = [_marcador] call A3A_fnc_isFrontline;
_busy = if (dateToNumber date > server getVariable _marcador) then {false} else {true};
_nVeh = round (_size/60);

_lado = lados getVariable [_marcador,sideUnknown];

_posiciones = carreteras getVariable [_marcador,[]];
_posMG = _posiciones select {(_x select 2) == "MG"};
_posMort = _posiciones select {(_x select 2) == "Mort"};
_posTank = _posiciones select {(_x select 2) == "Tank"};
_posAA = _posiciones select {(_x select 2) == "AA"};
_posAT = _posiciones select {(_x select 2) == "AT"};

if (spawner getVariable _marcador != 2) then {
	//_max = if (_lado == malos) then {1} else {2}; WHY???????????
	_max = 2;
	for "_i" from 1 to _max do {
	    _typesOfVeh = if (_lado == malos) then {vehNATOAA} else {vehCSATAA};
	    _typesOfVeh = _typesOfVeh select {[_x] call A3A_fnc_vehAvailable};
		if (count _typesOfVeh > 0) then {
            _pos = [_posicion, 50, _size, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
			_vehicle = [_pos, random 360, selectRandom _typesOfVeh, _lado, _marcador] call A3A_fnc_spawnVehicle;
			_soldados = _soldados + (_vehicle select 1);
			_grupos pushBack (_vehicle select 2);
			_vehiculos pushBack (_vehicle select 0);
			sleep 1;
		};
	};

	//ADD AT BUNKER ON ROAD NEARBY
	if (_frontera) then {
    	_roads = _posicion nearRoads _size;
    	if (count _roads != 0) then {

    		_dist = 0;
    		_road = objNull;
    		{if ((position _x) distance _posicion > _dist) then {_road = _x;_dist = position _x distance _posicion}} forEach _roads;
    		_roadscon = roadsConnectedto _road;
    		_roadcon = objNull;
    		{if ((position _x) distance _posicion > _dist) then {_roadcon = _x}} forEach _roadscon;
    		_dirveh = [_roadcon, _road] call BIS_fnc_DirTo;
    		_pos = [getPos _road, 7, _dirveh + 270] call BIS_Fnc_relPos;
    		_bunker = "Land_BagBunker_01_small_green_F" createVehicle _pos;
    		_vehiculos pushBack _bunker;
    		_bunker setDir _dirveh;

    		_mannedStatic = ['AT', _lado, getPosATL _bunker, _dirVeh + 180, _marcador] call A3A_fnc_createMannedStatic;

            _vehiculos pushBack (_mannedStatic select 0);
    		_soldados pushBack (_mannedStatic select 1);
    		_grupos pushBack (_mannedStatic select 2);
    	};
    };
};



_mrk = [
    [format ["%1patrolarea", random 100]],
    _posicion,
    [(distanciaSPWN/2),(distanciaSPWN/2)],
    "ColorRed",
    "hd_warning",
    "DiagGrid",
    "RECTANGLE",
    _markersOpacity,
    "",
    markerDir _marcador,
    false
] call BIS_fnc_markerCreate;
_markers pushBack _mrk;

_garrison = garrison getVariable [_marcador,[]];
_garrison = _garrison call A3A_fnc_garrisonReorg;
_tam = count _garrison;
private _patrol = true;
if (_tam < ([_marcador] call A3A_fnc_garrisonSize)) then {
	_patrol = false;
} else {
	if ({if ((getMarkerPos _x inArea _mrk) and (lados getVariable [_x,sideUnknown] != _lado)) exitWIth {1}} count marcadores > 0) then {_patrol = false};
};

if (_patrol) then {
	_cuenta = 0;
	while {(spawner getVariable _marcador != 2) and (_cuenta < 4)} do {
		_arrayGrupos = if (_lado == malos) then {gruposNATOsmall} else {gruposCSATsmall};
		if ([_marcador,false] call A3A_fnc_fogCheck < 0.3) then {_arrayGrupos = _arrayGrupos - sniperGroups};
		_tipoGrupo = selectRandom _arrayGrupos;
		_grupo = [_posicion,_lado, _tipoGrupo,false,true] call A3A_fnc_spawnGroup;
		if !(isNull _grupo) then {
			sleep 1;
			if ((random 10 < 2.5) and (not(_tipogrupo in sniperGroups))) then
				{
				_perro = _grupo createUnit ["Fin_random_F",_posicion,[],0,"FORM"];
				[_perro] spawn A3A_fnc_guardDog;
				sleep 1;
				};
			_nul = [leader _grupo, _mrk, "SAFE","SPAWNED", "RANDOM", "NOVEH2"] execVM "scripts\UPSMON.sqf";
			_grupos pushBack _grupo;
			{[_x,_marcador] call A3A_fnc_NATOinit; _soldados pushBack _x} forEach units _grupo;
		};
		_cuenta = _cuenta +1;
	};
};
_cuenta = 0;

_grupo = createGroup _lado;
_grupos pushBack _grupo;
if (spawner getVariable _marcador != 2) then {
    {
        _mannedStatic = ['mortar', _grupo, _x select 0, _x select 1, _marcador] call A3A_fnc_createMannedStatic;
        _vehiculos pushBack (_mannedStatic select 0);
    	_soldados pushBack (_mannedStatic select 1);
	} forEach _posMort;

    {
	    _mannedStatic = ['raised', _grupo, _x select 0, _x select 1, _marcador] call A3A_fnc_createMannedStatic;
        if(_mannedStatic) then {
    	    _vehiculos pushBack (_mannedStatic select 0);
            _soldados pushBack (_mannedStatic select 1);
        };
    } forEach _posMG;

    {
        _mannedStatic = ['AA', _grupo, _x select 0, _x select 1, _marcador] call A3A_fnc_createMannedStatic;
    	if(_mannedStatic) then {
    	    _vehiculos pushBack (_mannedStatic select 0);
            _soldados pushBack (_mannedStatic select 1);
        };
    } forEach _posAA;

    {
    	_mannedStatic = ['AT', _grupo, _x select 0, _x select 1, _marcador] call A3A_fnc_createMannedStatic;
        if(_mannedStatic) then {
    	    _vehiculos pushBack (_mannedStatic select 0);
            _soldados pushBack (_mannedStatic select 1);
        };
    } forEach _posAT;
};



_ret = [_marcador,_size,_lado,_frontera] call A3A_fnc_milBuildings;
_grupos pushBack (_ret select 0);
_vehiculos append (_ret select 1);
_soldados append (_ret select 2);


//Place Aircraft
if (!_busy) then {
	_buildings = nearestObjects [_posicion, ["Land_LandMark_F","Land_runway_edgelight"], _size / 2];
	if (count _buildings > 1) then {
		_pos1 = getPos (_buildings select 0);
		_pos2 = getPos (_buildings select 1);
		_ang = [_pos1, _pos2] call BIS_fnc_DirTo;

		_pos = [_pos1, 5,_ang] call BIS_fnc_relPos;
		_grupo = createGroup _lado;
		_grupos pushBack _grupo;
		_cuenta = 0;
		while {(spawner getVariable _marcador != 2) and (_cuenta < 5)} do {
			_tipoVeh = if (_lado == malos) then {
			    selectRandom (vehNATOAir select {[_x] call A3A_fnc_vehAvailable})
			} else {
			    selectRandom (vehCSATAir select {[_x] call A3A_fnc_vehAvailable})
			};
			_veh = createVehicle [_tipoveh, _pos, [],3, "NONE"];
			_veh setDir (_ang + 90);
			sleep 1;
			_vehiculos pushBack _veh;
			_nul = [_veh, _lado] call A3A_fnc_AIVEHinit;
			_pos = [_pos, 50,_ang] call BIS_fnc_relPos;
			/*
			_tipoUnit = if (_lado==malos) then {selectRandom NATOpilot} else {selectRandom CSATpilot};
			_unit = _grupo createUnit [_tipoUnit, _posicion, [], 0, "NONE"];
			[_unit,_marcador] call A3A_fnc_NATOinit;
			_soldados pushBack _unit;
			*/
			_cuenta = _cuenta + 1;
		};
		_nul = [leader _grupo, _marcador, "SAFE","SPAWNED","NOFOLLOW","NOVEH"] execVM "scripts\UPSMON.sqf";
	};
};

_flag = [_lado,_posicion] call A3A_fnc_createFlag;
_vehiculos pushBack _flag;

_crate = [_lado,_posicion, false] call A3A_fnc_munitionsHolder;
_vehiculos pushBack _crate;

if (!_busy) then {
	{
	_arrayVehAAF = if (_lado == malos) then {vehNATOAttack} else {vehCSATAttack};
	_arrayVehAAF = _arrayVehAAF select {[_x] call A3A_fnc_vehAvailable};
	if ((spawner getVariable _marcador != 2) and (count _arrayVehAAF > 0)) then
		{
		_tankType = selectRandom _arrayVehAAF;
		_veh = createVehicle [_tankType, (_x select 0), [], 0, "NONE"];
		_veh setDir (_x select 1);
		_vehiculos pushBack _veh;
		_nul = [_veh, _lado] call A3A_fnc_AIVEHinit;
		_nVeh = _nVeh -1;

		_tankRepairEquipments = [
		    "Land_RepairDepot_01_tan_F",
		    "Land_TankRoadWheels_01_single_F",
		    "Land_TankSprocketWheels_01_single_F",
		    "Land_TankTracks_01_short_F",
		    "Land_TankTracks_01_long_F",
		    "Land_TankEngine_01_F",
		    "Land_TankEngine_01_used_F",
		    "Land_TorqueWrench_01_F",
		    "Land_BoreSighter_01_F",
		    "Land_RefuelingHose_01_F"
		];
		_tankRepairEquipment = selectRandom _tankRepairEquipments;
		_pos = [_x select 0, sizeOf _tankType, 30, sizeOf _tankRepairEquipment, 0, 0.2, 0] call BIS_Fnc_findSafePos;
		_tankRepairEquipment = _tankRepairEquipment createVehicle _pos;
       	_vehiculos pushBack _tankRepairEquipment;

    //Add sentries to vehicles.
		_typeSentryGroup = if (_lado == malos) then {gruposNATOSentry} else {gruposCSATSentry};
        _sentryGroup = [_x select 0, _lado, _typeSentryGroup] call A3A_fnc_spawnGroup;
        _grupos pushback _sentryGroup;
        sleep 1;
        dog = _sentryGroup createUnit ["Fin_random_F",_x select 0,[],0,"FORM"];
        [dog] spawn A3A_fnc_guardDog;

        _tankPositionMrk = [
            [format ["%1AirportTankPatrolArea", random 100]],
            _x select 0,
            [25,25],
            "ColorRed",
            "hd_warning",
            "DiagGrid",
            "RECTANGLE",
            _markersOpacity,
            "",
            0,
            false
        ] call BIS_fnc_markerCreate;
        _markers pushback _tankPositionMrk;
        _nul = [leader _sentryGroup, _tankPositionMrk, "SAFE","SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";
        {[_x,""] call A3A_fnc_NATOinit} forEach units _sentryGroup;

		sleep 1;
		};
	} forEach _posTank;
};

_arrayVehAAF = if (_lado == malos) then {vehNATONormal} else {vehCSATNormal};
_cuenta = 0;
while {(spawner getVariable _marcador != 2) and (_cuenta < _nVeh)} do {
	_tipoVeh = selectRandom _arrayVehAAF;
	_pos = [_posicion, 10, _size/2, 10, 0, 0.3, 0] call BIS_Fnc_findSafePos;
	_veh = createVehicle [_tipoVeh, _pos, [], 0, "NONE"];
	_veh setDir random 360;
	_vehiculos pushBack _veh;
	_nul = [_veh, _lado] call A3A_fnc_AIVEHinit;
	sleep 1;
	_cuenta = _cuenta + 1;
};

_array = [];
_subArray = [];
_cuenta = 0;
_tam = _tam -1;
while {_cuenta <= _tam} do {
	_array pushBack (_garrison select [_cuenta,7]);
	_cuenta = _cuenta + 8;
};
for "_i" from 0 to (count _array - 1) do {
	_grupo = if (_i == 0) then {[_posicion,_lado, (_array select _i),true,false] call A3A_fnc_spawnGroup} else {[_posicion,_lado, (_array select _i),false,true] call A3A_fnc_spawnGroup};
	_grupos pushBack _grupo;
	{[_x,_marcador] call A3A_fnc_NATOinit; _soldados pushBack _x} forEach units _grupo;
	if (_i == 0) then {
	    _nul = [leader _grupo, _marcador, "SAFE", "RANDOMUP","SPAWNED", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf"
	} else {
	    _nul = [leader _grupo, _marcador, "SAFE", "SPAWNED", "RANDOM", "NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf"
	};
};

[_marcador, _soldados, _vehiculos, _markers] call A3A_fnc_deleteBase;