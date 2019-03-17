fn_addEconomicsAssets = {
    _assetTypes = _this select 0;
	_assetMaxItems = _this select 1;
	_factor = _this select 2;
	_acelerador = _this select 3;

	_totalNumberItems = 0;
	{
	    _numberItem = timer getVariable [_x,0];
	    _totalNumberItems = _totalNumberItems + (floor _numberItem);
	} forEach _assetTypes;
	_diff = 0;
    if (_totalNumberItems < _maxItems) then {
        {
            _maxDiff = _diff;
            _numberItem = timer getVariable [_x,0];
            _diff = _numberItem - (floor _numberItem);
            if(_diff > _maxDiff) then {
                _maxDiff = _diff;
                _bestItem = _x;
                _numberBestItem = _numberItem
            };
            if((_diff == _maxDiff) and (_numberItem < _numberBestItem)) then {
                _bestItem = _x;
                _numberBestItem = _numberItem
            };
        } forEach _assetTypes;
        timer setVariable [_bestItem,_numberBestItem + (_factor * _acelerador),true];
    };
};

{
_lado = _x;
_acelerador = if (_lado == malos) then {if (tierWar == 1) then {0} else {1+((tierWar + difficultyCoef)/20)}} else {1.2+((tierWar + difficultyCoef)/20)};
_airbases = {lados getVariable [_x,sideUnknown] == _lado} count aeropuertos;
_puestos =  {lados getVariable [_x,sideUnknown] == _lado} count puestos;
_puertos = {lados getVariable [_x,sideUnknown] == _lado} count puertos;

if (_lado == malos) then {
    _staticAT = [staticATmalos];
    _staticAA = [staticAAmalos];
    _APCs = vehNATOAPC;
    _tanks = vehNATOTank;
    _AAVehicles = vehNATOAA;
    _attackBoats = [vehNATOBoat];
    _CASPlanes = vehNATOPlane;
    _AAPlanes = vehNATOPlaneAA;
    _airTransports = vehNATOTransportHelis - [vehNATOPatrolHeli];
    _attackHelis = vehNATOAttackHelis;
    _artillery = vehNATOMRLS;
} else {
    _staticAT = [staticATmuyMalos];
    _staticAA = [staticAAmuyMalos];
    _APCs = vehCSATAPC;
    _tanks = vehCSATTank;
    _AAVehicles = vehCSATAA;
    _attackBoats = [vehCSATBoat];
    _CASPlanes = vehCSATPlane;
    _AAPlanes = vehCSATPlaneAA;
    _airTransports = vehCSATTransportHelis - [vehCSATPatrolHeli];
    _attackHelis = vehCSATAttackHelis;
    _artillery = vehCSATMRLS;
};

//Anti Tank
[_staticAT,(_puestos * 0.2) + (_airbases * 0.5), 0.2, _acelerador] call fn_addEconomicsAssets;
//Anti-Air
[_staticAA, _airbases * 2, 0.1, _acelerador] call fn_addEconomicsAssets;
//APCs
[_APCs, (_puestos * 0.3) + (_airbases * 2), 0.2, _acelerador] call fn_addEconomicsAssets;
//Tanks
[_tanks, (_puestos * 0.5) + (_airbases * 2), 0.1, _acelerador] call fn_addEconomicsAssets;
//aaTANKS
[_AAVehicles, _airbases, 0.1, _acelerador] call fn_addEconomicsAssets;
//ATTACK BOATS
[_attackBoats, _puertos, 0.3, _acelerador] call fn_addEconomicsAssets;
//CAS PLANE
[_CASPlanes, _airbases * 4, 0.2, _acelerador] call fn_addEconomicsAssets;
//AA PLANE
[_AAPlanes, _airbases * 4, 0.2, _acelerador] call fn_addEconomicsAssets;
//AIR TRANSPORTS
[_airTransports, _airbases * 4, 0.2, _acelerador] call fn_addEconomicsAssets;
//ATTACK HELIS
[_attackHelis, _airbases * 4, 0.2, _acelerador] call fn_addEconomicsAssets;
//ARTY
[_artillery, _airbases + (_puestos * 0.2), 0.2, _acelerador] call fn_addEconomicsAssets;
} forEach [malos,muyMalos];