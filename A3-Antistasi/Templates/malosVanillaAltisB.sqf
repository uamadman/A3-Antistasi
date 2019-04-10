NATOGrunt = "I_Soldier_F";
NATOOfficer = "I_Officer_F";
NATOOfficer2 = "I_G_officer_F";
NATOBodyG = "I_Soldier_SL_F";
NATOCrew = "I_Crew_F";
NATOUnarmed = "I_G_Survivor_F";
NATOMarksman = "I_Soldier_M_F";
staticCrewMalos = ["I_support_MG_F","I_support_GMG_F","I_support_AMG_F","I_support_Mort_F","I_support_AMort_F"];
NATOMG = "I_HMG_01_high_F";
NATOGMG = "I_GMG_01_high_F";
NATORaisedStatics = [NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOMG,NATOGMG,NATOGMG,NATOGMG];
NATOMortar = "I_Mortar_01_F";
staticATmalos = "I_static_AT_F";
staticAAmalos = "I_static_AA_F";
NATOPilot = ["I_Helipilot_F","I_Fighter_Pilot_F","I_helicrew_F"];
vehNATOLightArmed = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_LT_01_cannon_F","I_LT_01_AT_F"];
vehNATOLightUnarmed = ["I_MRAP_03_F","I_LT_01_scout_F"];
vehNATOTrucks = ["I_Truck_02_covered_F","I_Truck_02_transport_F","I_Truck_02_medical_F"];
vehNATOAmmoTruck = ["I_Truck_02_ammo_F"];
vehNATORepairTruck = ["I_Truck_02_box_F"];
vehNATOLight = vehNATOLightArmed + vehNATOLightUnarmed;
vehNATOAPC = ["I_APC_Wheeled_03_cannon_F"];
vehNATOTank = ["I_MBT_03_cannon_F","I_APC_tracked_03_cannon_F"];
vehNATOAA = ["I_LT_01_AA_F"];
vehNATOAttack = vehNATOAPC + vehNATOTank;
vehNATOBoat = "I_Boat_Armed_01_minigun_F";
vehNATORBoat = "I_Boat_Transport_01_F";
vehNATOBoats = [vehNATOBoat,vehNATORBoat,"I_MBT_03_cannon_F"];
vehNATOPlane = ["I_Plane_Fighter_03_dynamicLoadout_F"];
vehNATOPlaneAA = ["I_Plane_Fighter_04_F"];
vehNATOPatrolHeli = "I_Heli_light_03_unarmed_F";
vehNATOTransportHelis = ["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F","B_Heli_Light_01_F"];
vehNATOAttackHelis = ["I_Heli_light_03_dynamicLoadout_F","B_Heli_Light_01_armed_F","O_Heli_Light_02_dynamicLoadout_F"];
vehNATOAir = vehNATOTransportHelis + vehNATOAttackHelis + vehNATOPlane + vehNATOPlaneAA;
vehNATOUAV = "I_UAV_02_dynamicLoadout_F";
vehNATOUAVSmall = "I_UAV_01_F";
vehNATOMRLS = ["I_Truck_02_MRL_F"];
vehNATOMRLSMags = "12Rnd_230mm_rockets";//[R Alpha 1-2:2 (Alberto),"rockets_230mm_GAT","rockets_230mm_GAT","Mode_1","R_230mm_HE","12Rnd_230mm_rockets",41: rocket_230mm_f.p3d,R Alpha 1-2:2 (Alberto)]
vehNATONormal = vehNATOLight + vehNATOTrucks + vehNATOAmmoTruck + ["I_Truck_02_fuel_F"] + vehNATORepairTruck;
vehNATOBike = "I_Quadbike_01_F";
NATOFlag = "Flag_AltisColonial_F";
NATOFlagTexture = "\A3\Data_F\Flags\Flag_AltisColonial_CO.paa";
NATOAmmobox = "I_supplyCrate_F";
//cfgNATOInf = (configfile >> "CfgGroups" >> "West" >> "BLU_T_F" >> "Infantry");///
gruposNATOSentry = ["I_Soldier_GL_F","I_soldier_F"];
gruposNATOSniper = ["I_sniper_F","I_spotter_F"];
gruposNATOsmall = [gruposNATOSentry,gruposNATOSniper];
gruposNATOAA = ["I_Soldier_TL_F","I_Soldier_AA_F","I_Soldier_AA_F","I_Soldier_AAA_F"];
gruposNATOAT = ["I_soldier_TL_F","I_soldier_AT_F","I_soldier_AT_F","I_soldier_AAT_F"];
gruposNATOmid = [["I_Soldier_TL_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_LAT_F"],gruposNATOAA,gruposNATOAT];
NATOSquad = ["I_soldier_SL_F",NATOGrunt,"I_soldier_LAT_F","I_Soldier_GL_F",NATOMarksman,"I_Soldier_AR_F","I_soldier_A_F","I_medic_F"];
NATOSpecOp = ["I_soldier_SL_F",NATOGrunt,"I_soldier_LAT_F","I_Soldier_GL_F","I_soldier_TL_F","I_Soldier_AR_F","I_soldier_A_F","I_medic_F"];
factionMachoMalos = "";
gruposNATOSquad = [
    NATOSquad,
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_soldier_AR_F","I_soldier_A_F","I_support_Mort_F","I_support_AMort_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_AR_F","I_soldier_A_F","I_support_MG_F","I_support_AMG_F","I_Soldier_AAR_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_soldier_AR_F","I_soldier_A_F","I_support_GMG_F","I_support_AMG_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_soldier_AR_F","I_soldier_A_F","I_soldier_AA_F","I_soldier_AAA_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_Soldier_LAT_F","I_soldier_AT_F","I_soldier_AAT_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_soldier_AR_F",NATOMarksman,"I_engineer_F","I_engineer_F"],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F","I_soldier_LAT2_F","I_soldier_AR_F","I_soldier_A_F","I_soldier_UAV_F",NATOMarksman],
    ["I_soldier_SL_F","I_soldier_TL_F","I_medic_F",NATOMarksman,"I_soldier_AR_F","I_soldier_A_F","I_soldier_UAV_06_F","I_soldier_UAV_06_medical_F"]
];

NATOStaticBackpacks = [
    [
        [
            "I_AT_01_weapon_F",
            "I_AA_01_weapon_F",
            "I_HMG_01_weapon_F",
            "I_GMG_01_weapon_F",
            "I_HMG_01_A_weapon_F",
            "I_GMG_01_A_weapon_F"
        ],
        "I_HMG_01_support_F"
    ],[
        [
            "I_HMG_01_high_weapon_F",
            "I_GMG_01_high_weapon_F"
        ],
        "I_HMG_01_support_high_F"
    ],[
        ["I_Mortar_01_weapon_F"],
        "I_Mortar_01_support_F"
    ]
];

NATOUAVBackpacks = [
    "I_UAV_01_backpack_F",
    "I_UAV_06_medical_backpack_F",
    "I_UAV_06_backpack_F"
];

NATOBackpacks = [[
        "B_Carryall_oli",
        "B_Carryall_khk"
    ],[
        "B_Bergen_dgtl_F"
    ]
];

soporteStaticNATOB = "I_HMG_01_support_F";
ATStaticNATOB = "I_AT_01_weapon_F";
MGStaticNATOB = "I_HMG_01_high_weapon_F";
soporteStaticNATOB2 = "I_HMG_01_support_high_F";
AAStaticNATOB = "I_AA_01_weapon_F";
MortStaticNATOB = "I_Mortar_01_weapon_F";
soporteStaticNATOB3 = "I_Mortar_01_support_F";

armasNATO append [
    "SMG_03_TR_black",
    "SMG_03_TR_camo",
    "SMG_03C_TR_black",
    "SMG_03C_TR_camo",
    "SMG_03_black",
    "SMG_03_camo",
    "SMG_03C_black",
    "SMG_03C_camo",
    "arifle_Mk20_F",
    "arifle_Mk20_plain_F",
    "arifle_Mk20C_F",
    "arifle_Mk20C_plain_F",
    "arifle_Mk20_GL_F",
    "arifle_Mk20_GL_plain_F",
    "LMG_Mk200_F",
    "srifle_EBR_F",
    "arifle_SDAR_F",
    "srifle_GM6_F",
    "launch_MRAWS_sand_rail_F"
];
municionNATO append [
    "HandGrenade",
    "UGL_FlareWhite_F",
    "UGL_FlareGreen_F",
    "1Rnd_Smoke_Grenade_shell",
    "1Rnd_HE_Grenade_shell",
    "50Rnd_570x28_SMG_03",
    "20Rnd_556x45_UW_mag",
    "30Rnd_556x45_Stanag",
    "30Rnd_556x45_Stanag_Tracer_Yellow",
    "200Rnd_65x39_cased_Box",
    "200Rnd_65x39_cased_Box_Tracer",
    "20Rnd_762x51_Mag",
    "5Rnd_127x108_Mag",
    "5Rnd_127x108_APDS_Mag",
    "MRAWS_HEAT_F",
    "MRAWS_HE_F"
];//possible ammo that spawn in NATO ammoboxes
guidedLaunchersNATO = ["launch_I_Titan_F","launch_I_Titan_short_F","launch_NLAW_F"];
guidedLauncherMunitionsNATO = ["Titan_AT", "Titan_AP", "Titan_AA","NLAW_F"];

flagNATOmrk = "flag_AltisColonial";
nameMalos = "AAF";
if (isServer) then {"NATO_carrier" setMarkerText "AAF Carrier"};