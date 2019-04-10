params["_veh"];
private ["_animationsList","_doorAnimations","_randomHideDoor"];

if (_veh isKindOf "Car") then {
	_veh addEventHandler ["HandleDamage",{
	    if (((_this select 1) find "wheel" != -1) and (_this select 4=="") and (!isPlayer driver (_this select 0))) then {0} else {(_this select 2)};
	}];
};

[_veh] spawn A3A_fnc_cleanserVeh;

_veh addEventHandler ["Killed",{[_this select 0] spawn A3A_fnc_postmortem}];

_randomHideDoor = selectRandom [0,1];

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
];
_doorAnimations = [
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
{_veh animateSource [_x, selectRandom [0,1], true];} forEach _animationsList;
{_veh animateSource [_x, _randomHideDoor, true];} forEach _doorAnimations;


if ((count crew _veh == 0) and (!activeGREF) and !(hayIFA)) then {
	sleep 10;
	if (isMultiplayer) then {[_veh,false] remoteExec ["enableSimulationGlobal",2]} else {_veh enableSimulation false};
	_veh addEventHandler ["GetIn",{
	    params ["_veh", "_role", "_unit", "_turret"];
		if (!simulationEnabled _veh) then {if (isMultiplayer) then {[_veh,true] remoteExec ["enableSimulationGlobal",2]} else {_veh enableSimulation true}};
		[_veh] spawn A3A_fnc_VEHdespawner;
	}];
	_veh addEventHandler ["HandleDamage",{
	    params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
		if (!simulationEnabled _veh) then {if (isMultiplayer) then {[_veh,true] remoteExec ["enableSimulationGlobal",2]} else {_veh enableSimulation true}};
	}];
};