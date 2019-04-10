if (side petros == west) exitWith {call compile preProcessFileLineNumbers "Templates\malosVanillaAltisB.sqf"};

NATOGrunt = "B_Soldier_F";
NATOOfficer = "B_Officer_F";
NATOOfficer2 = "B_G_officer_F";
NATOBodyG = "B_CTRG_Soldier_tna_F";
NATOCrew = "B_Crew_F";
NATOUnarmed = "B_G_Survivor_F";
NATOMarksman = "B_Sharpshooter_F";
staticCrewMalos = ["B_support_MG_F","B_support_GMG_F","B_support_AMG_F","B_support_Mort_F","B_support_AMort_F"];
NATOMG = "B_HMG_01_high_F";
NATOGMG = "B_GMG_01_high_F";
NATORaisedStatics = [NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOGMG,NATOGMG,NATOGMG];
NATOMortar = "B_Mortar_01_F";
staticATmalos = "B_static_AT_F";
staticAAmalos = "B_static_AA_F";
NATOPilot = ["B_Helipilot_F","B_Fighter_Pilot_F","B_helicrew_F"];
vehNATOLightArmed = ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_LSV_01_armed_F","B_LSV_01_AT_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_LT_01_cannon_F","I_LT_01_AT_F"];
vehNATOLightUnarmed = ["B_MRAP_01_F","B_LSV_01_unarmed_F","I_MRAP_03_F","I_LT_01_scout_F"];
vehNATOTrucks = ["B_Truck_01_transport_F","B_Truck_01_covered_F","B_Truck_01_medical_F"];
vehNATOAmmoTruck = ["B_Truck_01_ammo_F"];
vehNATORepairTruck = ["B_Truck_01_repair_F","B_APC_Tracked_01_CRV_F"];
vehNATOLight = vehNATOLightArmed + vehNATOLightUnarmed;
vehNATOAPC = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","I_APC_Wheeled_03_cannon_F"];//"B_T_APC_Tracked_01_CRV_F" has no cargo seats
vehNATOTank = ["B_AFV_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","B_MBT_01_cannon_F","B_MBT_01_TUSK_F"];
vehNATOAA = ["B_APC_Tracked_01_AA_F","I_LT_01_AA_F"];
vehNATOSAM = ["B_Radar_System_01_F","B_SAM_System_03_F"];
vehNATOAttack = vehNATOAPC + vehNATOTank;
vehNATOBoat = "B_Boat_Armed_01_minigun_F";
vehNATORBoat = "B_Boat_Transport_01_F";
vehNATOBoats = [vehNATOBoat,vehNATORBoat,"B_APC_Wheeled_01_cannon_F","I_APC_Wheeled_03_cannon_F"];
vehNATOPlane = ["B_Plane_CAS_01_F"];
vehNATOPlaneAA = ["B_Plane_Fighter_01_F","B_Plane_Fighter_01_Stealth_F"];
vehNATOPatrolHeli = "B_Heli_Light_01_F";
vehNATOTransportHelis = ["B_T_VTOL_01_infantry_F","B_Heli_Transport_03_F",vehNATOPatrolHeli,"B_Heli_Transport_01_camo_F"];
vehNATOAttackHelis = ["B_T_VTOL_01_armed_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F"];
vehNATOAir = vehNATOTransportHelis + vehNATOAttackHelis + vehNATOPlane + vehNATOPlaneAA;
vehNATOUAV = "B_UAV_02_F";
vehNATOUAVSmall = "B_UAV_01_F";
vehNATOMRLS = ["B_MBT_01_arty_F","B_MBT_01_mlrs_F"];
vehNATOMRLSMags = "32Rnd_155mm_Mo_shells";
vehNATONormal = vehNATOLight + vehNATOTrucks + vehNATOAmmoTruck + vehNATORepairTruck + ["B_Truck_01_fuel_F","B_Truck_01_box_F","B_Truck_01_mover_F"];
vehNATOBike = "B_Quadbike_01_F";
NATOFlag = "Flag_NATO_F";
NATOFlagTexture = "\A3\Data_F\Flags\Flag_NATO_CO.paa";
NATOAmmobox = "B_supplyCrate_F";
//cfgNATOInf = (configfile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry");///
gruposNATOSentry = ["B_soldier_GL_F",NATOGrunt];//"B_T_InfSentry";//
gruposNATOSniper = ["B_sniper_F","B_spotter_F"];
gruposNATOsmall = [gruposNATOSentry,gruposNATOSniper,["B_recon_JTAC_F","B_recon_F"]];
gruposNATOAA = ["B_Soldier_TL_F","B_soldier_AA_F","B_soldier_AA_F","B_soldier_AAA_F"];
gruposNATOAT = ["B_soldier_TL_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AAT_F"];
gruposNATOmid = [["B_soldier_TL_F","B_soldier_AR_F","B_soldier_GL_F","B_soldier_LAT_F"],gruposNATOAA,gruposNATOAT];
NATOSquad = ["B_soldier_SL_F",NATOGrunt,"B_soldier_LAT_F",NATOMarksman,"B_soldier_TL_F","B_soldier_AR_F","B_soldier_LAT2_F","B_medic_F"];//"B_T_InfSquad";
NATOSpecOp = ["B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_Medic_tna_F",NATOBodyG,"B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_AR_tna_F"];//(configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfSquad");
factionMachoMalos = "BLU_CTRG_F";
gruposNATOSquad = [
    NATOSquad,
    ["B_soldier_SL_F","B_soldier_TL_F","B_soldier_AR_F","B_Soldier_A_F","B_soldier_LAT2_F","B_medic_F","B_support_Mort_F","B_support_AMort_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_HeavyGunner_F","B_Soldier_A_F","B_medic_F","B_support_MG_F","B_support_AMG_F","B_soldier_AAR_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_HeavyGunner_F","B_medic_F","B_soldier_LAT2_F","B_support_GMG_F","B_support_AMG_F","B_soldier_AAR_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_soldier_AR_F","B_Soldier_A_F","B_medic_F","B_soldier_LAT2_F","B_soldier_AA_F","B_soldier_AAA_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_Soldier_A_F","B_medic_F","B_soldier_LAT2_F","B_soldier_LAT_F","B_soldier_AT_F","B_soldier_AAT_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_soldier_AR_F",NATOMarksman,"B_medic_F","B_soldier_LAT2_F","B_engineer_F","B_engineer_F"],
    ["B_soldier_SL_F","B_soldier_TL_F","B_soldier_AR_F","B_Soldier_A_F","B_medic_F","B_soldier_LAT2_F","B_soldier_UAV_F",NATOMarksman],
    ["B_soldier_SL_F","B_soldier_TL_F","B_soldier_AR_F","B_Soldier_A_F","B_medic_F","B_soldier_UAV_06_medical_F","B_soldier_UAV_06_F",NATOMarksman]

];

NATOStaticBackpacks = [
    [
        [
            "B_AT_01_weapon_F",
            "B_AA_01_weapon_F",
            "B_HMG_01_weapon_F",
            "B_GMG_01_weapon_F",
            "B_HMG_01_A_weapon_F",
            "B_GMG_01_A_weapon_F"
        ],
        "B_HMG_01_support_F"
    ],[
        [
            "B_HMG_01_high_weapon_F",
            "B_GMG_01_high_weapon_F"
        ],
        "B_HMG_01_support_high_F"
    ],[
        ["B_Mortar_01_weapon_F"],
        "B_Mortar_01_support_F"
    ]
];

NATOUAVBackpacks = [
    "B_UAV_01_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "B_UAV_06_backpack_F",
    "B_Static_Designator_01_weapon_F"
];

NATOBackpacks = [
    [
        "B_Carryall_mcamo",
        "B_Carryall_oli",
        "B_Carryall_khk"
    ],[
        "B_Bergen_mcamo_F"
    ]
];

soporteStaticNATOB = "B_HMG_01_support_F";
ATStaticNATOB = "B_AT_01_weapon_F";
MGStaticNATOB = "B_HMG_01_high_weapon_F";
//B_GMG_01_high_weapon_F
soporteStaticNATOB2 = "B_HMG_01_support_high_F";
AAStaticNATOB = "B_AA_01_weapon_F";
MortStaticNATOB = "B_Mortar_01_weapon_F";
soporteStaticNATOB3 = "B_Mortar_01_support_F";

armasNATO append [
    "SMG_01_F",
    "SMG_03_TR_black",
    "SMG_03_TR_khaki",
    "SMG_03C_TR_black",
    "SMG_03C_TR_khaki",
    "SMG_03_black",
    "SMG_03_khaki",
    "SMG_03C_black",
    "SMG_03C_khaki",
    "arifle_SDAR_F",
    "arifle_SPAR_01_blk_F",
    "arifle_SPAR_01_snd_F",
    "arifle_SPAR_02_blk_F",
    "arifle_SPAR_02_snd_F",
    "arifle_MX_F",
    "arifle_MX_Black_F",
    "arifle_MX_GL_F",
    "arifle_MX_GL_Black_F",
    "arifle_MX_SW_F",
    "arifle_MX_SW_Black_F",
    "arifle_MXC_F",
    "arifle_MXC_Black_F",
    "arifle_MXM_F",
    "arifle_MXM_Black_F",
    "srifle_DMR_02_F",
    "srifle_DMR_02_sniper_F",
    "srifle_DMR_03_F",
    "srifle_DMR_03_tan_F",
    "srifle_EBR_F",
    "arifle_SPAR_03_blk_F",
    "arifle_SPAR_03_snd_F",
    "MMG_02_black_F",
    "MMG_02_sand_F",
    "srifle_LRR_F",
    "srifle_LRR_camo_F",
    "launch_MRAWS_sand_F",
    "launch_MRAWS_sand_rail_F"
];//possible weapons that spawn in NATO ammoboxes
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

guidedLaunchersNATO = ["launch_B_Titan_F", "launch_B_Titan_short_F", "launch_NLAW_F"];
guidedLauncherMunitionsNATO = ["Titan_AT", "Titan_AP", "Titan_AA","NLAW_F"];
flagNATOmrk = "flag_NATO";
nameMalos = "NATO";
if (isServer) then {"NATO_carrier" setMarkerText "NATO Carrier"};