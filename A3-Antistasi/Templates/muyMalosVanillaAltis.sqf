CSATGrunt = "O_Soldier_F";
CSATOfficer = "O_Officer_F";
CSATBodyG = "O_V_Soldier_hex_F";
CSATCrew = "O_Crew_F";
CSATMarksman = "O_Soldier_M_F";
staticCrewMuyMalos = ["O_support_MG_F","O_support_GMG_F","O_support_AMG_F","O_support_Mort_F","O_support_AMort_F"];
CSATPilot = ["O_Pilot_F","O_helipilot_F","O_helicrew_F","O_Fighter_Pilot_F"];

CSATMortar = "O_Mortar_01_F";
CSATMG = "O_HMG_01_high_F";
CSATGMG = "O_GMG_01_high_F";
CSATRaisedStatics = [CSATMG,CSATMG,CSATMG,CSATMG,CSATMG,CSATMG,CSATMG,CSATGMG,CSATGMG,CSATGMG];
staticATmuyMalos = "O_static_AT_F";
staticAAmuyMalos = "O_static_AA_F";

vehCSATLightArmed = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_LSV_02_armed_F","O_LSV_02_AT_F"];
vehCSATLightUnarmed = ["O_MRAP_02_F","O_LSV_02_unarmed_F"];
vehCSATTrucks = ["O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_02_covered_F","O_Truck_02_transport_F","O_Truck_03_medical_F","O_Truck_02_medical_F"];
vehCSATAmmoTruck = ["O_Truck_03_ammo_F","O_Truck_02_Ammo_F"];
vehCSATLight = vehCSATLightArmed + vehCSATLightUnarmed;
vehCSATAPC = ["O_APC_Wheeled_02_rcws_v2_F","O_APC_Tracked_02_cannon_F"];
vehCSATTank = ["O_MBT_02_cannon_F","O_MBT_04_cannon_F","O_MBT_04_command_F"];
vehCSATAA = ["O_APC_Tracked_02_AA_F"];
vehCSATSAM = ["O_Radar_System_02_F","O_SAM_System_04_F"];
vehCSATAttack = vehCSATAPC + vehCSATTank;
vehCSATBoat = "O_Boat_Armed_01_hmg_F";
vehCSATRBoat = "O_Boat_Transport_01_F";
vehCSATBoats = [vehCSATBoat,vehCSATRBoat,"O_APC_Wheeled_02_rcws_v2_F"];
vehCSATPlane = ["O_Plane_CAS_02_dynamicLoadout_F","I_Plane_Fighter_03_dynamicLoadout_F"];
vehCSATPlaneAA = ["O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"];
vehCSATPatrolHeli = "O_Heli_Light_02_unarmed_F";
vehCSATTransportHelis = ["O_T_VTOL_02_infantry_hex_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F",vehCSATPatrolHeli]; //VTOL isn't available without APEX nor there is a replacement, i'd leave it there regardles it's Altis
vehCSATAttackHelis = ["O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_F","O_Heli_Light_02_dynamicLoadout_F"];
vehCSATAir = vehCSATTransportHelis + vehCSATAttackHelis + vehCSATPlane + vehCSATPlaneAA;
vehCSATUAV = "O_UAV_02_F";
vehCSATUAVSmall = "O_UAV_01_F";
vehCSATMRLS = ["O_MBT_02_arty_F","I_Truck_02_MRL_F"];
vehCSATMRLSMags = "32Rnd_155mm_Mo_shells"; // I HOPE THEY ARE THE SAME!
vehCSATNormal = vehCSATLight + vehCSATTrucks + vehCSATAmmoTruck + ["O_Truck_02_fuel_F","O_Truck_03_fuel_F","O_Truck_03_repair_F","O_Truck_02_box_F"];


vehCSATBike = "O_Quadbike_01_F";

CSATFlag = "Flag_CSAT_F";
CSATFlagTexture = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
CSATAmmoBox = "O_supplyCrate_F";
gruposCSATSentry = ["O_soldier_GL_F","O_soldier_F"];
gruposCSATSniper = ["O_sniper_F","O_spotter_F"];
gruposCSATsmall = [gruposCSATSentry,["O_recon_M_F","O_recon_F"],gruposCSATSniper];
gruposCSATAA = ["O_soldier_TL_F","O_soldier_AA_F","O_soldier_AA_F","O_soldier_AAA_F"];
gruposCSATAT = ["O_soldier_TL_F","O_soldier_AT_F","O_Soldier_HAT_F","O_soldier_AAT_F"];
gruposCSATmid = [
    ["O_soldier_TL_F","O_soldier_AR_F","O_soldier_GL_F","O_soldier_LAT_F"],
    gruposCSATAA,
    gruposCSATAT
];
CSATSquad = ["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F"];
CSATSpecOp = ["O_V_Soldier_TL_hex_F","O_V_Soldier_JTAC_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_Medic_hex_F"];
factionMachoMuyMalos = "OPF_V_F";
gruposCSATSquad = [
    CSATSquad,
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_A_F" ,"O_soldier_TL_F","O_soldier_AT_F","O_soldier_AAT_F","O_Soldier_HAT_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_Support_Mort_F","O_Support_AMort_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_Support_MG_F","O_Support_AMG_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_support_GMG_F","O_Support_AMG_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_soldier_AA_F","O_soldier_AAA_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_engineer_F","O_engineer_F"],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_soldier_UAV_F",CSATMarksman],
    ["O_soldier_SL_F","O_soldier_LAT_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_soldier_UAV_06_medical_F","O_T_soldier_UAV_06_F"]
];

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
        "B_Carryall_ocamo",
        "B_Carryall_oucamo",
        "B_Carryall_cbr"
    ],[
        "B_Bergen_hex_F"
    ],[
        "B_ViperHarness_blk_F",
        "B_ViperHarness_hex_F"
    ],[
        "B_ViperLightHarness_blk_F",
        "B_ViperLightHarness_hex_F"
    ]
];

soporteStaticCSATB = "O_HMG_01_support_F";
ATStaticCSATB = "O_AT_01_weapon_F";
MGStaticCSATB = "O_HMG_01_high_weapon_F";
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
    "arifle_CTAR_hex_F",
    "arifle_CTAR_GL_hex_F",
    "arifle_CTARS_hex_F",
    "arifle_Katiba_C_F",
    "arifle_Katiba_F",
    "arifle_Katiba_GL_F",
    "arifle_ARX_hex_F",
    "srifle_DMR_01_F",
    "srifle_DMR_04_F",
    "srifle_DMR_04_Tan_F",
    "srifle_DMR_05_blk_F",
    "srifle_DMR_05_hex_F",
    "srifle_DMR_05_tan_f",
    "srifle_DMR_07_blk_F",
    "srifle_DMR_07_hex_F",
    "srifle_GM6_camo_F",
    "LMG_Zafir_F",
    "MMG_01_hex_F",
    "launch_RPG32_F"
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
    "10Rnd_762x54_Mag",
    "150Rnd_762x54_Box",
    "150Rnd_762x54_Box_Tracer",
    "10Rnd_93x64_DMR_05_Mag",
    "150Rnd_93x64_Mag",
    "10Rnd_127x54_Mag",
    "10Rnd_50BW_Mag_F",
    "5Rnd_127x108_Mag",
    "5Rnd_127x108_APDS_Mag",
    "RPG32_F",
    "RPG32_HE_F"
];
guidedLaunchersCSAT = ["launch_O_Titan_F","launch_O_Titan_short_F","launch_O_Vorona_brown_F"];
guidedLauncherMunitionsCSAT = ["Titan_AT", "Titan_AP", "Titan_AA","Vorona_HEAT","Vorona_HE"];

flagCSATmrk = "flag_CSAT";
nameMuyMalos = "CSAT";
if (isServer) then {"CSAT_carrier" setMarkerText "CSAT Carrier"};
