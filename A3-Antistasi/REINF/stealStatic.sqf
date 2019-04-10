private ["_cercano"];
params ["_estatica","_jugador"];

if (!alive _estatica) exitWith {hint "You cannot steal a destroyed static weapon"};

if (alive gunner _estatica) exitWith {hint "You cannot steal a static weapon when someone is using it"};

if ((alive assignedGunner _estatica) and (!isPlayer (assignedGunner _estatica))) exitWith {hint "The gunner of this static weapon is still alive"};

if (activeGREF and ((typeOf _estatica == staticATBuenos) or (typeOf _estatica == staticAABuenos))) exitWith {hint "This weapon cannot be dissassembled"};

_cercano = [marcadores,_estatica] call BIS_fnc_nearestPosition;

if (not(lados getVariable [_cercano,sideUnknown] == buenos)) exitWith {hint "You have to conquer this zone in order to be able to steal this Static Weapon"};

_estatica setOwner (owner _jugador);

_nul = [_estatica] call fn_saveStatic;