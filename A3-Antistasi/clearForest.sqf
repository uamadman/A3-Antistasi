if (player != theBoss) exitWith {hint "Only Commanders can order the forest around the HQ cleared."};
if (!isMultiplayer) then {
    { _x hideObject true } foreach (nearestTerrainObjects [getMarkerPos respawnBuenos,["tree","bush"],70])
} else {
    {[_x,true] remoteExec ["hideObjectGlobal",2]} foreach (nearestTerrainObjects [getMarkerPos respawnBuenos,["tree","bush"],70])
};
hint "You've cleared the surroundings of trees and bushes.";
chopForest = true; publicVariable "chopForest";
