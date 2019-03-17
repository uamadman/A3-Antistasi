fn_nameSpaceName = {
    if (worldName == "Tanoa") then {
		    _nameSpaceName = "WotP";
	} else {
		if (side group petros == independent) then {
		    _nameSpaceName = "Antistasi" + worldName;
		} else {
		    _nameSpaceName = "AntistasiB" + worldName;
		};
	};
    _nameSpaceName;
};

fn_SaveStat = {
	params ["_varName","_varValue","_nameSpaceName"];
	_nameSpaceName = "";
	if (!isNil "_varValue") then {
		_nameSpaceName = [] call fn_nameSpaceName;
		profileNameSpace setVariable [_varName + serverID + _nameSpaceName,_varValue];
		if (isDedicated) then {saveProfileNamespace};
	};
};

fn_LoadStat = {
	params ["_varName"];
	private ["_varvalue","_nameSpaceName"];
	_nameSpaceName = [] call fn_nameSpaceName;
	_varValue = profileNameSpace getVariable (_varName + serverID + _nameSpaceName);
	if(isNil "_varValue") exitWith {
	    diag_log format ["Antistasi: Error en Persistent Load. La variable %1 no existe",_varname]
	};
	[_varName,_varValue] call fn_SetStat;
};

//===========================================================================
//ADD VARIABLES TO THIS ARRAY THAT NEED SPECIAL SCRIPTING TO LOAD
/*specialVarLoads =
[
	"weaponsPlayer",
	"magazinesPlayer",
	"backpackPlayer",
	"mrkNATO",
	"mrkSDK",
	"prestigeNATO","prestigeCSAT", "hr","planesAAFcurrent","helisAAFcurrent","APCAAFcurrent","tanksAAFcurrent","armas","items","mochis","municion","fecha", "WitemsPlayer","prestigeOPFOR","prestigeBLUFOR","resourcesAAF","resourcesFIA","skillFIA"];
*/
specialVarLoads =
["puestosFIA","minas","estaticas","cuentaCA","antenas","mrkNATO","mrkSDK","prestigeNATO","prestigeCSAT","posHQ", "hr","armas","items","mochis","municion","fecha", "prestigeOPFOR","prestigeBLUFOR","resourcesFIA","skillFIA","distanciaSPWN","civPerc","maxUnits","destroyedCities","garrison","tasks","scorePlayer","rankPlayer","smallCAmrk","dinero","miembros","vehInGarage","destroyedBuildings","personalGarage","idlebases","idleassets","chopForest","weather","killZones","jna_dataList","controlesSDK","loadoutPlayer","mrkCSAT","nextTick","bombRuns","dificultad","gameMode","mapMarkersPlayer"];
//THIS FUNCTIONS HANDLES HOW STATS ARE LOADED
fn_SetStat = {

    params ["_varName","_varValue"];
	if(isNil '_varValue') exitWith {};
	if(_varName in specialVarLoads) then
	{
		if(_varName == 'cuentaCA') then {cuentaCA = _varValue; publicVariable "cuentaCA"};
		if(_varName == 'dificultad') then
			{
			if !(isMultiplayer) then
				{
				skillMult = _varValue;
				if (skillMult == 0.5) then {minWeaps = 15};
				if (skillMult == 2) then {minWeaps = 40};
				};
			};
		if(_varName == 'gameMode') then
			{
			if !(isMultiplayer) then
				{
				gameMode = _varValue;
				if (gameMode != 1) then
					{
					malos setFriend [muyMalos,1];
				    muyMalos setFriend [malos,1];
				    if (gameMode == 3) then {"CSAT_carrier" setMarkerAlpha 0};
				    if (gameMode == 4) then {"NATO_carrier" setMarkerAlpha 0};
					};
				};
			};
		if(_varName == 'bombRuns') then {bombRuns = _varValue; publicVariable "bombRuns"};
		if(_varName == 'nextTick') then {nextTick = time + _varValue};
		if(_varName == 'miembros') then {miembros = +_varValue; publicVariable "miembros"};
		if(_varName == 'smallCAmrk') then {smallCAmrk = +_varValue};
		if(_varName == 'mrkNATO') then {{lados setVariable [_x,malos,true]} forEach _varValue;};
		if(_varName == 'mrkCSAT') then {{lados setVariable [_x,muyMalos,true]} forEach _varValue;};
		if(_varName == 'mrkSDK') then {{lados setVariable [_x,buenos,true]} forEach _varValue;};
		if(_varName == 'controlesSDK') then
			{
			{
			lados setVariable [_x,buenos,true]
			} forEach _varValue;
			};
		if(_varName == 'chopForest') then {chopForest = _varValue; publicVariable "chopForest"};
		if(_varName == 'dinero') then {player setVariable ["dinero",_varValue,true];};
		if(_varName == 'loadoutPlayer') then
			{
			_pepe = + _varValue;
			if (isMultiplayer) then
				{
				removeAllItemsWithMagazines player;
				{player removeWeaponGlobal _x} forEach weapons player;
				removeBackpackGlobal player;
				removeVest player;
				if ((not("ItemGPS" in unlockedItems)) and ("ItemGPS" in (assignedItems player))) then {player unlinkItem "ItemGPS"};
				if ((!hayTFAR) and (!hayACRE) and ("ItemRadio" in (assignedItems player)) and (not("ItemRadio" in unlockedItems))) then {player unlinkItem "ItemRadio"};
				["loadoutPlayer", getUnitLoadout player] call fn_SaveStat;
				};
			player setUnitLoadout _pepe;
			};
		if(_varName == 'mapMarkersPlayer') then {
            {
                _markerName = _x select 0;
                _markerType = _x select 2;
                _markerColour = _x select 3;
                _markerSize = _x select 4;
                _markerText = _x select 5;
                _markerShape = _x select 6;
                _markerDir = _x select 7;
                _markerBrush = _x select 8;
                _markerAlpha = _x select 9;
                _marker = createMarker [_markerName,_x select 1];
                _markerName setMarkerType _markerType;
                _markerName setMarkerColor _markerColour;
                _markerName setMarkerSize _markerSize;
                _markerName setMarkerText _markerText;
                _markerName setMarkerShape _markerShape;
                _markerName setMarkerDir _markerDir;
                _markerName setMarkerBrush _markerBrush;
                _markerName setMarkerAlpha _markerAlpha;
            } forEach _varValue;
		};
		if(_varName == 'scorePlayer') then {player setVariable ["score",_varValue,true];};
		if(_varName == 'rankPlayer') then {player setRank _varValue; player setVariable ["rango",_varValue,true]};
		if(_varName == 'personalGarage') then {personalGarage = +_varValue};
		if(_varName == 'jna_dataList') then {jna_dataList = +_varValue};
		if(_varName == 'prestigeNATO') then {prestigeNATO = _varValue; publicVariable "prestigeNATO"};
		if(_varName == 'prestigeCSAT') then {prestigeCSAT = _varValue; publicVariable "prestigeCSAT"};
		if(_varName == 'hr') then {server setVariable ["HR",_varValue,true]};
		if(_varName == 'fecha') then {setDate _varValue};
		if(_varName == 'weather') then
			{
			0 setFog (_varValue select 0);
			0 setRain (_varValue select 1);
			forceWeatherChange
			};
		if(_varName == 'resourcesFIA') then {server setVariable ["resourcesFIA",_varValue,true]};
		if(_varName == 'destroyedCities') then {destroyedCities = +_varValue; publicVariable "destroyedCities"};
		if(_varName == 'skillFIA') then
			{
			skillFIA = _varValue; publicVariable "skillFIA";
			{
			_coste = server getVariable _x;
			for "_i" from 1 to _varValue do
				{
				_coste = round (_coste + (_coste * (_i/280)));
				};
			server setVariable [_x,_coste,true];
			} forEach soldadosSDK;
			};
		if(_varName == 'distanciaSPWN') then {distanciaSPWN = _varValue; distanciaSPWN1 = distanciaSPWN * 1.3; distanciaSPWN2 = distanciaSPWN /2; publicVariable "distanciaSPWN";publicVariable "distanciaSPWN1";publicVariable "distanciaSPWN2"};
		if(_varName == 'civPerc') then {civPerc = _varValue; if (civPerc < 1) then {civPerc = 35}; publicVariable "civPerc"};
		if(_varName == 'maxUnits') then {maxUnits=_varValue; publicVariable "maxUnits"};
		if(_varName == 'vehInGarage') then {vehInGarage= +_varValue; publicVariable "vehInGarage"};
		if(_varName == 'destroyedBuildings') then
			{
			destroyedBuildings= +_varValue;
			//publicVariable "destroyedBuildings";
			{
			//(nearestBuilding _x) setDamage [1,false];
			[nearestBuilding _x,[1,false]] remoteExec ["setDamage"];
			} forEach destroyedBuildings;
			};
		if(_varName == 'minas') then
			{
			for "_i" from 0 to (count _varvalue) - 1 do
				{
				_tipoMina = _varvalue select _i select 0;
				switch _tipoMina do
					{
					case "APERSMine_Range_Ammo": {_tipoMina = "APERSMine"};
					case "ATMine_Range_Ammo": {_tipoMina = "ATMine"};
					case "APERSBoundingMine_Range_Ammo": {_tipoMina = "APERSBoundingMine"};
					case "SLAMDirectionalMine_Wire_Ammo": {_tipoMina = "SLAMDirectionalMine"};
					case "APERSTripMine_Wire_Ammo": {_tipoMina = "APERSTripMine"};
					case "ClaymoreDirectionalMine_Remote_Ammo": {_tipoMina = "Claymore_F"};
                    case "APERSMineDispenser_Mine_Ammo": {_tipoMina = "APERSMineDispenser_Mine_F"};

                    case "APERSMineDispenser_Ammo": {_tipoMina = "APERSMineDispenser_F"};
                    case "DemoCharge_Remote_Ammo": {_tipoMina = "DemoCharge_F"};
                    case "SatchelCharge_Remote_Ammo": {_tipoMina = "SatchelCharge_F"};
                    case "IEDLandBig_Remote_Ammo": {_tipoMina = "IEDLandBig_F"};
                    case "IEDUrbanBig_Remote_Ammo": {_tipoMina = "IEDUrbanBig_F"};
                    case "IEDLandSmall_Remote_Ammo": {_tipoMina = "IEDLandSmall_F"};
                    case "IEDUrbanSmall_Remote_Ammo": {_tipoMina = "IEDUrbanSmall_F"};
					};

				_posMina = _varvalue select _i select 1;
				_mina = createMine [_tipoMina, _posMina, [], 0];
				_detectada = _varvalue select _i select 2;
				{_x revealMine _mina; player addOwnedMine _mina;} forEach _detectada;
				if (count (_varvalue select _i) > 3) then//borrar esto en febrero
					{
					_dirMina = _varvalue select _i select 3;
					_mina setDir _dirMina;
					};
				};
			};
		if(_varName == 'garrison') then
			{
			//_marcadores = marcadores - puestosFIA - controles - ciudades;
			{garrison setVariable [_x select 0,_x select 1,true]} forEach _varvalue;
			};
		if(_varName == 'puestosFIA') then
			{
			if (count (_varValue select 0) == 2) then
				{
				{
				_posicion = _x select 0;
				_garrison = _x select 1;
				_mrk = createMarker [format ["FIApost%1", random 1000], _posicion];
				_mrk setMarkerShape "ICON";
				_mrk setMarkerType "loc_bunker";
				_mrk setMarkerColor colorBuenos;
				if (isOnRoad _posicion) then {_mrk setMarkerText format ["%1 Roadblock",nameBuenos]} else {_mrk setMarkerText format ["%1 Watchpost",nameBuenos]};
				spawner setVariable [_mrk,2,true];
				if (count _garrison > 0) then {garrison setVariable [_mrk,_garrison,true]};
				puestosFIA pushBack _mrk;
				lados setVariable [_mrk,buenos,true];
				} forEach _varvalue;
				};
			};

		if(_varName == 'antenas') then
			{
			antenasmuertas = +_varvalue;
			for "_i" from 0 to (count _varvalue - 1) do
			    {
			    _posAnt = _varvalue select _i;
			    _mrk = [mrkAntenas, _posAnt] call BIS_fnc_nearestPosition;
			    _antena = [antenas,_mrk] call BIS_fnc_nearestPosition;
			    {if ([antenas,_x] call BIS_fnc_nearestPosition == _antena) then {[_x,false] spawn A3A_fnc_apagon}} forEach ciudades;
			    antenas = antenas - [_antena];
			    _antena removeAllEventHandlers "Killed";
			    _antena setDamage [1,false];
			    deleteMarker _mrk;
			    };
			antenasmuertas = _varvalue;
			publicVariable "antenas";
			publicVariable "antenasMuertas";
			};
		if(_varname == 'prestigeOPFOR') then
			{
			for "_i" from 0 to (count ciudades) - 1 do
				{
				_ciudad = ciudades select _i;
				_datos = server getVariable _ciudad;
				_numCiv = _datos select 0;
				_numVeh = _datos select 1;
				_prestigeOPFOR = _varvalue select _i;
				_prestigeBLUFOR = _datos select 3;
				_datos = [_numCiv,_numVeh,_prestigeOPFOR,_prestigeBLUFOR];
				server setVariable [_ciudad,_datos,true];
				};
			};
		if(_varname == 'prestigeBLUFOR') then
			{
			for "_i" from 0 to (count ciudades) - 1 do
				{
				_ciudad = ciudades select _i;
				_datos = server getVariable _ciudad;
				_numCiv = _datos select 0;
				_numVeh = _datos select 1;
				_prestigeOPFOR = _datos select 2;
				_prestigeBLUFOR = _varvalue select _i;
				_datos = [_numCiv,_numVeh,_prestigeOPFOR,_prestigeBLUFOR];
				server setVariable [_ciudad,_datos,true];
				};
			};
		if(_varname == 'idlebases') then
			{
			{
			server setVariable [(_x select 0),(_x select 1),true];
			} forEach _varValue;
			};
		if(_varname == 'idleassets') then
			{
			{
			timer setVariable [(_x select 0),(_x select 1),true];
			} forEach _varValue;
			};
		if(_varname == 'killZones') then
			{
			{
			killZones setVariable [(_x select 0),(_x select 1),true];
			} forEach _varValue;
			};
		if(_varName == 'posHQ') then
			{
			_posHQ = if (count _varValue >3) then {_varValue select 0} else {_varValue};
			{if (getMarkerPos _x distance _posHQ < 1000) then
				{
				lados setVariable [_x,buenos,true];
				};
			} forEach controles;
			respawnBuenos setMarkerPos _posHQ;
			petros setPos _posHQ;
			"Synd_HQ" setMarkerPos _posHQ;
			if (chopForest) then
				{
				if (!isMultiplayer) then {{ _x hideObject true } forEach (nearestTerrainObjects [position petros,["tree","bush"],70])} else {{ _x hideObjectGlobal true } forEach (nearestTerrainObjects [position petros,["tree","bush"],70])};
				};
			if (count _varValue == 3) then
				{
				[] spawn A3A_fnc_buildHQ;
				}
			else
				{
				fuego setPos (_varValue select 1);
				caja setDir ((_varValue select 2) select 0);
				caja setPos ((_varValue select 2) select 1);
				mapa setDir ((_varValue select 3) select 0);
				mapa setPos ((_varValue select 3) select 1);
				bandera setPos (_varValue select 4);
				cajaVeh setDir ((_varValue select 5) select 0);
				cajaVeh setPos ((_varValue select 5) select 1);
				};
			{_x setPos _posHQ} forEach (playableUnits select {side _x == buenos});
			};
		if(_varname == 'estaticas') then
			{
			for "_i" from 0 to (count _varvalue) - 1 do
			{
				_tipoVeh = _varvalue select _i select 0;
				_posVeh = _varvalue select _i select 1;
				_dirVeh = _varvalue select _i select 2;
				_veh = createVehicle [_tipoVeh,[0,0,1000],[],0,"CAN_COLLIDE"];
				_veh setPos _posVeh;
				_veh setDir _dirVeh;
				_veh setVectorUp surfaceNormal (getPosATL _veh);
				[_veh, buenos] call A3A_fnc_AIVEHinit;
				if ((_veh isKindOf "StaticWeapon") or (_veh isKindOf "Building")) then
				{
					staticsToSave pushBack _veh;
				} else {
				    _loadOut = _varvalue select _i select 3;
				    [_veh, _loadOut] call fn_setVehicleLoadout;
				};
			};
			publicVariable "staticsToSave";
			};
		if(_varname == 'tasks') then
			{
			{
			if (_x == "AtaqueAAF") then
				{
				[] call A3A_fnc_ataqueAAF;
				}
			else
				{
				if (_x == "DEF_HQ") then
					{
					[] spawn A3A_fnc_ataqueHQ;
					}
				else
					{
					[_x,true] call A3A_fnc_missionRequest;
					};
				};
			} forEach _varvalue;
			};
	} else {
		call compile format ["%1 = %2",_varName,_varValue];
	};
};

fn_getVehicleLoadout = {
  params ["_veh"];
  _return = [];
  private _loadOut = [];
  private _virtualWeapon = "";
  private _actions = [];
  private _textures = [];
  private _animations = [];
  private _pylons = [];
  private _pylonPaths = [];
  private _oldTrt = [];

  _loadOut pushBack [_veh, weaponsItemsCargo _veh, itemCargo _veh, magazineCargo _veh, backpackCargo _veh];
  {
    _loadOut pushBack [_x select 0, weaponsItemsCargo (_x select 1), itemCargo (_x select 1), magazineCargo (_x select 1),[]];
  } forEach everyContainer _veh;
  _return pushBack _loadOut;

  if (!isNil {_veh actionParams 0}) then {
    private _flagArsenalDbl = false;
    if (!isNil {_veh getVariable "bis_addVirtualWeaponCargo_cargo"}) then {
        _virtualWeapon = _veh getVariable ["bis_addvirtualweaponcargo_cargo",""];
    };
    for "_i" from 0 to (_veh addAction ["",""]) -1 do {
        if (!_flagArsenalDbl or !(["bis_fnc_arsenal",_veh actionParams _i select 1] call bis_fnc_instring)) then {
            private _act = _veh actionParams _i;
            {_act deleteAt 10;true} count [1,2];
            _actions pushBack _act;
            if(["bis_fnc_arsenal",_veh actionParams _i select 1] call bis_fnc_instring) then {_flagArsenalDbl = true};
        };
    };
  };
  _return pushBack _virtualWeapon;
  _return pushBack _actions;

  _textures = getObjectTextures _veh;
  if ( count _textures > 0) then {
      for "_i" from 0 to count _textures - 1 do {
        _textures set [_i,[_i,_textures select _i]]
      };
  };
  _return pushBack _textures;

  private _animList = animationNames _veh;
  if (count _animList > 0) then {
      for "_i" from 0 to count _animList -1 do {
        _animations pushBack [_animList select _i,_veh animationPhase (_animList select _i)];
      };
  };
  _return pushBack _animations;


  if (_veh isKindOf "air") then {
      _pylons = getPylonMagazines _veh;
      _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
  };
  _return pushBack _pylons;
  _return pushBack _pylonPaths;

  private _oldTrt = magazinesAllTurrets _veh;
  _return pushBack _oldTrt;
  _return;
};

fn_setVehicleLoadout = {
  params ["_veh","_data"];
  if (_veh isKindOf "CAManBase") exitWith {};
  private _loadOut = _data select 0;
  private _virtualWeapon = _data select 1;
  private _actions = _data select 2;
  private _textures = _data select 3;
  private _animations = _data select 4;
  private _pylons = _data select 5;
  private _pylonPaths = _data select 6;
  private _oldTrt = _data select 7;

  if(count _virtualWeapon > 0) then {
    _veh setVariable ["bis_addvirtualweaponcargo_cargo", _virtualWeapon];
  };
  if(count _actions > 0) then {
      {
          [_veh,_x] remoteExec ["addaction",0,true];
      } forEach _actions;
  };
  if(count _textures > 0) then {
    {
        _veh setObjectTextureGlobal _x;
    } forEach _textures;
  };
  if(count _animations > 0) then {
    {
        _veh animate _x;
    } forEach _animations;
  };
  if ((_veh isKindOf "air") and (count _pylons > 0) and (count _pylonPaths > 0)) then {
    {
        _veh removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
    } forEach getPylonMagazines _veh;
    {
       _veh setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]
    } forEach _pylons;
  };
  {_veh removeMagazineTurret _x} forEach (magazinesAllTurrets _veh apply {[_x select 0,_x select 1]});
  {_veh addMagazineTurret _x} forEach _oldTrt;
  if(count _loadOut > 0) then {
    {
      _x params ["_cont","_wp","_it","_mag",["_bpk",[]]];
      if (_cont isEqualType "") then {
        _cont = everyContainer _veh select (_forEachindex -1) select 1;
      } else {
        _cont = _veh;
      };
      clearItemCargoGlobal _cont;
      clearMagazineCargoGlobal _cont;
      clearWeaponCargoGlobal _cont;
      clearBackpackCargoGlobal _cont;
      [_wp,_cont,true] remoteExec ["fnc_addWeaponWithItems",0];
      {_cont addItemCargoGlobal [_x,1];true} count _it;
      {_cont addMagazineCargoGlobal [_x,1];true} count _mag;
      {_cont addBackpackCargoGlobal [_x,1];true} count _bpk;
    } forEach _loadOut;
  };

};

fnc_addWeaponWithItems = {
    params [ "_weaponsItems", "_container", [ "_useBaseWeapon", false ] ]; //weaponItems should be output from
    private ["_weapon","_items","_currentWeapons","_currentNumberWeapons","_center","_dummyGrp","_dummyUnit","_nul","_itemTransferred"];

    _fnc_clearUnit = {
        params[ "_unit","_weapon" ];
        removeAllWeapons _unit;
        removeAllItems _unit;
        _unit removeWeaponGlobal _weapon;
    };
    _center = createCenter civilian;
    _dummyGrp = createGroup _center;
    _dummyUnit = _dummyGrp createUnit [ "C_Man_1", [] call BIS_fnc_randomPos, [], 0, "NONE" ];
    waitUntil { !isNull _dummyUnit };
    _dummyUnit addEventHandler [ "HandleDamage", {
            0
    }];
    _dummyUnit allowDamage false;
    _dummyGrp deleteGroupWhenEmpty true;
    hideObjectGlobal _dummyUnit;
    {
        _dummyUnit disableAI _x;
    }forEach [
        "TARGET",
        "AUTOTARGET",
        "MOVE",
        "ANIM",
        "TEAMSWITCH",
        "FSM",
        "CHECKVISIBLE",
        "COVER",
        "AUTOCOMBAT"
    ];


    {//forEach _weaponsItems;
        _weapon = _x select 0;
        _items = _x - [_weapon];
        if ( _useBaseWeapon ) then {
            _weapon = _weapon call BIS_fnc_baseWeapon;
        };
        _currentNumberWeapons = count ((weaponCargo _container) select {_x == _weapon});


        [_dummyUnit, _weapon] call _fnc_clearUnit;

        waitUntil {
            _dummyUnit addWeaponGlobal _weapon;
            if(_weapon in ( weapons _dummyUnit )) exitWith {true};
            sleep 1;
            false
        };

        {
            //diag_log format ["load weapon item - %1", _x];
            if (count _x > 0) then {
                _dummyUnit addWeaponItem [_weapon, _x];
                waitUntil {
                    _dummyUnit addWeaponItem [_weapon, _x];
                    if(_x isEqualType "") then {
                        _itemTransferred = if(_x in (_dummyUnit weaponAccessories _weapon )) then {true} else {false};
                    } else {
                        _itemTransferred = if((_x select 0) in ((primaryWeaponMagazine _dummyUnit) + (secondaryWeaponMagazine _dummyUnit) + (handgunMagazine _dummyUnit))) then {true} else {false};
                    };
                    if(_itemTransferred) exitWith {true};
                    false
                };
            };
        } forEach _items;

        waitUntil {
            _dummyUnit action [ "DropWeapon", _container, _weapon ];
            //diag_log format ["waitn - %1 - %2 - %3 - %4 - %5", weaponCargo _container,_currentNumberWeapons,count ((weaponCargo _container) select {_x == _weapon}),_weapon, _container];
            sleep 1;
            if((count ((weaponCargo _container) select {_x == _weapon})) - _currentNumberWeapons > 0) exitWith {true};
            sleep 2;
            false
        };
    } forEach _weaponsItems;
    _dummyUnit allowDamage true;
    deleteVehicle _dummyUnit;
    deleteGroup _dummyGrp;
};

fn_saveStatic = {
    params ["_assembledWeapon"];
    if (!(_assembledWeapon isKindOf "StaticWeapon")) exitWith {};

	if (!(_assembledWeapon in staticsToSave)) then {
		staticsToSave pushBack _assembledWeapon;
		publicVariable "staticsToSave";
		[_assembledWeapon, side player] call A3A_fnc_AIVEHinit;
	};
	_marcadores = marcadores select {lados getVariable [_x,sideUnknown] == buenos};
	_pos = position _assembledWeapon;
	if (_marcadores findIf {_pos inArea _x} != -1) then {
	    hint "This static weapon is deployed for use in a nearby zone. If you leave it here it will be used by garrison militia the next time the zone spawns."
	};
	true
};

//==================================================================================================================================================================================================
saveFuncsLoaded = true;