//if (!isServer) exitWith {};
params ["_crate","_side"];
private ["_multiplier","_cosa","_num","_magazines","_arms","_munitions","_staticWeaponBackpacks","_UAVBackpacks","_backpacks",
"_supportBackpack","_UAVTerminal","_staticWeaponChoices","_staticWeaponChoice","_staticWeaponSupportBackpackChoice","_filledAmmoCrate"];

_filledAmmoCrate = _crate getVariable ["filledAmmoCrate", false];
if(_filledAmmoCrate) exitWith {};

clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_multiplier = if (typeOf _crate in vehAmmoTrucks) then {2} else {1};
private _var1 = (1 + round random 4) * _multiplier;
private _var2 = (1 + round random 5) * _multiplier;
private _var3 = (1 + floor random 3) * _multiplier;
private _var4 = (floor random 2) * _multiplier;


if(_side == malos) then {
    _arms = armasNATO + guidedLaunchersNATO;
    _munitions = municionNATO;
    _staticWeaponBackpacks = if (!(NATOStaticBackpacks isEqualType objNull)) then {NATOStaticBackpacks} else {[]};
    _UAVBackpacks = if (!(NATOUAVBackpacks isEqualType objNull)) then {NATOUAVBackpacks} else {[]};
    _backpacks = if (!(NATOBackpacks isEqualType objNull)) then {NATOBackpacks} else {[]};

} else {
    _arms = armasCSAT + guidedLaunchersCSAT;
    _munitions = municionCSAT;
    _staticWeaponBackpacks = if (!(CSATStaticBackpacks isEqualType objNull)) then {CSATStaticBackpacks} else {[]};
    _UAVBackpacks = if (!(CSATUAVBackpacks isEqualType objNull)) then {CSATUAVBackpacks} else {[]};
    _backpacks = if (!(CSATBackpacks isEqualType objNull)) then {CSATBackpacks} else {[]};
};
_staticWeaponChoices = [];

if((count _staticWeaponBackpacks) > 0) then {
    {
        _supportBackpack = _x select 1;
        {
            _staticWeaponChoices pushBack [_x,_supportBackpack];
        } forEach (_x select 0);
    } forEach _staticWeaponBackpacks;
    _staticWeaponChoice = selectRandom _staticWeaponChoices;
};

//hint format ["%1 - %2 - %3",_staticWeaponChoice, _staticWeaponChoices, _staticWeaponBackpacks];

for "_i" from 0 to _var1 do {
	_cosa = selectRandom _arms;
	if (!(_cosa in unlockedWeapons)) then {
		_num = 1+ (floor random 12);
		_crate addWeaponCargoGlobal [_cosa, _num];
		_magazines = getArray (configFile / "CfgWeapons" / _cosa / "magazines");
		_crate addMagazineCargoGlobal [selectRandom _magazines, _num * 3];
	};
};
for "_i" from 0 to _var2 do {
	_cosa = selectRandom itemsAAF;
	if (!(_cosa in unlockedItems)) then {
		_num = floor random 5;
		_crate addItemCargoGlobal [_cosa, _num];
	};
	_cosa = selectRandom _munitions;
    if (!(_cosa in unlockedMagazines)) then {_crate addMagazineCargoGlobal [_cosa, 10]};
};

for "_i" from 1 to _var3 do {
	_cosa = selectRandom minasAAF;
	_num = 1 + (floor random 5);
	_crate addMagazineCargoGlobal [_cosa, _num];
};



if !(hayIFA) {

for "_i" from 1 to _var4 do {
    _cosa = selectRandom opticasAAF;
	if (not(_cosa in unlockedItems)) then {
		_crate addItemCargoGlobal [_cosa, 1 + (floor random 2)];
	};
};

if (round random 100 < 25) then {
    //small chance of wrong support backpack
    _staticWeaponSupportBackpackChoice = if (round random 100 < 10) then {(selectRandom _staticWeaponBackpacks) select 1} else {_staticWeaponChoice select 1};
    _crate addBackpackCargoGlobal [_staticWeaponChoice select 0,1];
    _crate addBackpackCargoGlobal [_staticWeaponSupportBackpackChoice,1];
} else {
	if (round random 100 < 50) then {
        if(count _UAVBackpacks > 0) then {
	        _UAVTerminal = switch(side group petros) do {
	            case independent: {"I_UavTerminal"};
	            case west: {"B_UavTerminal"};
	            case east: {"O_UavTerminal"};
	        };
	        _crate addItemCargoGlobal [_UAVTerminal,1];
	        _crate addBackpackCargoGlobal [selectRandom _UAVBackpacks,1];
	    };
	} else {
	    if(count _backpacks > 0) then {
	        for "_i" from 1 to (random 2) do {
        	    _crate addBackpackCargoGlobal [selectRandom (selectRandom _backpacks),round (random 2)];
            };
        };
	};
};
//NATO only
if ((_side == west) and hayACE) then {
	_crate addMagazineCargoGlobal ["ACE_HuntIR_M203", 3];
	//_crate addBackpackCargoGlobal ["ACE_HuntIR_Box",1];
	_crate addItemCargoGlobal ["ACE_HuntIR_monitor", 1];
};

};
_crate setVariable ["filledAmmoCrate",true];