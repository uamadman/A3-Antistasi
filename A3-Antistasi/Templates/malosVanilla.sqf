if (worldName == "Altis") exitWith {call compile preProcessFileLineNumbers "Templates\malosVanillaAltis.sqf"};

NATOGrunt = "B_T_Soldier_F";
NATOOfficer = "B_T_Officer_F";
NATOOfficer2 = "B_G_officer_F";
NATOBodyG = "B_CTRG_Soldier_tna_F";
NATOCrew = "B_T_Crew_F";
NATOUnarmed = "B_G_Survivor_F";
NATOMarksman = "B_T_Soldier_M_F";
staticCrewMalos = ["B_T_support_MG_F","B_T_Support_GMG_F","B_T_Support_AMG_F","B_T_Support_Mort_F","B_T_Support_AMort_F"];
NATOMG = "B_HMG_01_high_F";
NATOMortar = "B_T_Mortar_01_F";
staticATmalos = "B_T_static_AT_F";
staticAAmalos = "B_T_Static_AA_F";
NATOPilot = ["B_T_Helipilot_F","B_T_Pilot_F","B_T_Helicrew_F"];
vehNATOLightArmed = ["B_T_MRAP_01_hmg_F","B_T_MRAP_01_gmg_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_LT_01_cannon_F","I_LT_01_AT_F"];
vehNATOLightUnarmed = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F","I_MRAP_03_F","I_LT_01_scout_F"];
vehNATOTrucks = ["B_T_Truck_01_transport_F","B_T_Truck_01_covered_F","B_T_Truck_01_medical_F"];
vehNATOAmmoTruck = ["B_T_Truck_01_ammo_F"];
vehNATORepairTruck = ["B_T_Truck_01_repair_F","B_T_APC_Tracked_01_CRV_F"];
vehNATOLight = vehNATOLightArmed + vehNATOLightUnarmed;
vehNATOAPC = ["B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F","I_APC_Wheeled_03_cannon_F"];//"B_T_APC_Tracked_01_CRV_F" has no cargo seats
vehNATOTank = ["B_T_AFV_Wheeled_01_cannon_F","B_T_AFV_Wheeled_01_up_cannon_F","B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F"];
vehNATOAA = ["B_T_APC_Tracked_01_AA_F","I_LT_01_AA_F"];
vehNATOAttack = vehNATOAPC + vehNATOTank;
vehNATOBoat = "B_T_Boat_Armed_01_minigun_F";
vehNATORBoat = "B_T_Boat_Transport_01_F";
vehNATOBoats = [vehNATOBoat,vehNATORBoat,"B_T_APC_Wheeled_01_cannon_F"];
vehNATOPlane = ["B_Plane_CAS_01_F"];
vehNATOPlaneAA = ["B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F"];
vehNATOPatrolHeli = "B_Heli_Light_01_F";
vehNATOTransportHelis = ["B_T_VTOL_01_infantry_F","B_Heli_Transport_03_F",vehNATOPatrolHeli,"B_Heli_Transport_01_camo_F"];
vehNATOAttackHelis = ["B_T_VTOL_01_armed_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F"];
vehNATOAir = vehNATOTransportHelis + vehNATOAttackHelis + vehNATOPlane + vehNATOPlaneAA;
vehNATOUAV = "B_UAV_02_F";
vehNATOUAVSmall = "B_UAV_01_F";
vehNATOMRLS = ["B_T_MBT_01_arty_F","B_T_MBT_01_mlrs_F"];
vehNATOMRLSMags = "32Rnd_155mm_Mo_shells";
vehNATONormal = vehNATOLight + vehNATOTrucks + vehNATORepairTruck + vehNATOAmmoTruck + ["B_T_Truck_01_fuel_F","B_T_Truck_01_box_F","B_T_Truck_01_mover_F"];
vehNATOBike = "B_T_Quadbike_01_F";
NATOFlag = "Flag_NATO_F";
NATOFlagTexture = "\A3\Data_F\Flags\Flag_NATO_CO.paa";
NATOAmmobox = "B_supplyCrate_F";
//cfgNATOInf = (configfile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry");///
gruposNATOSentry = ["B_T_soldier_GL_F",NATOGrunt];//"B_T_InfSentry";//
gruposNATOSniper = ["B_T_sniper_F","B_T_spotter_F"];
gruposNATOsmall = [gruposNATOSentry,gruposNATOSniper,["B_T_recon_M_F","B_T_recon_F"]]; //[gruposNATOSentry,"B_T_SniperTeam","B_T_ReconSentry"];///
gruposNATOAA = ["B_T_soldier_TL_F","B_T_soldier_AA_F","B_T_soldier_AA_F","B_T_soldier_AAA_F"];
gruposNATOAT = ["B_T_soldier_TL_F","B_T_soldier_AT_F","B_T_soldier_AT_F","B_T_soldier_AAT_F"];
gruposNATOmid = [["B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_GL_F","B_T_soldier_LAT_F"],gruposNATOAA,gruposNATOAT];//["B_T_InfTeam","B_T_InfTeam_AA","B_T_InfTeam_AT"];///
NATOSquad = ["B_T_soldier_SL_F",NATOGrunt,"B_T_soldier_LAT_F",NATOMarksman,"B_T_soldier_TL_F","B_T_soldier_AR_F","B_T_soldier_LAT2_F","B_T_medic_F"];
NATOSpecOp = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F",NATOBodyG,"B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_AR_tna_F"];
gruposNATOSquad = [
    NATOSquad,
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_soldier_A_F","B_T_soldier_LAT_F","B_T_Support_Mort_F","B_T_Support_AMort_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_Soldier_A_F","B_T_support_MG_F","B_T_support_AMG_F","B_T_soldier_AAR_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_Soldier_A_F","B_T_Support_GMG_F","B_T_support_AMG_F","B_T_soldier_AAR_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_soldier_A_F","B_T_soldier_LAT2_F","B_T_soldier_AA_F","B_T_soldier_AAA_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_A_F","B_T_soldier_LAT2_F","B_T_soldier_LAT_F","B_T_soldier_AT_F","B_T_soldier_AAT_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F",NATOMarksman,"B_T_engineer_F","B_T_engineer_F","B_T_soldier_LAT2_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_Soldier_A_F",NATOMarksman,"B_T_soldier_LAT2_F","B_T_Soldier_UAV_F"],
    ["B_T_soldier_SL_F","B_T_soldier_TL_F","B_T_medic_F","B_T_soldier_AR_F","B_T_Soldier_A_F",NATOMarksman,"B_T_soldier_UAV_06_medical_F","B_T_soldier_UAV_06_F"]
]; //[NATOSquad,"B_T_InfSquad_Weapons"];///
factionMachoMalos = "BLU_CTRG_F";

NATOStaticBackpacks = [
    [
        [
            "B_AT_01_weapon_F",
            "B_AA_01_weapon_F",
            "B_HMG_01_Weapon_grn_F",
            "B_GMG_01_Weapon_grn_F",
            "B_HMG_01_A_weapon_F",
            "B_GMG_01_A_weapon_F"
        ],
        "B_HMG_01_support_grn_F"
    ],[
        [
            "B_HMG_01_high_weapon_F",
            "B_GMG_01_high_weapon_F"
        ],
        "B_HMG_01_support_high_F"
    ],[
        ["B_Mortar_01_Weapon_grn_F"],
        "B_Mortar_01_support_grn_F"
    ]
];

NATOUAVBackpacks = [
    "B_UAV_01_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "B_UAV_06_backpack_F",
    "B_Static_Designator_01_weapon_F"
];

NATOBackpacks = [[
        "B_Carryall_oli",
        "B_Carryall_khk"
    ],[
        "B_Bergen_tna_F"
    ]
];

soporteStaticNATOB = "B_HMG_01_support_grn_F";
ATStaticNATOB = "B_AT_01_weapon_F";
MGStaticNATOB = "B_HMG_01_Weapon_grn_F";
soporteStaticNATOB2 = "B_HMG_01_support_high_F";
AAStaticNATOB = "B_AA_01_weapon_F";
MortStaticNATOB = "B_Mortar_01_Weapon_grn_F";
soporteStaticNATOB3 = "B_Mortar_01_support_grn_F";

armasNATO append [
    "SMG_01_F",
    "SMG_03_TR_black",
    "SMG_03_TR_camo",
    "SMG_03C_TR_black",
    "SMG_03C_TR_camo",
    "SMG_03_black",
    "SMG_03_camo",
    "SMG_03C_black",
    "SMG_03C_camo",
    "arifle_SDAR_F",
    "arifle_SPAR_01_blk_F",
    "arifle_SPAR_01_khk_F",
    "arifle_SPAR_02_blk_F",
    "arifle_SPAR_02_khk_F",
    "arifle_MX_khk_F",
    "arifle_MX_Black_F",
    "arifle_MX_GL_khk_F",
    "arifle_MX_GL_Black_F",
    "arifle_MX_SW_khk_F",
    "arifle_MX_SW_Black_F",
    "arifle_MXM_khk_F",
    "arifle_MXM_Black_F",
    "srifle_DMR_02_F",
    "srifle_DMR_02_camo_F",
    "srifle_DMR_03_F",
    "srifle_DMR_03_khaki_F",
    "srifle_EBR_F",
    "arifle_SPAR_03_blk_F",
    "arifle_SPAR_03_khk_F",
    "MMG_02_black_F",
    "MMG_02_camo_F",
    "srifle_LRR_F",
    "srifle_LRR_tna_F",
    "launch_MRAWS_green_F",
    "launch_MRAWS_green_rail_F"
];
//possible weapons that spawn in NATO ammoboxes
municionNATO append [
    "HandGrenade",
    "UGL_FlareWhite_F",
    "UGL_FlareGreen_F",
    "1Rnd_Smoke_Grenade_shell",
    "1Rnd_HE_Grenade_shell",
    "3Rnd_HE_Grenade_shell",
    "50Rnd_570x28_SMG_03",
    "11Rnd_45ACP_Mag",
    "30Rnd_45ACP_Mag_SMG_01",
    "30Rnd_45ACP_Mag_SMG_01_tracer_green",
    "20Rnd_556x45_UW_mag",
    "30Rnd_556x45_Stanag",
    "30Rnd_556x45_Stanag_Tracer_Yellow",
    "30Rnd_556x45_Stanag_red",
    "150Rnd_556x45_Drum_Mag_F",
    "150Rnd_556x45_Drum_Mag_Tracer_F",
    "30Rnd_65x39_Caseless_mag",
    "30Rnd_65x39_caseless_mag_Tracer",
    "100Rnd_65x39_Caseless_mag",
    "100Rnd_65x39_caseless_mag_Tracer",
    "20Rnd_762x51_Mag",
    "10Rnd_338_Mag",
    "130Rnd_338_Mag",
    "7Rnd_408_Mag",
    "MRAWS_HEAT_F",
    "MRAWS_HE_F"
];//possible ammo that spawn in NATO ammoboxes
guidedLaunchersNATO = ["launch_B_Titan_tna_F","launch_B_Titan_short_tna_F","launch_NLAW_F"];
guidedLauncherMunitionsNATO = ["Titan_AT", "Titan_AP", "Titan_AA","NLAW_F"];
flagNATOmrk = "flag_NATO";

nameMalos = "NATO";
if (isServer) then {"NATO_carrier" setMarkerText "NATO Carrier"};