params ["_position","_direction","_typeOfVehicle","_sideOrGroup",["_facilityMarker",""]];
private ["_spawnedVehicle","_veh","_vehCrew","_vehGroup","_existingCrewType","_existingCrewTypes",
    "_newCrewMember","_newCrew","_newCrewType","_newCrewTypes",
    "_sideIslandCrewEquivalents","_crewToChangeTo","_keepLooking","_needNewCrew", "_role"
];

_spawnedVehicle = [_position, _direction, _typeOfVehicle, _sideOrGroup] call BIS_fnc_spawnVehicle;

_veh = _spawnedVehicle select 0;
_vehCrew = _spawnedVehicle select 1;
_vehGroup = _spawnedVehicle select 2;
_side = side _vehGroup;

_existingCrewTypes = [];
_newCrewTypes = [];
_needNewCrew = false;

_sideIslandCrewEquivalents = [
    [//BLUFOR
        [ //ALTIS AND ANYWHERE ELSE
            "B_Soldier_F",
            "B_crew_F",
            "B_Helipilot_F",
            "B_helicrew_F",
            "B_Pilot_F",
            "B_Fighter_Pilot_F"
        ],[ //TANOA
            "B_T_Soldier_F",
            "B_T_Crew_F",
            "B_T_Helipilot_F",
            "B_T_Helicrew_F",
            "B_T_Pilot_F",
            "B_Fighter_Pilot_F"
        ]
    ],[//OPFOR
        [ //ALTIS AND ANYWHERE ELSE
            "O_Soldier_F",
            "O_crew_F",
            "O_helipilot_F",
            "O_helicrew_F",
            "O_Pilot_F",
            "O_Fighter_Pilot_F"
        ],[ //TANOA
            "O_T_Soldier_F",
            "O_T_Crew_F",
            "O_T_helipilot_F",
            "O_T_Helicrew_F",
            "O_T_Pilot_F",
            "O_T_Pilot_F"
        ]
    ],[//INDEPENDENT
        [ //ALTIS AND ANYWHERE ELSE
            "I_soldier_F",
            "I_crew_F",
            "I_helipilot_F",
            "I_helicrew_F",
            "I_pilot_F",
            "I_Fighter_Pilot_F"
        ]
    ]
];

if((count _vehCrew > 0) and (!hayIFA) and (!activeUSAF or !activeAFRF or !activeGREF)) then {
//forEach _vehCrew
{
    _existingCrewType = typeOf _x;
    _existingCrewTypes pushback _existingCrewType;
    switch (worldName) do {
        case "Tanoa": {
            _crewToChangeTo = switch (_side) do {
                case west: {_sideIslandCrewEquivalents select 0 select 1;};
                case east: {_sideIslandCrewEquivalents select 1 select 1;};
                case independent: {_sideIslandCrewEquivalents select 2 select 0;}; //would be select 2 select 1 but AAF have no Tanoa assets.
            };
        };
        default { //ANYWHERE OTHER THAN TANOA
            _crewToChangeTo = switch (_side) do {
                case west: {_sideIslandCrewEquivalents select 0 select 0;};
                case east: {_sideIslandCrewEquivalents select 1 select 0;};
                case independent: {_sideIslandCrewEquivalents select 2 select 0;};
            };
        };
    };

    //LOOK FOR CORRECT EQUIVALENT CREW
    _newCrewType = _existingCrewType;
    _keepLooking = true;
    {
        if(!_keepLooking) exitWith {};
        {
            if(!_keepLooking) exitWith {};
            {
                if(_existingCrewType == _x) exitWith {_newCrewType = _crewToChangeTo select _forEachIndex; _keepLooking = false;};
            }
            forEach _x;
        } forEach _x;
    } forEach _sideIslandCrewEquivalents;

    _newCrewTypes pushback _newCrewType;
    if(_newCrewType != _existingCrewType) then {
        _needNewCrew = true;
    }
} forEach _vehCrew;

if(_needNewCrew) then {
    _newCrew = [];
    {
        _newCrewMember = _vehGroup createUnit [_newCrewTypes select _forEachIndex, getPos _veh, [], 0, "NONE"];
        _newCrewMember allowDamage false;
        _newCrewMember setRank (rank _x);
        if((leader _vehGroup) == _x) then {_vehGroup selectLeader _newCrewMember};
        _role = assignedVehicleRole _x;
        _veh deleteVehicleCrew _x;
        sleep 1;
        [_veh, _newCrewMember, _role] call BIS_fnc_moveIn;
        _newCrew pushback _newCrewMember;
        _newCrewMember allowDamage true;
        if(_side != buenos) then {[_newCrew, _facilityMarker] call A3A_fnc_NATOinit;};
    } forEach _vehCrew;

    _vehCrew = _newCrew;
};
};

[_veh, _side] call A3A_fnc_AIVEHinit;
_spawnedVehicle = [_veh,_vehCrew,_vehGroup];
_spawnedVehicle