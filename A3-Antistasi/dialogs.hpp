class first_load {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Load previous session?";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 103;
			text = "YES";
			tooltip = "Loads the pervious personal session";
			action = "closeDialog 0;nul = [true] execVM ""statSave\loadAccount.sqf"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 104;
			text = "NO";
			tooltip = "Starts a new game";
			action = "closeDialog 0;if ((player == theBoss) and (isNil ""placementDone"") and !(isMultiplayer)) then {closeDialog 0;[] execVM ""dialogs\difficultyMenu.sqf""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class HQ_menu {
	idd = 100;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.45 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "HQ Options - Commander Only";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.41 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_load: RscButton
		{
			idc = 104;
			text = "Grab 100 € from Pool";
			tooltip = "Take 100 € from faction pool and add it to your personnal account. It will damage your position among the faction in the commander career";
			action = "if (isMultiPlayer) then {if (player == theBoss) then {nul=call A3A_fnc_theBossSteal} else {hint ""Only Player Commander has access to this function""}} else {hint ""This function is MP only""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_savegame: RscButton
		{
			idc = 105;
			text = "Manage Garrisons";
			tooltip = "Add or remove units to garrisons";
			action = "closeDialog 0;if (player == theBoss) then {nul=CreateDialog ""build_menu""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_moveHQ: RscButton
		{
			idc = 106;
			text = "Move HQ to another Zone";
			tooltip = "Petros will join your group. Ammobox must be empty. To rebuild, select the Build action near Petros";
			action = "closeDialog 0;if (player == theBoss) then {nul = [] spawn A3A_fnc_moveHQ;} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_recruitUnit: RscButton
		{
			idc = 107;
			text = "Ingame Member's List";
			tooltip = "Displays which server members are currently playing";
			action = "if (player == theBoss) then {if (isMultiplayer) then {nul = [] call A3A_fnc_membersList} else {hint ""This function is MP only""}} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_recruitSquad: RscButton
		{
			idc = 108;
			text = "Rebuild Assets";
			tooltip = "Cost: 5.000 €";
			action = "closeDialog 0;if (player == theBoss) then {nul=[] spawn A3A_fnc_rebuildAssets} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_vehicle: RscButton
		{
			idc = 109;
			text = "Train AI - Skill Upgrade";
			action = "closeDialog 0;if (player == theBoss) then {nul = [] call A3A_fnc_FIAskillAdd} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_skill: RscButton
		{
			idc = 110;
			text = "Garage Access";
			tooltip = "Check Faction garage";
			action = "closeDialog 0;nul = [false] spawn A3A_fnc_garage";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class build_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Building & Garrison Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""HQ_menu"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class 4slots_L1: RscButton
		{
			idc = 104;
			text = "Minefield Options";
			tooltip = "AI will deploy or remove mines on desired objectives, using current arsenal mine count";
			action = "closeDialog 0;_nul = createDialog ""minebuild_menu"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 4slots_R1: RscButton
		{
			idc = 105;
			text = "O.Post - Roadblock";
			tooltip = "Establish a new watchpost or roadblock depending on the type of terrain you select";
			action = "closeDialog 0; [""create""] spawn A3A_fnc_puestoDialog";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 4slots_L2: RscButton
		{
			idc = 106;
			text = "Add Garrison";
			tooltip = "Add units to an existing garrison";
			action = "closeDialog 0; [""add""] spawn A3A_fnc_garrisonDialog";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 4slots_R2: RscButton
		{
			idc = 107;
			text = "Remove Garrison";
			tooltip = "Remove whole garrisons or posts";
			action = "closeDialog 0; [""rem""] spawn A3A_fnc_garrisonDialog";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class garrison_recruit {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Garrison Recruitment Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""build_menu"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_rifleman: RscButton
		{
			idc = 104;
			text = "Recruit Militiaman";
			action = "nul = [SDKMil] spawn A3A_fnc_garrisonAdd";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_autorifleman: RscButton
		{
			idc = 105;
			text = "Recruit Autorifleman";
			action = "nul = [SDKMG] spawn A3A_fnc_garrisonAdd";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_medic: RscButton
		{
			idc = 106;
			text = "Recruit Medic";
			action = "nul = [SDKMedic] spawn A3A_fnc_garrisonAdd";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_engineer: RscButton
		{
			idc = 107;
			text = "Recruit Squad Leader";
			action = "nul = [SDKSL] spawn A3A_fnc_garrisonAdd";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_explosive: RscButton
		{
			idc = 108;
			text = "Recruit Mortar";
			action = "nul = [staticCrewBuenos] spawn A3A_fnc_garrisonAdd";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_grenadier: RscButton
		{
			idc = 109;
			text = "Recruit Grenadier";
			action = "nul = [SDKGL] spawn A3A_fnc_garrisonAdd";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_marksman: RscButton
		{
			idc = 110;
			text = "Recruit Marksman";
			action = "nul = [SDKSniper] spawn A3A_fnc_garrisonAdd";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 111;
			text = "Recruit AT";
			action = "nul = [SDKATman] spawn A3A_fnc_garrisonAdd";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class minebuild_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Build Minefield";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""build_menu"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 104;
			text = "APERS Mines";
			action = "closeDialog 0;[""APERSMine""] spawn A3A_fnc_mineDialog";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_MG: RscButton
		{
			idc = 105;
			text = "Remove Minefield";
			tooltip = "Spawn an AI Engineer which will clear any mine in it's surroundings";
			action = "closeDialog 0; [""delete""] spawn A3A_fnc_mineDialog;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 106;
			text = "AT Mines";
			action = "closeDialog 0; [""ATMine""] spawn A3A_fnc_mineDialog";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class unit_recruit {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Recruitment Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_rifleman: RscButton
		{
			idc = 104;
			text = "Recruit Militiaman";
			action = "nul = [SDKMil] spawn A3A_fnc_reinfPlayer";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_autorifleman: RscButton
		{
			idc = 105;
			text = "Recruit Autorifleman";
			action = "nul = [SDKMG] spawn A3A_fnc_reinfPlayer";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_medic: RscButton
		{
			idc = 106;
			text = "Recruit Medic";
			action = "nul = [SDKMedic] spawn A3A_fnc_reinfPlayer";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_engineer: RscButton
		{
			idc = 107;
			text = "Recruit Engineer";
			action = "nul = [SDKEng] spawn A3A_fnc_reinfPlayer";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_explosive: RscButton
		{
			idc = 108;
			text = "Recruit Bomb Specialist";
			action = "nul = [SDKExp] spawn A3A_fnc_reinfPlayer";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_grenadier: RscButton
		{
			idc = 109;
			text = "Recruit Grenadier";
			action = "nul = [SDKGL] spawn A3A_fnc_reinfPlayer";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_marksman: RscButton
		{
			idc = 110;
			text = "Recruit Marksman";
			action = "nul = [SDKSniper] spawn A3A_fnc_reinfPlayer";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 111;
			text = "Recruit AT";
			action = "nul = [SDKATman] spawn A3A_fnc_reinfPlayer";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class vehicle_option {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Buy Vehicle";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Civilian Vehicle";
			tooltip = "Civilian vehicles will allow you to travel in Undercover mode, while you stay close to roads and not entering bases, outposts and roadblocks";
			action = "closeDialog 0;nul=[] execVM ""Dialogs\buy_vehicle_civ.sqf"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Military Vehicle";
			tooltip = "Wide variety of available faction vehicles";
			action = "closeDialog 0; nul=[] execVM ""Dialogs\buy_vehicle.sqf"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class buy_vehicle {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Purchase Military Vehicle";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0; nul = createDialog ""vehicle_option"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_quad: RscButton
		{
			idc = 104;
			text = "Buy Quadbike";
			action = "closedialog 0; nul = [vehSDKBike] spawn A3A_fnc_addFIAveh";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_offroad: RscButton
		{
			idc = 105;
			text = "Buy Offroad";
			action = "closeDialog 0;nul = [vehSDKLightUnarmed] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_truck: RscButton
		{
			idc = 106;
			text = "Buy Truck";
			action = "closeDialog 0;nul = [vehSDKTruck] spawn A3A_fnc_addFIAveh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Aoffroad: RscButton
		{
			idc = 107;
			text = "Buy Armed Offroad";
			action = "closeDialog 0;nul = [vehSDKLightArmed] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_MG: RscButton
		{
			idc = 108;
			text = "Buy MG";
			action = "closeDialog 0;nul = [SDKMGStatic] spawn A3A_fnc_addFIAveh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 109;
			text = "Buy Mortar";
			action = "closeDialog 0;nul = [SDKMortar] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 110;
			text = "Buy Static AT";
			action = "closeDialog 0;nul = [staticATBuenos] spawn A3A_fnc_addFIAveh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AA: RscButton
		{
			idc = 111;
			text = "Buy Static AA";
			action = "closeDialog 0;nul = [staticAABuenos] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class civ_vehicle {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Buy Civilian Vehicle";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0; nul = createDialog ""vehicle_option"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Offroad";
			action = "closeDialog 0;nul = [civCar] spawn A3A_fnc_addFIAveh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Truck";
			action = "closeDialog 0;nul = [civTruck] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "Helicopter";
			action = "closeDialog 0;nul = [civHeli] spawn A3A_fnc_addFIAveh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_offroad: RscButton
		{
			idc = 107;
			text = "Boat";
			action = "closeDialog 0;[civBoat] spawn A3A_fnc_addFIAveh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class game_options {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Game Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class 8slots_L1: RscButton
		{
			idc = 104;
			text = "Civ Limit";
			tooltip = "Set the max number of spawned civilians. Affects game performance";
			action = "if (player == theBoss) then {closeDialog 0; nul = createDialog ""civ_config""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R1: RscButton
		{
			idc = 105;
			text = "Spawn Distance";
			tooltip = "Affects performance. Please use this with caution. Set it to lower distances if you feel Antistasi is running bad";
			action = "if (player == theBoss) then {closeDialog 0; nul = createDialog ""spawn_config""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L2: RscButton
		{
			idc = 106;
			text = "AI Limiter";
			tooltip = "Sets how much local and simulated AI can spawn in the map. Affects performance and AI intelligence. Use with caution. This is not an exact number as vehicles and squad leaders will allways spawn";
			action = "if (player == theBoss) then {closeDialog 0; nul = createDialog ""fps_limiter""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R2: RscButton
		{
			idc = 107;
			text = "Music ON/OFF";
			tooltip = "Disables/Enable situational music";
			action = "closedialog 0; if (musicON) then {musicON = false; hint ""Music turned OFF""} else {musicON = true; hint ""Music turned ON""}; nul = execVM ""musica.sqf"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_M4: RscButton
		{
			idc = 108;
			text = "Persistent Save";
			tooltip = "Use this option to save your current game. It does save the most important data in a Grand Theft Auto way. This opnion allows good MP save and independent saves of any version update. Vanilla saves are disabled because of lack of several features";
			action = "closeDialog 0;if (player == theBoss) then {[""statSave\saveLoop.sqf"",""BIS_fnc_execVM""] call BIS_fnc_MP} else {_nul = [] execVM ""statSave\saveLoop.sqf""; hintC ""Personal Stats Saved""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class fps_limiter {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "AI Limiter";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""game_options"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "+10 AI Limit";
			action = "if (player == theBoss) then {if (maxUnits < 200) then {maxUnits = maxUnits + 10; publicVariable ""maxUnits""; hint format [""AI Limit has been set at %1"",maxUnits]} else {hint ""AI Limit cannot be raised from 200""}} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "-10 AI Limit";
			action = "if (player == theBoss) then {if (maxUnits > 80) then {maxUnits = maxUnits - 10; publicVariable ""maxUnits""; hint format [""AI Limit has been set at %1"",maxUnits]} else {hint ""AI Limit cannot be less than 80""}} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class spawn_config {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Spawn Distance Config";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""game_options"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "+100 Spawn Dist.";
			action = "if (player == theBoss) then {if (distanciaSPWN < 2000) then {distanciaSPWN = distanciaSPWN + 100; distanciaSPWN1 = distanciaSPwN * 1.3; distanciaSPWN2 = distanciaSPWN /2; publicVariable ""distanciaSPWN"";publicVariable ""distanciaSPWN1"";publicVariable ""distanciaSPWN2""}; hint format [""Spawn Distance Set to %1 meters. Be careful, this may affect game performance"",distanciaSPWN]} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "-100 Spawn Dist.";
			action = "if (player == theBoss) then {if (distanciaSPWN > 600) then {distanciaSPWN = distanciaSPWN - 100; if (distanciaSPWN < 600) then {distanciaSPWN = 600}; distanciaSPWN1 = distanciaSPwN * 1.3; distanciaSPWN2 = distanciaSPWN /2; if (distanciaSPWN < 600) then {distanciaSPWN = 600};publicVariable ""distanciaSPWN"";publicVariable ""distanciaSPWN1"";publicVariable ""distanciaSPWN2"";}; hint format [""Spawn Distance Set to %1 meters"",distanciaSPWN]} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class civ_config {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Civ Presence Config";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""game_options"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "+1 Max Civs";
			action = "if (player == theBoss) then {if (civPerc < 150) then {civPerc = civPerc + 1; if (civPerc > 150) then {civPerc = 150}; publicVariable ""civPerc"";}; hint format [""Maximum Number of Civilians Set to %1"",civPerc]} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "-1 Max Civs";
			action = "if (player == theBoss) then {if (civPerc > 0) then {civPerc = civPerc - 1; if (civPerc < 0) then {civPerc = 0};publicVariable ""civPerc"";}; hint format [""Maximum Number of Civilians Set to %1"",civPerc]} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class mission_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.45 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Available Missions";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.41 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_AS: RscButton
		{
			idc = 104;
			text = "Assassination Mission";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""AS""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_CONV: RscButton
		{
			idc = 105;
			text = "Convoy Ambush";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""CONVOY""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_DES: RscButton
		{
			idc = 106;
			text = "Destroy Missions";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""DES""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_LOG: RscButton
		{
			idc = 107;
			text = "Logistics Mission";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""LOG""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_RES: RscButton
		{
			idc = 108;
			text = "Rescue Missions";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""RES""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_vehicle: RscButton
		{
			idc = 109;
			text = "Conquest Missions";
			action = "closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""CON""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_exit: RscButton
		{
			idc = 110;
			text = "EXIT";
			action = "closeDialog 0;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class radio_comm {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Battle Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class 8slots_L1: RscButton
		{
			idc = 104;
			text = "Fast Travel";
			tooltip = "Teleport your squad or a HC selected squad to a friendly zone depending on several factors";
			action = "closeDialog 0;nul = [] execVM ""fastTravelRadio.sqf"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R1: RscButton
		{
			idc = 105;
			text = "Player and Money";
			tooltip = "Look at some player and interact with him";
			action = "closeDialog 0;if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L2: RscButton
		{
			idc = 106;
			text = "Undercover ON";
			tooltip = "Become Undercover if you match the requirements. Enemy AI won't attack you until they discover you";
			action = "closeDialog 0;nul = [] spawn A3A_fnc_undercover";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R2: RscButton
		{
			idc = 107;
			text = "Construct Here";
			tooltip = "Construct in the spot where you are a selected building facing this direction";
			action = "closeDialog 0;_nul = createDialog ""construction_menu"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L3: RscButton
		{
			idc = 108;
			text = "Garage Vehicle";
			tooltip = "Vehicle or Static gun you're looking at will be garaged, interact with Flag to retrieve";
			action = "closeDialog 0;if (player != theBoss) then {nul = [false] call A3A_fnc_garageVehicle} else {if (isMultiplayer) then {_nul = createDialog ""garage_check""} else {nul = [true] call A3A_fnc_garageVehicle}};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R3: RscButton
		{
			idc = 109;
			text = "Unlock Vehicle";
			tooltip = "Allow other groups to mount this vehicle";
			action = "closeDialog 0;[] call A3A_fnc_unlockVehicle";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L4: RscButton
		{
			idc = 110;
			text = "AI Management";
			tooltip = "Several AI options";
			action = "if (player == leader group player) then {closeDialog 0;nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R4: RscButton
		{
			idc = 111;
			text = "Commander";
			tooltip = "Open commander options";
			action = "closeDialog 0; nul = createDialog ""commander_comm"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class vehicle_manager {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Vehicle Manager";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Garage\Sell Vehicle";
			tooltip = "Add to garage / sell the vehicle you are currently looking at";
			action = "closeDialog 0;nul = createDialog ""garage_sell"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Vehicles and Squads";
			tooltip = "Options related to vehicle management in HC controlled squads";
			action = "closeDialog 0; if (player == theBoss) then {nul = createDialog ""squad_manager""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "Add to Air Support";
			tooltip = "Gain Airstrike points giving this vehicle to the faction Air pool";
			action = "closeDialog 0;nul = [] call A3A_fnc_addBombRun";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_unlock: RscButton
		{
			idc = 107;
			text = "Unlock Vehicle";
			tooltip = "Allow other groups to mount this vehicle";
			action = "closeDialog 0;[] call A3A_fnc_unlockVehicle";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class veh_query {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Add Vehicle to Squad?";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;vehQuery = nil; if (player == theBoss) then {nul= [] execVM ""Dialogs\squad_recruit.sqf""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "YES";
			action = "closeDialog 0; vehQuery = true";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "NO";
			action = "closeDialog 0; vehQuery = nil";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class squad_manager {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "HC Squad Otions";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 104;
			text = "Squad Add Vehicle";
			tooltip = "Look at some vehicle and assign it to the selected squad for it's use";
			action = "closeDialog 0;[] call A3A_fnc_addSquadVeh;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_MG: RscButton
		{
			idc = 105;
			text = "Squad SITREP";
			tooltip = "If the selected squad is using some vehicle, know remotely it's status";
			action = "[""stats""] call A3A_fnc_vehStats;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 106;
			text = "Mount / Dismount";
			tooltip = "Force squad to mount or dismount their assigned vehicle";
			action = "[""mount""] call A3A_fnc_vehStats";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AA: RscButton
		{
			idc = 107;
			text = "Static Autotarget";
			tooltip = "Use this option on AT / AA mounted squads. The truck driver will try to point his truck's back to any detected enemy";
			action = "closeDialog 0; [] spawn A3A_fnc_staticAutoT";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class AI_management {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Battle Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class 8slots_L1: RscButton
		{
			idc = 104;
			text = "Temp. AI Control";
			tooltip = "Take personal control of the selected squad member or HC squad leader and be able to perform any kind of actions for 60 seconds. Control state will be cancelled if the player or the controlled unit receives any kind of damage";
			action = "closeDialog 0; if ((count groupselectedUnits player > 0) and (count hcSelected player > 0)) exitWith {hint ""You must select from HC or Squad Bars, not both""}; if (count groupselectedUnits player == 1) then {nul = [groupselectedUnits player] execVM ""REINF\controlunit.sqf""}; if (count hcSelected player == 1) then {nul = [hcSelected player] execVM ""REINF\controlHCsquad.sqf"";};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R1: RscButton
		{
			idc = 105;
			text = "Auto Rearm \ Loot";
			tooltip = "AI will search for better weapons, vests, helmets etc. If they are in a vehicle, they will just store what they scavenge in the vehicle. If not, they will equip them";
			action = "closeDialog 0; if (count groupselectedUnits player == 0) then {nul = (units group player) spawn A3A_fnc_rearmCall} else {nul = (groupselectedUnits player) spawn A3A_fnc_rearmCall};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L2: RscButton
		{
			idc = 106;
			text = "Auto Heal";
			tooltip = "AI squad mates will heal proactively each other";
			action = "if (autoHeal) then {autoHeal = false; hint ""Auto Healing disabled"";} else {autoHeal = true; hint ""Auto Heal enabled""; nul = [] spawn A3A_fnc_autoHealFnc}";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R2: RscButton
		{
			idc = 107;
			text = "Squad SITREP";
			tooltip = "Recover info about a HC squad status";
			action = "[""stats""] call A3A_fnc_vehStats;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L3: RscButton
		{
			idc = 108;
			text = "Garrison Units / Squads";
			tooltip = "Adds selected units or squads to a map selected garrison";
			action = "closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\addToGarrison.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\addToGarrison.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R3: RscButton
		{
			idc = 109;
			text = "Squad Add Vehicle";
			tooltip = "Look at some vehicle and assign it to the selected squad for it's use";
			action = "closeDialog 0;[] call A3A_fnc_addSquadVeh;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L4: RscButton
		{
			idc = 110;
			text = "Dismiss Units / Squad";
			tooltip = "Dimiss selected units or squads, recovering it's cost to the proper resource pool";
			action = "closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\dismissPlayerGroup.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\dismissSquad.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R4: RscButton
		{
			idc = 111;
			text = "Mount / Dismount";
			tooltip = "Force squad to mount or dismount their assigned vehicle";
			action = "[""mount""] call A3A_fnc_vehStats";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class commander_comm {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Commander Battle Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class 8slots_L1: RscButton
		{
			idc = 104;
			text = "Recruit Squad";
			tooltip = "Recruit new squads and manage them with the HC Module (CTRL + SPACE)";
			action = "closeDialog 0;if (player == theBoss) then {nul= [] execVM ""Dialogs\squad_recruit.sqf""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R1: RscButton
		{
			idc = 105;
			text = "Air Support";
			tooltip = "Ask for Air Support (uses Airstrike points)";
			action = "closeDialog 0;if (player == theBoss) then {_nul = createDialog ""carpet_bombing""} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L2: RscButton
		{
			idc = 106;
			text = "O.Post - Roadblock";
			tooltip = "Establish a new watchpost or roadblock depending on the type of terrain you select";
			action = "if (player == theBoss) then {closeDialog 0;[""create""] spawn A3A_fnc_puestoDialog} else {hint ""You're not the Commander!""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R2: RscButton
		{
			idc = 107;
			text = "Garbage Clean";
			tooltip = "Cleans several things in game. Use with caution as it freezes the mission";
			action = "if (player == theBoss) then {closedialog 0;[] remoteExec [""A3A_fnc_garbageCleaner"",2]} else {hint ""Only Player Commander has access to this function""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L3: RscButton
		{
			idc = 108;
			text = "O.Post-Roadblock Delete";
			tooltip = "Remove selected observation post or roadblock, money will be refunded";
			action = "if (player == theBoss) then {closeDialog 0; [""delete""] spawn A3A_fnc_puestoDialog} else {hint ""You're not the Commander!""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R3: RscButton
		{
			idc = 109;
			text = "Faction Garage";
			tooltip = "Look at a vehicle and garage it into faction garage (shared among commanders)";
			action = "if (player == theBoss) then {closeDialog 0;nul = [true] call A3A_fnc_garageVehicle;} else {hint ""You're not the Commander!""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_L4: RscButton
		{
			idc = 110;
			text = "Resign / Eligible";
			tooltip = "Step down from commander or toggle eligibility";
			action = "if (isMultiplayer) then {closedialog 0;execVM ""orgPlayers\commResign.sqf""} else {hint ""This feature is MP Only""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 8slots_R4: RscButton
		{
			idc = 111;
			text = "Sell Vehicle";
			tooltip = "Look at a vehicle and sell it for money";
			action = "if (player == theBoss) then {closeDialog 0; nul = [] call A3A_fnc_sellVehicle} else {hint ""Only the Commander can sell vehicles""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class carpet_bombing {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Carpet Bombing Strike";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0; nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "HE Bombs";
			tooltip = "Cost: 1 point";
			action = "closeDialog 0;[""HE""] spawn A3A_fnc_NATObomb;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Carpet Bombing";
			tooltip = "Cost: 1 point";
			action = "closeDialog 0;[""CARPET""] spawn A3A_fnc_NATObomb;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 4slots_L2: RscButton
		{
			idc = 106;
			text = "NAPALM Bomb";
			tooltip = "Cost: 1 point";
			action = "closeDialog 0;[""NAPALM""] spawn A3A_fnc_NATObomb;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class 4slots_R2: RscButton
		{
			idc = 107;
			text = "Add to Air Support";
			tooltip = "Gain Airstrike points giving this aircraft to the faction Air pool";
			action = "closeDialog 0;nul = [] call A3A_fnc_addBombRun";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class dismiss_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Dismiss Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 103;
			text = "Dismiss Units / Squad";
			tooltip = "Dimiss selected units or squads, recovering it's cost to the proper resource pool";
			action = "closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\dismissPlayerGroup.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\dismissSquad.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 104;
			text = "Garrison Units / Squads";
			tooltip = "Adds selected units or squads to a map selected garrison";
			action = "closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\addToGarrison.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\addToGarrison.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class construction_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Small Trench";
			tooltip = "Make a quick small trench for one man";
			action = "closeDialog 0;nul = [""ST""] spawn A3A_fnc_construir;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Medium Trench";
			tooltip = "A mid sized trench with capabilities for more than one soldier";
			action = "closeDialog 0; nul = [""MT""] spawn A3A_fnc_construir;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "Vehicle obstacles";
			tooltip = "Build some obstacles for vehicles";
			action = "closeDialog 0;nul = [""RB""] spawn A3A_fnc_construir;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_unlock: RscButton
		{
			idc = 107;
			text = "Bunker Options";
			tooltip = "Need to be built in garrison controlled zones and cost money";
			action = "closeDialog 0;nul = createDialog ""bunker_menu""";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class bunker_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select Bunker Type";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 103;
			text = "Sandbag Bunker";
			tooltip = "Requires to be in a garrisoned zone. It will be permanent";
			action = "closeDialog 0;nul = [""SB""] spawn A3A_fnc_construir;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 104;
			text = "Concrete Bunker";
			tooltip = "Requires to be in a garrisoned zone. It will be permanent";
			action = "closeDialog 0;nul = [""CB""] spawn A3A_fnc_construir;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class squad_recruit {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Squad Recruitment Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0; _nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_infsquad: RscButton
		{
			idc = 104;
			text = "Recruit Inf. Squad";
			action = "closeDialog 0;[] execVM ""Dialogs\squadOptions.sqf"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_infteam: RscButton
		{
			idc = 105;
			text = "Recruit Inf. Team";
			action = "closeDialog 0;nul = [gruposSDKmid] spawn A3A_fnc_addFIAsquadHC";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_ATteam: RscButton
		{
			idc = 106;
			text = "Recruit AT Team";
			action = "closeDialog 0;nul = [gruposSDKAT] spawn A3A_fnc_addFIAsquadHC";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_sniperTeam: RscButton
		{
			idc = 107;
			text = "Recruit Sniper Team";
			action = "closeDialog 0;nul = [gruposSDKSniper] spawn A3A_fnc_addFIAsquadHC";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_infsquadM: RscButton
		{
			idc = 108;
			text = "Recruit MG Team";
			action = "closeDialog 0;nul = [SDKMGStatic] spawn A3A_fnc_addFIAsquadHC";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_infteamM: RscButton
		{
			idc = 109;
			text = "Recruit AT Car";
			action = "closeDialog 0;nul = [vehSDKAT] spawn A3A_fnc_addFIAsquadHC";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_ATteamM: RscButton
		{
			idc = 110;
			text = "Recruit AA Truck";
			action = "closeDialog 0;nul = [staticAABuenos] spawn A3A_fnc_addFIAsquadHC";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 111;
			text = "Recruit Mortar Team";
			action = "closeDialog 0;nul = [SDKMortar] spawn A3A_fnc_addFIAsquadHC";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class player_money {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Player and Money Interaction";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""radio_comm"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 104;
			text = "Add Server Member";
			tooltip = "Use this option to add the player which you are currently looking to the member's list";
			action = "if (isMultiplayer) then {closeDialog 0;nul = [""add""] call A3A_fnc_memberAdd;} else {hint ""This function is MP only""};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_MG: RscButton
		{
			idc = 105;
			text = "Remove Server Member";
			tooltip = "Use this option to remove the player which you are currently looking to the member's list";
			action = "if (isMultiplayer) then {closeDialog 0;nul = [""remove""] call A3A_fnc_memberAdd;} else {hint ""This function is MP only""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 106;
			text = "Donate 100 € to player";
			action = "[true] call A3A_fnc_donateMoney;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AA: RscButton
		{
			idc = 107;
			text = "Donate 100 € to Faction";
			tooltip = "It will increase your prestige among your faction";
			action = "[] call A3A_fnc_donateMoney;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class garage_sell {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Sell or Garage Vehicle";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""vehicle_manager"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Garage Vehicle";
			action = "closeDialog 0;if (player != theBoss) then {nul = [false] call A3A_fnc_garageVehicle} else {if (isMultiplayer) then {_nul = createDialog ""garage_check""} else {nul = [true] call A3A_fnc_garageVehicle}};";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Sell Vehicle";
			action = "closeDialog 0; if (player == theBoss) then {nul = [] call A3A_fnc_sellVehicle} else {hint ""Only the Commander can sell vehicles""};";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class garage_check {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Personal or Faction Garage?";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""garage_sell"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Personal Garage";
			action = "closeDialog 0;nul = [false] call A3A_fnc_garageVehicle;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Faction Garage";
			action = "closeDialog 0; nul = [true] call A3A_fnc_garageVehicle;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class tu_madre {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Carpet Bombing Strike";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscListBox
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1.2)";
			colorText[] = {1,1,1,1}; // Text and frame color
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
			pictureColor[] = {1,1,1,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {0,1,0,1}; // Disabled picture color
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "HE Bombs";
			tooltip = "Cost: 10 points";
			action = "closeDialog 0;[""HE""] spawn A3A_fnc_NATObomb;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Carpet Bombing";
			tooltip = "Cost: 10 points";
			action = "closeDialog 0;[""CARPET""] spawn A3A_fnc_NATObomb;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "NAPALM Bomb";
			tooltip = "Cost: 10 points";
			action = "closeDialog 0;[""NAPALM""] spawn A3A_fnc_NATObomb;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class mortar_type {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select Mortar Ammo";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "HE";
			action = "closeDialog 0;tipoMuni = SDKMortarHEMag;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Smoke";
			action = "closeDialog 0; tipoMuni = SDKMortarSmokeMag;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class rounds_number {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select No. Rounds to be fired";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.51 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_AS: RscButton
		{
			idc = 104;
			text = "1";
			action = "closeDialog 0;rondas = 1";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_CONV: RscButton
		{
			idc = 105;
			text = "2";
			action = "closeDialog 0;rondas = 2";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_DES: RscButton
		{
			idc = 106;
			text = "3";
			action = "closeDialog 0; rondas = 3";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_LOG: RscButton
		{
			idc = 107;
			text = "4";
			action = "closeDialog 0;rondas = 4";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_RES: RscButton
		{
			idc = 108;
			text = "5";
			action = "closeDialog 0;rondas = 5";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_vehicle: RscButton
		{
			idc = 109;
			text = "6";
			action = "closeDialog 0;rondas = 6";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_fpsplus: RscButton
		{
			idc = 110;
			text = "7";
			action = "closeDialog 0; rondas = 7";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AA: RscButton
		{
			idc = 111;
			text = "8";
			action = "closeDialog 0;rondas = 8";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.62 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class strike_type {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select type of strike";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Single Point Strike";
			action = "closeDialog 0;tipoArty = ""NORMAL"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Barrage Strike";
			action = "closeDialog 0; tipoArty = ""BARRAGE"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class NATO_player {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "SpecOp Menu";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Quadbike";
			action = "closeDialog 0;[] call A3A_fnc_NATOQuadbike";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Fast Travel";
			action = "closeDialog 0;[] spawn A3A_fnc_NATOFT";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class mbt_type {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select type ammo for the strike";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "HE";
			action = "closeDialog 0;tipoMuni = ""32Rnd_155mm_Mo_shells"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Laser Guided";
			action = "closeDialog 0; tipoMuni = ""2Rnd_155mm_Mo_LG"";";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "Smoke";
			action = "closeDialog 0; tipoMuni = ""6Rnd_155mm_Mo_smoke"";";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class squad_options {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Squad Options";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_back: RscButton
		{
			idc = 103;
			text = "Back";
			action = "closeDialog 0;_nul = createDialog ""squad_recruit"";";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 104;
			text = "Normal Squad";
			action = "closeDialog 0;nul = [gruposSDKSquad] spawn A3A_fnc_addFIAsquadHC;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 105;
			text = "Engineer Squad";
			action = "closeDialog 0; nul = [gruposSDKSquadEng] spawn A3A_fnc_addFIAsquadHC;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 106;
			text = "MG Squad";
			action = "closeDialog 0;nul = [gruposSDKSquadSupp,""MG""] spawn A3A_fnc_addFIAsquadHC;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_unlock: RscButton
		{
			idc = 107;
			text = "Mortar Squad";
			action = "closeDialog 0;nul = [gruposSDKSquadSupp,""Mortar""] spawn A3A_fnc_addFIAsquadHC;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class diff_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.25 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Choose difficulty";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.21 * safezoneH;
		};
		class HQ_button_mortar: RscButton
		{
			idc = 103;
			text = "Easy";
			action = "closeDialog 0;skillMult = 0.5";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_MG: RscButton
		{
			idc = 104;
			text = "Normal";
			action = "closeDialog 0;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_AT: RscButton
		{
			idc = 105;
			text = "Hard";
			action = "closeDialog 0; skillMult = 2";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};
class gameMode_menu {
	idd = -1;
	movingenable = false;
	class controls {
		class HQ_BOX: BOX
		{
			idc = 101;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.46 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class HQ_frame: RscFrame
		{
			idc = 102;
			text = "Select your Game Mode";
			x = 0.27 * safezoneW + safezoneX;
			y = 0.24 * safezoneH + safezoneY;
			w = 0.42 * safezoneW;
			h = 0.31 * safezoneH;
		};
		class HQ_button_Gsquad: RscButton
		{
			idc = 103;
			text = "Reb vs Gov vs Inv";
			action = "closeDialog 0;gameMode = 1;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gstatic: RscButton
		{
			idc = 104;
			text = "Rev vs Gov & Inv";
			action = "closeDialog 0;gameMode = 2;";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_Gremove: RscButton
		{
			idc = 105;
			text = "Reb vs Gov";
			action = "closeDialog 0;gameMode = 3;";
			x = 0.29 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
		class HQ_button_offroad: RscButton
		{
			idc = 106;
			text = "Reb vs Inv";
			action = "closeDialog 0;gameMode = 4";
			x = 0.49 * safezoneW + safezoneX;
			y = 0.42 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.056 * safezoneH;
		};
	};
};

class RscTitles {
	class Default {
       idd = -1;
       fadein = 0;
       fadeout = 0;
       duration = 0;
    };
    class H8erHUD {
        idd = 745;
        movingEnable =  0;
        enableSimulation = 1;
        enableDisplay = 1;
        duration     =  10e10;
        fadein       =  0;
        fadeout      =  0;
        name = "H8erHUD";
		onLoad = "with uiNameSpace do { H8erHUD = _this select 0 }";
		class controls {
		    class structuredText {
                access = 0;
                type = 13;
                idc = 1001;
                style = 0x00;
                lineSpacing = 1;
				x = 0.103165 * safezoneW + safezoneX;
				y = 0.007996 * safezoneH + safezoneY;//0.757996
				w = 0.778208 * safezoneW;
				h = 0.0660106 * safezoneH;
                size = 0.055;//0.020
                colorBackground[] = {0,0,0,0};
                colorText[] = {0.34,0.33,0.33,0};//{1,1,1,1}
                text = "";
                font = "PuristaSemiBold";
				class Attributes {
					font = "PuristaSemiBold";
					color = "#C1C0BB";//"#FFFFFF";
					align = "CENTER";
					valign = "top";
					shadow = true;
					shadowColor = "#000000";
					underline = false;
					size = "4";//4
				};
            };
		};
	};
};

