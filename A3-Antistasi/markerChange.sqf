if (!isServer) exitWith {};
params ["_winner","_marcador"];
private ["_looser","_posicion","_other","_bandera","_banderas","_dist","_texto","_sides","_nameSide","_flagTexture"];

if ((_winner == buenos) and (_marcador in aeropuertos) and (tierWar < 3)) exitWith {};
if ((_winner == buenos) and (lados getVariable [_marcador,sideUnknown] == buenos)) exitWith {};
if ((_winner == malos) and (lados getVariable [_marcador,sideUnknown] == malos)) exitWith {};
if ((_winner == muyMalos) and (lados getVariable [_marcador,sideUnknown] == muyMalos)) exitWith {};
if (_marcador in markersChanging) exitWith {};
markersChanging pushBackUnique _marcador;
_posicion = getMarkerPos _marcador;
_looser = lados getVariable [_marcador,sideUnknown];
_sides = [buenos,malos,muyMalos];
_other = "";
_texto = "";
_prestigeMalos = 0;
_prestigeMuyMalos = 0;
_bandera = objNull;
_size = [_marcador] call A3A_fnc_sizeMarker;

if ((!(_marcador in ciudades)) and (spawner getVariable _marcador != 2)) then {
	_banderas = nearestObjects [_posicion, ["FlagCarrier"], _size];
	_bandera = _banderas select 0;
};
if (isNil "_bandera") then {_bandera = objNull};
//[_bandera,"remove"] remoteExec ["A3A_fnc_flagaction",0,_bandera];

switch(_looser) do {
    case buenos: {_nameSide = nameBuenos; [] call A3A_fnc_tierCheck;};
    case malos: {_nameSide = nameBuenos;};
    case muyMalos: {_nameSide = nameMuyMalos;};
};
_texto = format ["%1 ",_nameSide];

garrison setVariable [_marcador,[],true];
lados setVariable [_marcador,_winner,true];
if (_winner == buenos) then {
	_super = if (_marcador in aeropuertos) then {true} else {false};
	[[_marcador,_looser,"",_super],"A3A_fnc_patrolCA"] call A3A_fnc_scheduler;
	//sleep 15;
	[[_marcador],"A3A_fnc_autoGarrison"] call A3A_fnc_scheduler;
} else {
	_soldados = [];
	{_soldados pushBack (typeOf _x)} forEach (allUnits select {(_x distance _posicion < (_size*3)) and (_x getVariable ["spawner",false]) and (side group _x == _winner) and (vehicle _x == _x) and (alive _x)});
	[_soldados,_winner,_marcador,0] remoteExec ["A3A_fnc_garrisonUpdate",2];
};

_nul = [_marcador] call A3A_fnc_mrkUpdate;
_sides = _sides - [_winner,_looser];
_other = _sides select 0;


switch (true) do {
    case (_marcador in aeropuertos): {
        private _guerillasCitySupportChange = 0;
        private _occupiersCitySupportChange = 0;

        switch(_winner) do {
            case buenos: {
                _occupiersCitySupportChange = 0;
                _guerillasCitySupportChange = 10;
        		[0,10,_posicion] remoteExec ["A3A_fnc_citySupportChange",2];
                switch(_looser) do {
                    case malos: {
                        _prestigeMalos = 20;
                        _prestigeMuyMalos = 10;
                    };
                    case muyMalos: {
                        _prestigeMalos = 10;
                        _prestigeMuyMalos = 20;
                    };
                };
            };
            case malos;
            case muyMalos: {
                server setVariable [_marcador,dateToNumber date,true];
        		[_marcador,60] call A3A_fnc_addTimeForIdle;
        		switch(_winner) do {
                    case malos: {
                        _occupiersCitySupportChange = 10;
                    };
                    case muyMalos: {
                        _occupiersCitySupportChange = -10;
                        _guerillasCitySupportChange = -10;
                    };
                };
        		if (_looser == buenos) then	{
                    _prestigeMalos = -10;
        			_prestigeMuyMalos = -10;
        		};
            };
        };
    	[_occupiersCitySupportChange,_guerillasCitySupportChange,_posicion] remoteExec ["A3A_fnc_citySupportChange",2];

    	_markerType = "Airbase";
    	killZones setVariable [_marcador,[],true];
    };
    case (_marcador in puestos): {
        if !(_winner == buenos) then {
    		server setVariable [_marcador,dateToNumber date,true];
    		if (_looser == buenos) then {
    			if (_winner == malos) then {_prestigeMalos = -5} else {_prestigeMuyMalos = -5};
    		};
    	} else {
    		if (_looser == malos) then {_prestigeMalos = 5;_prestigeMuyMalos = 2} else {_prestigeMalos = 2;_prestigeMuyMalos = 5};
    	};
    	_markerType = "Outpost";
    	killZones setVariable [_marcador,[],true];
    };
    case (_marcador in puertos): {
        if !(_winner == buenos) then {
    		if (_looser == buenos) then {
    			if (_winner == malos) then {_prestigeMalos = -5} else {_prestigeMuyMalos = -5};
    		};
    	} else {
    		if (_looser == malos) then {_prestigeMalos = 5;_prestigeMuyMalos = 2} else {_prestigeMalos = 2;_prestigeMuyMalos = 5};
    	};
    	_markerType = "Seaport";
    };
    case (_marcador in fabricas): {_markerType = "Factory";};
    case (_marcador in recursos): {_markerType = "Resource";};
    default {hint "default";};
};
["TaskSucceeded", ["", _markerType + " Taken"]] remoteExec ["BIS_fnc_showNotification",_winner];
["TaskFailed", ["", _markerType + " Lost"]] remoteExec ["BIS_fnc_showNotification",_looser];
["TaskUpdated",["",format ["%1 lost a " + _markerType,_texto]]] remoteExec ["BIS_fnc_showNotification",_other];

{_nul = [_marcador,_x] spawn A3A_fnc_deleteControles} forEach controles;


if (_winner == buenos) then {
	[] call A3A_fnc_tierCheck;
	if (!isNull _bandera) then {
		//[_bandera,"remove"] remoteExec ["A3A_fnc_flagaction",0,_bandera];
		[_bandera,"SDKFlag"] remoteExec ["A3A_fnc_flagaction",0,_bandera];
		sleep 2;
		//[_bandera,"unit"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_bandera];
		//[_bandera,"vehicle"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_bandera];
		//[_bandera,"garage"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_bandera];
		if (_marcador in puertos) then {[_bandera,"seaport"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_bandera]};
	};
	[_prestigeMalos,_prestigeMuyMalos] spawn A3A_fnc_prestige;
	waitUntil {sleep 1; ((spawner getVariable _marcador == 2)) or ({((side group _x) in [_looser,_other]) and (_x getVariable ["spawner",false]) and ([_x,_marcador] call A3A_fnc_canConquer)} count allUnits > 3*({(side _x == buenos) and ([_x,_marcador] call A3A_fnc_canConquer)} count allUnits))};
	if (spawner getVariable _marcador != 2) then {
		sleep 10;
		[_marcador,buenos] remoteExec ["A3A_fnc_zoneCheck",2];
	};
} else {
	if (_looser == buenos) then {
        if (!isNull _bandera) then {
			[_bandera,"remove"] remoteExec ["A3A_fnc_flagaction",0,_bandera];
			sleep 2;
			[_bandera,"take"] remoteExec ["A3A_fnc_flagaction",[buenos,civilian],_bandera];
	    };
		[_prestigeMalos,_prestigeMuyMalos] spawn A3A_fnc_prestige;
		if (
		    (random 10 < ((tierWar + difficultyCoef)/4)) and
		    !(["DEF_HQ"] call BIS_fnc_taskExists) and
		    (isPlayer theBoss)) then {
		        [[],"A3A_fnc_ataqueHQ"] remoteExec ["A3A_fnc_scheduler",2]
		};
	};
};

switch(_winner) do {
    case buenos: {_flagTexture = SDKFlagTexture;};
    case malos: {_flagTexture = NATOFlagTexture;};
    case muyMalos: {_flagTexture = CSATFlagTexture;};
};
if (!isNull _bandera) then {
    [_bandera,_flagTexture] remoteExec ["setFlagTexture",_bandera];
}

if ((_winner != buenos) and (_looser != buenos)) then {
    if(_marcador in (puestos + aeropuertos)) then {
        switch(true) do {
            case (_marcador in puestos): {
                _cercanos = (puertos + recursos + fabricas) select {((getMarkerPos _x) distance _posicion < distanciaSPWN) and (lados getVariable [_x,sideUnknown] != buenos)};
            };
            case (_marcador in aeropuertos): {
                _cercanos = (puertos + puestos) select {((getMarkerPos _x) distance _posicion < distanciaSPWN) and (lados getVariable [_x,sideUnknown] != buenos)};
			    _cercanos append ((fabricas + recursos) select {(lados getVariable [_x,sideUnknown] != buenos) and
			        (lados getVariable [_x,sideUnknown] != _winner) and
			        ([aeropuertos,_x] call BIS_fnc_nearestPosition == _marcador)
			    });
            };
        };
	    _cercanos = _cercanos select {lados getVariable [_x,sideUnknown] == _looser};
        {[_winner,_x] spawn A3A_fnc_markerChange; sleep 5} forEach _cercanos;
    }
};
markersChanging = markersChanging - [_marcador];