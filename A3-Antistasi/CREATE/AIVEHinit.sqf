params ["_veh", "_vehicleSide"];
private ["_tipo","_animationsList","_doorAnimations","_randomHideDoor","_side"];

if ((isNil "_veh") or (_veh isKindOf "FlagCarrier") or (_veh isKindOf "Building") or (_veh isKindOf "ReammoBox_F")) exitWith {};

_tipo = typeOf _veh;

if(_vehicleSide != civilian) then {
    //Fill ammo truck with guns and ammo
    if (_tipo in vehAmmoTrucks) then {
        if (_veh distance getMarkerPos respawnBuenos > 100) then {
            _nul = [_veh, _vehicleSide] call A3A_fnc_fillAmmoCrate;
    	};
    };

    //Launch smoke when disembarking troops
    if (
        (({"SmokeLauncher" in (_veh weaponsTurret _x)} count (allTurrets _veh) > 0) and (((!(_tipo in vehAttack)) and (_veh isKindOf "Car")) or (_tipo in vehAPCs))) or
        ((_veh isKindOf "Helicopter") and (_tipo in vehTransportAir))
    ) then {
        _veh setVariable ["dentro",true];
        _veh addEventHandler ["GetOut", {
            params ["_veh", "_role", "_unit", "_turret"];
        	if (side _unit != buenos) then {
        	    if (((isTouchingGround _veh) and (isEngineOn _veh)) or (!(_veh isKindOf "Helicopter"))){
        	        if (_veh getVariable "dentro") then {
        	            _veh setVariable ["dentro",false];
        	            [_veh] call A3A_fnc_smokeCoverAuto;
        	        };
        	    };
        	};
        }];
        _veh addEventHandler ["GetIn", {
            params ["_veh", "_role", "_unit", "_turret"];
            if (side _unit != buenos) then {
                _veh setVariable ["dentro",true];
            };
        }];
    };

    if (_tipo in vehPlanes) then {
        _veh addEventHandler ["GetIn", {
    	    params ["_vehicle", "_role", "_unit", "_turret"];
    		if (_role == "driver") then {
    			if ((!isPlayer _unit) and (_unit getVariable ["spawner",false]) and (side group _unit == buenos)) then {
    				moveOut _unit;
    				hint "Only humans can pilot an air vehicle.";
    			};
    		};
    	}];
    };

    if (_veh isKindOf "StaticWeapon") {
        _veh setCenterOfMass [(getCenterOfMass _veh) vectorAdd [0, 0, -1], 0];
     	if ((not (_veh in staticsToSave)) and (side gunner _veh != buenos)) then {
       		if (activeGREF and ((_tipo == staticATBuenos) or (_tipo == staticAABuenos))) then {[_veh,"moveS"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_veh]} else {[_veh,"steal"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_veh]};
       	};
       	if (_tipo == SDKMortar) then {
       	    if (!isNull gunner _veh) then {
       			[_veh,"steal"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_veh];
       		};
       		_veh addEventHandler ["Fired",{
       		    params ["_mortero", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
       		    _datos = _mortero getVariable ["detection",[position _mortero,0]];
       		    _posicion = position _mortero;
       		    _chance = _datos select 1;
       		    if ((_posicion distance (_datos select 0)) < 300) then {
       			    _chance = _chance + 2;
       		    } else {
       			    _chance = 0;
       		    };
       		    if (random 100 < _chance) then {
       			    {if ((side _x == malos) or (side _x == muyMalos)) then {_x reveal [_mortero,4]}} forEach allUnits;
           			if (_mortero distance posHQ < 300) then {
           				if (!(["DEF_HQ"] call BIS_fnc_taskExists)) then {
       	    				_lider = leader (gunner _mortero);
       		    			if (!isPlayer _lider) then {
       			    			[[],"A3A_fnc_ataqueHQ"] remoteExec ["A3A_fnc_scheduler",2];
       				    	} else {
       					    	if ([_lider] call A3A_fnc_isMember) then {[[],"A3A_fnc_ataqueHQ"] remoteExec ["A3A_fnc_scheduler",2]};
           					};
           				};
       	    		} else {
       		    		_bases = aeropuertos select {(getMarkerPos _x distance _mortero < distanceForAirAttack) and ([_x,true] call A3A_fnc_airportCanAttack) and (lados getVariable [_x,sideUnknown] != buenos)};
       			    	if (count _bases > 0) then {
       				    	_base = [_bases,_posicion] call BIS_fnc_nearestPosition;
       					    _lado = lados getVariable [_base,sideUnknown];
           					[[getPosASL _mortero,_lado,"Normal",false],"A3A_fnc_patrolCA"] remoteExec ["A3A_fnc_scheduler",2];
           				};
       	    		};
       		    };
           		_mortero setVariable ["detection",[_posicion,_chance]];
    		}];
    	};
    };

    //Remove destroyed vehicle from pool and apply city support change as needed
    _veh addEventHandler ["killed",{
        params ["_veh","_killer"];
        private ["type"];
        [_veh] call A3A_fnc_removeVehFromPool;
        if (side _killer == buenos) then {
            _type = typeOf _veh;
             = [];
            _supportChange = switch (true) do {
                case (_type in vehNATOAPC) : {[-2,2]};
                case (_type in vehTanks) : {[-5,5]};
                case (_type in vehNATOAttackHelis) : {[-5,5]};
                case (_type in (vehNATOPlane + vehNATOPlaneAA)) : {[-8,8]};
                case (_type in (vehNATOAA + vehNATOMRLS)) : {[-5,5]};
                default {[]};
            };
            if(count _supportChange == 2) then {
                [_supportChange select 0, _supportChange select 1, position _veh] remoteExec ["A3A_fnc_citySupportChange",2];
            }
        };
        _veh removeAllEventHandlers "HandleDamage";
    }];
};

//City support penalty for stealing car and possibly report thief to occupiers
if((_vehicleSide == civilian) and (typeOf _veh in (arrayCivVeh + civBoats))) then {
    _veh addEventHandler ["GetIn",{
        params ["_veh", "_role", "_unit", "_turret"];
        if (({(_x getVariable ["spawner",false]) and (side group _x == buenos)} count crew _veh > 0) and
        (_veh distance getMarkerPos respawnBuenos > sizeHQZone)) then {
        	_pos = position _veh;
        	[0,-1,_pos] remoteExec ["A3A_fnc_citySupportChange",2];
        	_ciudad = [ciudades, _pos] call BIS_fnc_nearestPosition;
        	_datos = server getVariable _ciudad; //city
        	_prestigeOPFOR = _datos select 2;
        	sleep 5;
        	//If stealing car from occupier controlled city you may get reported
        	if (random 100 < _prestigeOPFOR) then {
        	    {
        		    _amigo = _x;
        		    if ((captive _amigo) and (isPlayer _amigo)) then {
        			    [_amigo,false] remoteExec ["setCaptive",0,_amigo];
        			    _amigo setCaptive false;
        		    };
        		    {
        		        if ((side _x == malos) and (_x distance _pos < distanciaSPWN)) then {_x reveal [_amigo,4]};
        		    } forEach allUnits;
        		} forEach crew _veh;
        	};
        };
    }];
};


//Stop wheels from being easily damaged. 95% sure this is what this is anyway.
if(!((_veh isKindOf "Plane") or (_veh isKindOf "Helicopter") or (_veh isKindOf "StaticWeapon"))){
    {
        if ((_x find "wheel") != -1) exitWith {
            _veh addEventHandler ["HandleDamage",{
                params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
                if ((_selection find "wheel" != -1) and
    		        ((_projectile == "") or (side _source != buenos)) and
    			    (!isPlayer driver _veh)) then {0} else {_damage};
    	    }];
        };
    } forEach (getAllHitPointsDamage _veh) select 0;
};

//Fire smoke if vehicle damaged by an enemy.
if ({"SmokeLauncher" in (_veh weaponsTurret _x)} count (allTurrets _veh) > 0) then {
    _veh addEventHandler ["HandleDamage",{
        params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
        if ((!canFire _veh) and ((side _source) != (side (crew _veh select 0)))) then {
            _veh removeEventHandler ["HandleDamage",_thisEventHandler];
            sleep 2;
            [_veh] call A3A_fnc_smokeCoverAuto;
        };
    }];
};





//CUSTOMISE VEHICLE
_animationsList = [
    "HideBumper1",
    "HideBumper2",
    "HideGlass2",
  //OFFROAD
    "hideRearDoor",
    "hideBullbar",
    "hideFenders",
    "hideHeadSupportRear",
    "hideHeadSupportFront",
    "hideRollcage",
    "hideSeatsRear",
    "hideSpareWheel",
  //VAN
    "ladder_hide",
    "spare_tyre_holder_hide",
    "spare_tyre_hide",
    "roof_rack_hide",
    "sidesteps_hide",
    "rearsteps_hide",
    "side_protective_frame_hide",
    "front_protective_frame_hide"
    //Armor
    "showCamonetPlates1",
    "showCamonetPlates2",
    "showCamonetTurret",
    "showCamonetHull",
    "showCamonetCannon",
    "showSLATHull",
    "showSLATTurret",
    "showTracks",
    "showBags",
    "showBags2",
    "showCanisters",
    "showAmmobox",
    "showLog",
    "showTools",
    //TRUCK
    "spz_hide"
];
_doorAnimations = [
  //LSV
    "Unarmed_Doors_Hide",
  //OFFROAD
    "HideDoor1",
    "HideDoor2",
    "HideDoor3",
    "HideDoor4",
    "hideLeftDoor",
    "hideRightDoor",
  //VAN
    "Hide_Door_1_source",
    "Hide_Door_2_source",
    "Hide_Door_3_source",
    "Hide_Door_4_source"
];
{_veh animate [_x, selectRandom [0,1], true];} forEach _animationsList;
_randomHideDoor = selectRandom [0,1];
{_veh animate [_x, _randomHideDoor, true];} forEach _doorAnimations;

//Hide the word "gendarmie" on non-Tanoa islands as French text would seem strange
if((typeOf _veh == "B_GEN_OFFROAD_01_gen_F") and (worldName != "Tanoa")) then {
    _veh animate ["HideDoor1", 1, true];
    _veh animate ["HideDoor2", 1, true];
    _veh animate ["Doors", 0, true];
};


//Retexture vehicle if necessary
switch (_vehicleSide) do {
    case west: {
        switch (typeOf _veh) do {
            case "I_MRAP_03_F";
            case "I_MRAP_03_hmg_F";
            case "I_MRAP_03_gmg_F": {
                [_veh,["Blufor",1]] call BIS_fnc_initVehicle;
            };
            case "I_APC_Wheeled_03_cannon_F";
            case "B_APC_Wheeled_03_cannon_F": {
                _veh setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
            	_veh setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
            	_veh setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
            	_veh setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
            };
            case "I_LT_01_scout_F";
            case "I_LT_01_cannon_F";
            case "I_LT_01_AA_F";
            case "I_LT_01_AT_F": {
                _veh setObjectTextureGlobal [0,"A3\armor_f_tank\lt_01\data\lt_01_main_olive_co.paa"];
                _veh setObjectTextureGlobal [1,"A3\armor_f_tank\lt_01\data\lt_01_cannon_olive_co.paa"];
                _veh setObjectTextureGlobal [2,"A3\Armor_F\Data\camonet_AAF_Digi_Green_CO.paa"];
                _veh setObjectTextureGlobal [3,"A3\armor_f\data\cage_olive_co.paa"];
            };
        };
    };
    case east: {
        switch (typeOf _veh) do {
            case "I_Truck_02_MRL_F": {
                [_veh,["Opfor",1]] call BIS_fnc_initVehicle;
            };
            case "I_Plane_Fighter_03_dynamicLoadout_F";
            case "I_Plane_Fighter_03_CAS_F";
            case "I_Plane_Fighter_03_AA_F";
            case "I_Plane_Fighter_03_Cluster_F": {
                //if(worldName == "Tanoa") then {
                    //_veh setObjectTextureGlobal [0,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_greyhex_CO.paa"];
                    //_veh setObjectTextureGlobal [1,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_greyhex_CO.paa"];
                //} else {
                    _veh setObjectTextureGlobal [0,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_brownhex_CO.paa"];
                    _veh setObjectTextureGlobal [1,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_2_brownhex_CO.paa"];
                //}
            };
        };
    };
    case independent: {
        switch (typeOf _veh) do {
            case "B_Heli_Light_01_F";
            case "B_Heli_Light_01_armed_F";
            case "B_Heli_Light_01_dynamicLoadout_F";
            case "B_Heli_Light_01_stripped_F": {
                _veh setObjectTextureGlobal [0, "A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_indp_co.paa"];
            };
            case "O_Heli_Light_02_F";
            case "O_Heli_Light_02_dynamicLoadout_F";
            case "O_Heli_Light_02_unarmed_F": {
                _veh setObjectTextureGlobal [0, "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa"];
            };
        };
    };
};

[_veh] spawn A3A_fnc_cleanserVeh;
_veh addEventHandler ["Killed",{[_this select 0] spawn A3A_fnc_postmortem}];


//Non Civ
if ((_vehicleSide != civilian) and !(_veh in staticsToSave)) then {
	if (((count crew _veh) > 0) and (!(_tipo in (vehAA + vehMRLS))) and (!(_veh isKindOf "StaticWeapon"))) then {
		[_veh] spawn A3A_fnc_VEHdespawner
	} else {
		_veh addEventHandler ["GetIn",{
		    params ["_vehicle", "_role", "_unit", "_turret"];
			if ((side _unit == buenos) or (isPlayer _unit)) then {[_vehicle] spawn A3A_fnc_VEHdespawner};
		}];
	};
};

//Civ
if((_vehicleSide == civilian) and
(typeOf _veh in (arrayCivVeh + civBoats)) and
(count crew _veh == 0) and
(!activeGREF) and
!(hayIFA)) then {
	sleep 10;
	[_veh,false] remoteExec ["enableSimulationGlobal",2];

	_veh addEventHandler ["GetIn",{
	    params ["_veh", "_role", "_unit", "_turret"];
		if (!simulationEnabled _veh) then {[_veh,true] remoteExec ["enableSimulationGlobal",2]};
		[_veh] spawn A3A_fnc_VEHdespawner;

	}];
	_veh addEventHandler ["HandleDamage",{
	    params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
		if (!simulationEnabled _veh) then {[_veh,true] remoteExec ["enableSimulationGlobal",2]};
	}];
};
