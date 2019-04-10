if (worldName == "Altis") exitWith {call compile preProcessFileLineNumbers "Templates\muyMalosVanillaAltis.sqf"};

CSATGrunt = "O_T_Soldier_F";
CSATOfficer = "O_T_Officer_F";
CSATBodyG = "O_V_Soldier_ghex_F";
CSATCrew = "O_T_Crew_F";
CSATMarksman = "O_T_Soldier_M_F";
staticCrewMuyMalos = "O_T_support_MG_F";
staticCrewMuyMalos = ["O_T_support_MG_F","O_T_support_GMG_F","O_T_support_AMG_F","O_T_support_Mort_F","O_T_support_AMort_F"];
CSATPilot = ["O_T_Pilot_F","O_T_helicrew_F","O_T_Helipilot_F"];

CSATMortar = "O_Mortar_01_F";
CSATMG = "O_HMG_01_high_F";
staticATmuyMalos = "O_static_AT_F";
staticAAmuyMalos = "O_static_AA_F";

vehCSATLightArmed = ["O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F","O_T_LSV_02_AT_F"];
vehCSATLightUnarmed = ["O_T_MRAP_02_ghex_F","O_T_LSV_02_unarmed_F"];
vehCSATTrucks = ["O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F","O_T_Truck_03_medical_ghex_F"];
vehCSATAmmoTruck = ["O_T_Truck_03_ammo_ghex_F"];
vehCSATLight = vehCSATLightArmed + vehCSATLightUnarmed;
vehCSATAPC = ["O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F"];
vehCSATTank = ["O_T_MBT_02_cannon_ghex_F","O_T_MBT_04_cannon_F","O_T_MBT_04_command_F"];
vehCSATAA = ["O_T_APC_Tracked_02_AA_ghex_F"];
vehCSATAttack = vehCSATAPC + vehCSATTank;
vehCSATBoat = "O_T_Boat_Armed_01_hmg_F";
vehCSATRBoat = "O_T_Boat_Transport_01_F";
vehCSATBoats = [vehCSATBoat,vehCSATRBoat,"O_T_APC_Wheeled_02_rcws_ghex_F"];
vehCSATPlane = ["O_Plane_CAS_02_F","I_Plane_Fighter_03_dynamicLoadout_F"];
vehCSATPlaneAA = ["O_Plane_Fighter_02_F"];
vehCSATPatrolHeli = "O_Heli_Light_02_unarmed_F";
vehCSATTransportHelis = ["O_T_VTOL_02_infantry_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F",vehCSATPatrolHeli];
vehCSATAttackHelis = ["O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_F","O_Heli_Light_02_dynamicLoadout_F"];
vehCSATAir = vehCSATTransportHelis + vehCSATAttackHelis + vehCSATPlane + vehCSATPlaneAA;
vehCSATUAV = "O_UAV_02_F";
vehCSATUAVSmall = "O_UAV_01_F";
vehCSATMRLS = ["O_T_MBT_02_arty_ghex_F"];
vehCSATMRLSMags = "32Rnd_155mm_Mo_shells";
vehCSATNormal = vehCSATLight + vehCSATTrucks + vehCSATAmmoTruck + ["O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_repair_ghex_F"];
vehCSATBike = "O_T_Quadbike_01_ghex_F";

CSATFlag = "Flag_CSAT_F";
CSATFlagTexture = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
CSATAmmoBox = "O_supplyCrate_F";
//cfgCSATInf = (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry");
gruposCSATSentry = ["O_T_soldier_GL_F","O_T_soldier_F"];///"O_T_InfSentry";///
gruposCSATSniper = ["O_T_sniper_F","O_T_spotter_F"];
gruposCSATsmall = [gruposCSATSentry,["O_T_recon_M_F","O_T_recon_F"],gruposCSATSniper];///[gruposCSATSentry,"O_T_reconSentry","O_T_SniperTeam"];///
gruposCSATAA = ["O_T_soldier_TL_F","O_T_soldier_AA_F","O_T_soldier_AA_F","O_T_soldier_AAA_F"];
gruposCSATAT = ["O_T_soldier_TL_F","O_T_soldier_AT_F","O_T_soldier_AT_F","O_T_soldier_AAT_F"];
gruposCSATmid = [
    ["O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_GL_F","O_T_soldier_LAT_F"],
    gruposCSATAA,
    gruposCSATAT
];///["O_T_InfTeam","O_T_InfTeam_AA","O_T_InfTeam_AT"];///
CSATSquad = ["O_T_soldier_SL_F","O_T_soldier_F","O_T_soldier_LAT_F","O_T_soldier_M_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F"];///"O_T_InfSquad";///
CSATSpecOp = ["O_V_Soldier_TL_ghex_F","O_V_Soldier_JTAC_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_Medic_ghex_F"];///(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "SpecOps" >> "O_T_ViperTeam");///
factionMachoMuyMalos = "OPF_V_F";
gruposCSATSquad = [
    CSATSquad,
    ["O_T_soldier_SL_F","O_T_soldier_AR_F" ,"O_T_soldier_TL_F","O_T_soldier_M_F","O_T_soldier_AT_F","O_T_soldier_AAT_F","O_T_soldier_A_F","O_T_medic_F"],
    ["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F","O_T_Support_Mort_F","O_T_Support_AMort_F"],
    ["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F","O_T_Support_MG_F","O_T_Support_AMG_F"],
    ["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F","O_T_soldier_AA_F","O_T_soldier_AAA_F"],
    ["O_T_soldier_SL_F","O_T_soldier_LAT_F","O_T_soldier_TL_F","O_T_soldier_AR_F","O_T_soldier_A_F","O_T_medic_F","O_T_Engineer_F","O_T_Engineer_F"]
];//[CSATSquad,"O_T_InfSquad_Weapons"];///"O_T_Engineer_F"

CSATStaticBackpacks = [
    [
        [
            "O_AT_01_weapon_F",
            "O_AA_01_weapon_F",
            "O_HMG_01_weapon_F",
            "O_GMG_01_weapon_F",
            "O_HMG_01_A_weapon_F",
            "O_GMG_01_A_weapon_F"
        ],
        "O_HMG_01_support_F"
    ],[
        [
            "O_HMG_01_high_weapon_F",
            "O_GMG_01_high_weapon_F"
        ],
        "O_HMG_01_support_high_F"
    ],[
        ["O_Mortar_01_weapon_F"],
        "O_Mortar_01_support_F"
    ]
];

CSATUAVBackpacks = [
    "O_UAV_01_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "O_UAV_06_backpack_F",
    "O_Static_Designator_02_weapon_F"
];

CSATBackpacks = [[
        "B_Carryall_ghex_F",
        "B_Carryall_oucamo"
    ],[
        "B_Bergen_tna_F"
    ],[
        "B_ViperHarness_oli_F",
        "B_ViperHarness_ghex_F",
        "B_ViperHarness_khk_F"
    ],[
        "B_ViperLightHarness_oli_F",
        "B_ViperLightHarness_ghex_F",
        "B_ViperLightHarness_khk_F"
    ]
];

soporteStaticCSATB = "O_HMG_01_support_F";
ATStaticCSATB = "O_AT_01_weapon_F";
MGStaticCSATB = "O_HMG_01_weapon_F";
soporteStaticCSATB2 = "O_HMG_01_support_high_F";
AAStaticCSATB = "O_AA_01_weapon_F";
MortStaticCSATB = "O_Mortar_01_weapon_F";
soporteStaticCSATB3 = "O_Mortar_01_support_F";

armasCSAT append [
    "hgun_Pistol_heavy_02_F",
    "SMG_02_F",
    "SMG_03_TR_black",
    "SMG_03C_TR_black",
    "SMG_03_black",
    "SMG_03C_black",
    "SMG_03_TR_hex",
    "SMG_03C_TR_hex",
    "SMG_03_hex",
    "SMG_03C_hex",
    "arifle_SDAR_F",
    "arifle_CTAR_blk_F",
    "arifle_CTAR_ghex_F",
    "arifle_CTAR_GL_blk_F",
    "arifle_CTAR_GL_ghex_F",
    "arifle_CTARS_blk_F",
    "arifle_CTARS_ghex_F",
    "arifle_Katiba_C_F",
    "arifle_Katiba_F",
    "arifle_Katiba_GL_F",
    "arifle_ARX_blk_F",
    "arifle_ARX_ghex_F",
    "srifle_DMR_04_F",
    "srifle_DMR_05_blk_F",
    "srifle_DMR_07_blk_F",
    "srifle_DMR_07_ghex_F",
    "srifle_GM6_ghex_F",
    "MMG_01_tan_F", //between hex and tan, tan is prob closer for jungle
    "launch_RPG32_ghex_F"
];

municionCSAT append [
    "HandGrenade",
    "UGL_FlareWhite_F",
    "UGL_FlareGreen_F",
    "1Rnd_Smoke_Grenade_shell",
    "1Rnd_HE_Grenade_shell",
    "50Rnd_570x28_SMG_03",
    "30Rnd_9x21_Mag",
    "30Rnd_9x21_Mag_SMG_02",
    "30Rnd_9x21_Mag_SMG_02_Tracer_Red",
    "6Rnd_45ACP_Cylinder",
    "20Rnd_556x45_UW_mag",
    "30Rnd_556x45_Stanag",
    "30Rnd_580x42_Mag_F",
    "30Rnd_580x42_Mag_Tracer_F",
    "100Rnd_580x42_Mag_F",
    "100Rnd_580x42_Mag_Tracer_F",
    "30Rnd_65x39_caseless_green",
    "30Rnd_65x39_caseless_green_mag_Tracer",
    "20Rnd_650x39_Cased_Mag_F",
    "10Rnd_93x64_DMR_05_Mag",
    "150Rnd_93x64_Mag",
    "10Rnd_127x54_Mag",
    "10Rnd_50BW_Mag_F",
    "5Rnd_127x108_Mag",
    "5Rnd_127x108_APDS_Mag",
    "RPG32_F",
    "RPG32_HE_F"
];
guidedLaunchersCSAT = ["launch_O_Titan_ghex_F","launch_O_Titan_short_ghex_F","launch_O_Vorona_green_F"];
guidedLauncherMunitionsCSAT = ["Titan_AT", "Titan_AP", "Titan_AA","Vorona_HEAT","Vorona_HE"];

flagCSATmrk = "flag_CSAT";
nameMuyMalos = "CSAT";
if (isServer) then {"CSAT_carrier" setMarkerText "CSAT Carrier"};