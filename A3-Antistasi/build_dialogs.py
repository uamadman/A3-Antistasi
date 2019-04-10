def store_class_base(class_name, idd=-1, movingenable='false', extra=None):
    """
    :param class_name: string: The name of the menu used to hold the controls/buttons
    :param idd: int: An identification. (Not sure what this does, -1 in all cases for now)
    :param movingenable: string: must be a string of either true or false
    (untested as all use cases are false, assuming it might let you drag the menu around)
    :param extra: dictionary: Additional parameters can be put here in dictionary form
    IE: {var: val, var2: val2, etc:etc}
    :return: dictionary: describing the first class in a menu
    """
    template = {
        'class_name': class_name,
        'idd': idd,
        'movingenable': movingenable,
    }

    if isinstance(extra, dict):
        template.update(extra)
    return template


def store_dialog(class_name, text='', tooltip='', action=r'', position='button', extra=None):
    """
    :param class_name: string: The menu features class name
    :param text: string: This is the text field IE: the button text
    :param tooltip: string: This is the popup message when hovering over a button
    :param action: string: this is the SQF function that gets executed on button press
    :param position: string: valid options are : button, background, background_frame, back_button
    :param extra: dictionary: Additional parameters can be put here in dictionary form
    IE: {var: val, var2: val2, etc:etc}
    :return: dictionary: describing the feature of a class within in a menu
    """
    template = {
        'class': class_name,
        'text': text,
        'tooltip': tooltip,
        'action': action,
        'position': position,
        'extra': extra
    }

    if isinstance(extra, dict):
        template.update(extra)
    return template


def gen_position_attributes(x, y, w, h):
    """
    :param x: int: the X axis of an object
    :param y :int: the Y axis of an object
    :param w :int: the width of an object
    :param h :int: the height of an object
    :return: dictionary: a properly formatted dictionary containing the formula for properly placing menu features
    """
    standard_frame = [
        'x = {0} * safezoneW + safezoneX;'.format(round(x, 3)),
        'y = {0} * safezoneH + safezoneY;'.format(round(y, 3)),
        'w = {0} * safezoneW;'.format(round(w, 3)),
        'h = {0} * safezoneH;'.format(round(h, 3))
    ]
    return standard_frame


def get_position(position, class_controls, button=0):
    """
    # This function calculates where and how a menu feature should be placed.
    :param position: string: valid options are : button, background, background_frame, back_button
    :param class_controls: dictionary: This is all the necessary information to
                           place a menu feature look at store_dialog
    :param button: This indicates the position if the incoming class is a button.
    :return: dictionary: Once values are established gen_position_attributes
                         is properly filled out and its dictionary is returned.
    """
    # The default reference values for menu and button placement
    bkgd_x = .25
    bkgd_y = .22
    bkgd_w = .46
    bkgd_h = .150

    # Take note of how many buttons there are.
    control_count = len(class_controls)

    # calculate and generate the background and background frame attributes
    if position == 'background' or position == 'background_frame':
        for control in class_controls:
            control_position = control.get('position')
            if control_position == 'background' or \
                    control_position == 'background_frame' or \
                    control_position == 'back_button':
                control_count -= 1
        if control_count % 2 != 0:
            control_count += 1
        if int(control_count / 2) < 1:
            cc = 1
        else:
            cc = int(control_count / 2)
        if position == 'background':
            return gen_position_attributes(bkgd_x, bkgd_y, bkgd_w, (cc * .1) + bkgd_h)
        elif position == 'background_frame':
            return gen_position_attributes(bkgd_x + .02, bkgd_y + .02, bkgd_w - .04, (cc * .1) + bkgd_h - .04)

    # generate the default back button attributes
    elif position == 'back_button':
        return gen_position_attributes(0.61, 0.25, 0.06, 0.05)

    # calculate and generate the button attributes
    elif position == 'button':
        if button % 2 == 0:
            button_column = .490
        else:
            button_column = .290
        button_row = (button - 1) // 2
        return gen_position_attributes(button_column, .320 + (button_row * .1), 0.175015, 0.0560125)

    # if its doesn't match any of the above positions tell them about it
    # but return an empty array and don't crash the script.
    print(str(position) + 'is not a valid position')
    return list()


def build_dialog_file(path, dialog_map, custom_block):
    """
    :param path: path string: Define the dialog.hpp file location
    :param dialog_map: dictionary: this is the built in dialog_map structure with all the key components to auto magically
                       generate the dialog.hpp file
    :param custom_block: string: This string is blanket pasted to the end of the dialog.hpp file
    :return: string: an indication of Success!
    """
    with open(path, 'w') as o:
        for menu in dialog_map:

            # Build the base menu class
            menu_att = menu.get('class origin')
            o.write('class {0} {1}\n'.format(menu_att.get('class_name'), '{'))
            o.write('\tidd = {0};\n'.format(menu_att.get('idd')))
            o.write('\tmovingenable = {0};\n'.format(menu_att.get('movingenable')))
            o.write('\tclass controls {\n')
            idc = 100
            button = 0

            # Build each of the menu features
            for sub_att in menu.get('class controls'):
                o.write('\t\tclass {0}\n'.format(sub_att.get('class')))
                o.write('\t\t{\n')
                idc += 1
                o.write('\t\t\tidc = {0};\n'.format(idc))
                if sub_att.get('text'):
                    o.write('\t\t\ttext = "{0}";\n'.format(sub_att.get('text')))
                if sub_att.get('tooltip'):
                    o.write('\t\t\ttooltip = "{0}";\n'.format(sub_att.get('tooltip')))
                if sub_att.get('action'):
                    o.write('\t\t\taction = {0};\n'.format(sub_att.get('action')))
                if sub_att.get('position'):
                    if sub_att.get('position') == 'button':
                        button += 1
                        for pos in get_position('button', menu.get('class controls'), button):
                            o.write('\t\t\t{0}\n'.format(pos))
                    else:
                        for pos in get_position(sub_att.get('position'), menu.get('class controls')):
                            o.write('\t\t\t{0}\n'.format(pos))
                if sub_att.get('extra'):
                    for row in sub_att.get('extra'):
                        o.write('\t\t\t{0}\n'.format(row))
                o.write('\t\t};\n')

            # Write the closing encapsulations for each menu set
            o.write('\t};\n')
            o.write('};\n')

        # write the custom block that is too unqiue to be worth automating
        o.write(custom_block)
    return 'Success'


dialog_map = [
    # Startup Menu
    {'class origin': store_class_base('first_load'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Load previous session?', position='background_frame'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="YES",
                      tooltip="Loads the pervious personal session",
                      action=r'"closeDialog 0;nul = [true] execVM ""statSave\loadAccount.sqf"";"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="NO",
                      tooltip="Starts a new game",
                      action=r'"closeDialog 0;if ((player == theBoss) and (isNil ""placementDone"") '
                             'and !(isMultiplayer)) then {closeDialog 0;[] execVM ""dialogs\difficultyMenu.sqf""};"'),
     ]
     },
    # HQ Menu
    {'class origin': store_class_base('HQ_menu', idd=100),
     'class controls': [
         store_dialog('HQ_BOX: BOX',
                      position='background'),

         store_dialog('HQ_frame: RscFrame',
                      text='HQ Options - Commander Only',
                      position='background_frame'),

         store_dialog('HQ_button_back: RscButton',
                      text='Back',
                      position='back_button',
                      action=r'"closeDialog 0"'),

         store_dialog('HQ_button_load: RscButton',
                      text="Grab 100 € from Pool",
                      tooltip="Take 100 € from faction pool and add it to your personnal account. It will damage your position among the faction in the commander career",
                      action=r'"if (isMultiPlayer) then {if (player == theBoss) then {nul=call A3A_fnc_theBossSteal} else {hint ""Only Player Commander has access to this function""}} else {hint ""This function is MP only""};"'),

         store_dialog('HQ_button_savegame: RscButton',
                      text="Manage Garrisons",
                      tooltip="Add or remove units to garrisons",
                      action=r'"closeDialog 0;if (player == theBoss) then {nul=CreateDialog ""build_menu""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_moveHQ: RscButton',
                      text="Move HQ to another Zone",
                      tooltip="Petros will join your group. Ammobox must be empty. To rebuild, select the Build action near Petros",
                      action=r'"closeDialog 0;if (player == theBoss) then {nul = [] spawn A3A_fnc_moveHQ;} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_recruitUnit: RscButton',
                      text="Ingame Member's List",
                      tooltip="Displays which server members are currently playing",
                      action=r'"if (player == theBoss) then {if (isMultiplayer) then {nul = [] call A3A_fnc_membersList} else {hint ""This function is MP only""}} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_recruitSquad: RscButton',
                      text="Rebuild Assets",
                      tooltip="Cost: 5.000 €",
                      action=r'"closeDialog 0;if (player == theBoss) then {nul=[] spawn A3A_fnc_rebuildAssets} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_vehicle: RscButton',
                      text="Train AI - Skill Upgrade",
                      tooltip="",
                      action=r'"closeDialog 0;if (player == theBoss) then {nul = [] call A3A_fnc_FIAskillAdd} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_skill: RscButton',
                      text="Garage Access",
                      tooltip="Check Faction garage",
                      action=r'"closeDialog 0;nul = [false] spawn A3A_fnc_garage"'),
     ],
     },

    # Build Menu
    {'class origin': store_class_base('build_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Building & Garrison Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""HQ_menu"";"'),
         store_dialog('4slots_L1: RscButton',
                      text="Minefield Options",
                      tooltip="AI will deploy or remove mines on desired objectives, using current arsenal mine count",
                      action=r'"closeDialog 0;_nul = createDialog ""minebuild_menu"";"'),

         store_dialog('4slots_R1: RscButton',
                      text="O.Post - Roadblock",
                      tooltip="Establish a new watchpost or roadblock depending on the type of terrain you select",
                      action=r'"closeDialog 0; [""create""] spawn A3A_fnc_puestoDialog"'),

         store_dialog('4slots_L2: RscButton',
                      text="Add Garrison",
                      tooltip="Add units to an existing garrison",
                      action=r'"closeDialog 0; [""add""] spawn A3A_fnc_garrisonDialog"'),

         store_dialog('4slots_R2: RscButton',
                      text="Remove Garrison",
                      tooltip="Remove whole garrisons or posts",
                      action=r'"closeDialog 0; [""rem""] spawn A3A_fnc_garrisonDialog"'),
     ]
     },

    # Garrison Recruitment Menu
    {'class origin': store_class_base('garrison_recruit'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Garrison Recruitment Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""build_menu"";"'),

         store_dialog('HQ_button_rifleman: RscButton',
                      text="Recruit Militiaman",
                      action=r'"nul = [SDKMil] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_autorifleman: RscButton',
                      text="Recruit Autorifleman",
                      action=r'"nul = [SDKMG] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_medic: RscButton',
                      text="Recruit Medic",
                      action=r'"nul = [SDKMedic] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_engineer: RscButton',
                      text="Recruit Squad Leader",
                      action=r'"nul = [SDKSL] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_explosive: RscButton',
                      text="Recruit Mortar",
                      action=r'"nul = [staticCrewBuenos] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_grenadier: RscButton',
                      text="Recruit Grenadier",
                      action=r'"nul = [SDKGL] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_marksman: RscButton',
                      text="Recruit Marksman",
                      action=r'"nul = [SDKSniper] spawn A3A_fnc_garrisonAdd"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Recruit AT",
                      action=r'"nul = [SDKATman] spawn A3A_fnc_garrisonAdd"'),
     ]
     },

    # Mine Building Menu
    {'class origin': store_class_base('minebuild_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Build Minefield', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""build_menu"";"'),

         store_dialog('HQ_button_mortar: RscButton',
                      text="APERS Mines",
                      action=r'"closeDialog 0;[""APERSMine""] spawn A3A_fnc_mineDialog"'),

         store_dialog('HQ_button_MG: RscButton',
                      text="Remove Minefield",
                      tooltip="Spawn an AI Engineer which will clear any mine in it's surroundings",
                      action=r'"closeDialog 0; [""delete""] spawn A3A_fnc_mineDialog;"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="AT Mines",
                      action=r'"closeDialog 0; [""ATMine""] spawn A3A_fnc_mineDialog"'),
     ]
     },

    # Personal Squad Recruitment Menu
    {'class origin': store_class_base('unit_recruit'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Recruitment Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),
         store_dialog('HQ_button_rifleman: RscButton',
                      text="Recruit Militiaman",
                      action=r'"nul = [SDKMil] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_autorifleman: RscButton',
                      text="Recruit Autorifleman",
                      action=r'"nul = [SDKMG] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_medic: RscButton',
                      text="Recruit Medic",
                      action=r'"nul = [SDKMedic] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_engineer: RscButton',
                      text="Recruit Engineer",
                      action=r'"nul = [SDKEng] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_explosive: RscButton',
                      text="Recruit Bomb Specialist",
                      action=r'"nul = [SDKExp] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_grenadier: RscButton',
                      text="Recruit Grenadier",
                      action=r'"nul = [SDKGL] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_marksman: RscButton',
                      text="Recruit Marksman",
                      action=r'"nul = [SDKSniper] spawn A3A_fnc_reinfPlayer"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Recruit AT",
                      action=r'"nul = [SDKATman] spawn A3A_fnc_reinfPlayer"'),
     ]
     },

    # The base vehicle purchase menu, choose your flavor, civilian or military!
    {'class origin': store_class_base('vehicle_option'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Buy Vehicle', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Civilian Vehicle",
                      tooltip="Civilian vehicles will allow you to travel in Undercover mode, while you stay close to roads and not entering bases, outposts and roadblocks",
                      action=r'"closeDialog 0;nul=[] execVM ""Dialogs\buy_vehicle_civ.sqf"";"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Military Vehicle",
                      tooltip="Wide variety of available faction vehicles",
                      action=r'"closeDialog 0; nul=[] execVM ""Dialogs\buy_vehicle.sqf"";"'),
     ]
     },

    # Buy Military Vehicles Menu
    {'class origin': store_class_base('buy_vehicle'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Purchase Military Vehicle', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0; nul = createDialog ""vehicle_option"";"'),
         store_dialog('HQ_button_quad: RscButton',
                      text="Buy Quadbike",
                      action=r'"closedialog 0; nul = [vehSDKBike] spawn A3A_fnc_addFIAveh"'),

         store_dialog('HQ_button_offroad: RscButton',
                      text="Buy Offroad",
                      action=r'"closeDialog 0;nul = [vehSDKLightUnarmed] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_truck: RscButton',
                      text="Buy Truck",
                      action=r'"closeDialog 0;nul = [vehSDKTruck] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_Aoffroad: RscButton',
                      text="Buy Armed Offroad",
                      action=r'"closeDialog 0;nul = [vehSDKLightArmed] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_MG: RscButton',
                      text="Buy MG",
                      action=r'"closeDialog 0;nul = [SDKMGStatic] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_mortar: RscButton',
                      text="Buy Mortar",
                      action=r'"closeDialog 0;nul = [SDKMortar] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Buy Static AT",
                      action=r'"closeDialog 0;nul = [staticATBuenos] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_AA: RscButton',
                      text="Buy Static AA",
                      action=r'"closeDialog 0;nul = [staticAABuenos] spawn A3A_fnc_addFIAveh;"'),
     ]
     },

    # Buy civilian vehicles menu
    {'class origin': store_class_base('civ_vehicle'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Buy Civilian Vehicle', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0; nul = createDialog ""vehicle_option"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Offroad",
                      action=r'"closeDialog 0;nul = [civCar] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Truck",
                      action=r'"closeDialog 0;nul = [civTruck] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="Helicopter",
                      action=r'"closeDialog 0;nul = [civHeli] spawn A3A_fnc_addFIAveh;"'),

         store_dialog('HQ_button_offroad: RscButton',
                      text="Boat",
                      action=r'"closeDialog 0;[civBoat] spawn A3A_fnc_addFIAveh;"'),
     ]
     },

    # Game options
    {'class origin': store_class_base('game_options'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Game Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('8slots_L1: RscButton',
                      text="Civ Limit",
                      tooltip="Set the max number of spawned civilians. Affects game performance",
                      action=r'"if (player == theBoss) then {closeDialog 0; nul = createDialog ""civ_config""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_R1: RscButton',
                      text="Spawn Distance",
                      tooltip="Affects performance. Please use this with caution. Set it to lower distances if you feel Antistasi is running bad",
                      action=r'"if (player == theBoss) then {closeDialog 0; nul = createDialog ""spawn_config""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_L2: RscButton',
                      text="AI Limiter",
                      tooltip="Sets how much local and simulated AI can spawn in the map. Affects performance and AI ""intelligence"". Use with caution. This is not an exact number as vehicles and squad leaders will allways spawn",
                      action=r'"if (player == theBoss) then {closeDialog 0; nul = createDialog ""fps_limiter""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_R2: RscButton',
                      text="Music ON/OFF",
                      tooltip="Disables/Enable situational music",
                      action=r'"closedialog 0; if (musicON) then {musicON = false; hint ""Music turned OFF""} else {musicON = true; hint ""Music turned ON""}; nul = execVM ""musica.sqf"";"'),

         store_dialog('8slots_M4: RscButton',
                      text="Persistent Save",
                      tooltip="Use this option to save your current game. It does save the most important data in a ""Grand Theft Auto"" way. This opnion allows good MP save and independent saves of any version update. Vanilla saves are disabled because of lack of several features",
                      action=r'"closeDialog 0;if (player == theBoss) then {[""statSave\saveLoop.sqf"",""BIS_fnc_execVM""] call BIS_fnc_MP} else {_nul = [] execVM ""statSave\saveLoop.sqf""; hintC ""Personal Stats Saved""};"'),
     ]
     },

    # AI population limits menu
    {'class origin': store_class_base('fps_limiter'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='AI Limiter', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""game_options"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="+10 AI Limit",
                      action=r'"if (player == theBoss) then {if (maxUnits < 200) then {maxUnits = maxUnits + 10; publicVariable ""maxUnits""; hint format [""AI Limit has been set at %1"",maxUnits]} else {hint ""AI Limit cannot be raised from 200""}} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="-10 AI Limit",
                      action=r'"if (player == theBoss) then {if (maxUnits > 80) then {maxUnits = maxUnits - 10; publicVariable ""maxUnits""; hint format [""AI Limit has been set at %1"",maxUnits]} else {hint ""AI Limit cannot be less than 80""}} else {hint ""Only Player Commander has access to this function""};"'),

     ]
     },

    # AI spawn distance limits menu
    {'class origin': store_class_base('spawn_config'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Spawn Distance Config', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""game_options"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="+100 Spawn Dist.",
                      action=r'"if (player == theBoss) then {if (distanciaSPWN < 2000) then {distanciaSPWN = distanciaSPWN + 100; distanciaSPWN1 = distanciaSPwN * 1.3; distanciaSPWN2 = distanciaSPWN /2; publicVariable ""distanciaSPWN"";publicVariable ""distanciaSPWN1"";publicVariable ""distanciaSPWN2""}; hint format [""Spawn Distance Set to %1 meters. Be careful, this may affect game performance"",distanciaSPWN]} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="-100 Spawn Dist.",
                      action=r'"if (player == theBoss) then {if (distanciaSPWN > 600) then {distanciaSPWN = distanciaSPWN - 100; if (distanciaSPWN < 600) then {distanciaSPWN = 600}; distanciaSPWN1 = distanciaSPwN * 1.3; distanciaSPWN2 = distanciaSPWN /2; if (distanciaSPWN < 600) then {distanciaSPWN = 600};publicVariable ""distanciaSPWN"";publicVariable ""distanciaSPWN1"";publicVariable ""distanciaSPWN2"";}; hint format [""Spawn Distance Set to %1 meters"",distanciaSPWN]} else {hint ""Only Player Commander has access to this function""};"'),

     ]
     },

    # Civilian population spawn limits
    {'class origin': store_class_base('civ_config'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Civ Presence Config', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""game_options"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="+1 Max Civs",
                      action=r'"if (player == theBoss) then {if (civPerc < 150) then {civPerc = civPerc + 1; if (civPerc > 150) then {civPerc = 150}; publicVariable ""civPerc"";}; hint format [""Maximum Number of Civilians Set to %1"",civPerc]} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="-1 Max Civs",
                      action=r'"if (player == theBoss) then {if (civPerc > 0) then {civPerc = civPerc - 1; if (civPerc < 0) then {civPerc = 0};publicVariable ""civPerc"";}; hint format [""Maximum Number of Civilians Set to %1"",civPerc]} else {hint ""Only Player Commander has access to this function""};"'),

     ]
     },

    # Mission request menu
    {'class origin': store_class_base('mission_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Available Missions', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('HQ_button_AS: RscButton',
                      text="Assassination Mission",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""AS""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_CONV: RscButton',
                      text="Convoy Ambush",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""CONVOY""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_DES: RscButton',
                      text="Destroy Missions",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""DES""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_LOG: RscButton',
                      text="Logistics Mission",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""LOG""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_RES: RscButton',
                      text="Rescue Missions",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""RES""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_vehicle: RscButton',
                      text="Conquest Missions",
                      action=r'"closeDialog 0;if ((player == theBoss) or (not(isPlayer theBoss))) then {[[""CON""],""A3A_fnc_missionRequest""] call BIS_fnc_MP} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_exit: RscButton',
                      text="EXIT",
                      action=r'"closeDialog 0;"'),
     ]
     },

    # The Y  Menu!
    {'class origin': store_class_base('radio_comm'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Battle Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('8slots_L1: RscButton',
                      text="Fast Travel",
                      tooltip="Teleport your squad or a HC selected squad to a friendly zone depending on several factors",
                      action=r'"closeDialog 0;nul = [] execVM ""fastTravelRadio.sqf"";"'),

         store_dialog('8slots_R1: RscButton',
                      text="Player and Money",
                      tooltip="Look at some player and interact with him",
                      action=r'"closeDialog 0;if (isMultiPlayer) then {nul = createDialog ""player_money""} else {hint ""MP Only Menu""};"'),

         store_dialog('8slots_L2: RscButton',
                      text="Undercover ON",
                      tooltip="Become Undercover if you match the requirements. Enemy AI won't attack you until they discover you",
                      action=r'"closeDialog 0;nul = [] spawn A3A_fnc_undercover"'),

         store_dialog('8slots_R2: RscButton',
                      text="Construct Here",
                      tooltip="Construct in the spot where you are a selected building facing this direction",
                      action=r'"closeDialog 0;_nul = createDialog ""construction_menu"";"'),

         store_dialog('8slots_L3: RscButton',
                      text="Garage Vehicle",
                      tooltip="Vehicle or Static gun you're looking at will be garaged, interact with Flag to retrieve",
                      action=r'"closeDialog 0;if (player != theBoss) then {nul = [false] call A3A_fnc_garageVehicle} else {if (isMultiplayer) then {_nul = createDialog ""garage_check""} else {nul = [true] call A3A_fnc_garageVehicle}};"'),

         store_dialog('8slots_R3: RscButton',
                      text="Unlock Vehicle",
                      tooltip="Allow other groups to mount this vehicle",
                      action=r'"closeDialog 0;[] call A3A_fnc_unlockVehicle"'),

         store_dialog('8slots_L4: RscButton',
                      text="AI Management",
                      tooltip="Several AI options",
                      action=r'"if (player == leader group player) then {closeDialog 0;nul = createDialog ""AI_management""} else {hint ""Only group leaders may access to this option""};"'),

         store_dialog('8slots_R4: RscButton',
                      text="Commander",
                      tooltip="Open commander options",
                      action=r'"closeDialog 0; nul = createDialog ""commander_comm"";"'),
     ]
     },

    # Vehicle management menu
    {'class origin': store_class_base('vehicle_manager'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Vehicle Manager', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Garage\Sell Vehicle",
                      tooltip="Add to garage / sell the vehicle you are currently looking at",
                      action=r'"closeDialog 0;nul = createDialog ""garage_sell"";"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Vehicles and Squads",
                      tooltip="Options related to vehicle management in HC controlled squads",
                      action=r'"closeDialog 0; if (player == theBoss) then {nul = createDialog ""squad_manager""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="Add to Air Support",
                      tooltip="Gain Airstrike points giving this vehicle to the faction Air pool",
                      action=r'"closeDialog 0;nul = [] call A3A_fnc_addBombRun"'),

         store_dialog('HQ_button_unlock: RscButton',
                      text="Unlock Vehicle",
                      tooltip="Allow other groups to mount this vehicle",
                      action=r'"closeDialog 0;[] call A3A_fnc_unlockVehicle"'),
     ]
     },

    # Squad vehicle confirmation menu
    {'class origin': store_class_base('veh_query'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Add Vehicle to Squad?', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;vehQuery = nil; if (player == theBoss) then {nul= [] execVM ""Dialogs\squad_recruit.sqf""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="YES",
                      action=r'"closeDialog 0; vehQuery = true"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="NO",
                      action=r'"closeDialog 0; vehQuery = nil"'),
     ]
     },

    # Squad Management Menu
    {'class origin': store_class_base('squad_manager'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='HC Squad Otions', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_mortar: RscButton',
                      text="Squad Add Vehicle",
                      tooltip="Look at some vehicle and assign it to the selected squad for it's use",
                      action=r'"closeDialog 0;[] call A3A_fnc_addSquadVeh;"'),

         store_dialog('HQ_button_MG: RscButton',
                      text="Squad SITREP",
                      tooltip="If the selected squad is using some vehicle, know remotely it's status",
                      action=r'"[""stats""] call A3A_fnc_vehStats;"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Mount / Dismount",
                      tooltip="Force squad to mount or dismount their assigned vehicle",
                      action=r'"[""mount""] call A3A_fnc_vehStats"'),

         store_dialog('HQ_button_AA: RscButton',
                      text="Static Autotarget",
                      tooltip="Use this option on AT / AA mounted squads. The truck driver will try to point his truck's back to any detected enemy",
                      action=r'"closeDialog 0; [] spawn A3A_fnc_staticAutoT"'),
     ]
     },

    # AI management menu
    {'class origin': store_class_base('AI_management'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Battle Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;nul = createDialog ""radio_comm"";"'),

         store_dialog('8slots_L1: RscButton',
                      text="Temp. AI Control",
                      tooltip="Take personal control of the selected squad member or HC squad leader and be able to perform any kind of actions for 60 seconds. Control state will be cancelled if the player or the controlled unit receives any kind of damage",
                      action=r'"closeDialog 0; if ((count groupselectedUnits player > 0) and (count hcSelected player > 0)) exitWith {hint ""You must select from HC or Squad Bars, not both""}; if (count groupselectedUnits player == 1) then {nul = [groupselectedUnits player] execVM ""REINF\controlunit.sqf""}; if (count hcSelected player == 1) then {nul = [hcSelected player] execVM ""REINF\controlHCsquad.sqf"";};"'),

         store_dialog('8slots_R1: RscButton',
                      text="Auto Rearm \ Loot",
                      tooltip="AI will search for better weapons, vests, helmets etc. If they are in a vehicle, they will just store what they scavenge in the vehicle. If not, they will equip them",
                      action=r'"closeDialog 0; if (count groupselectedUnits player == 0) then {nul = (units group player) spawn A3A_fnc_rearmCall} else {nul = (groupselectedUnits player) spawn A3A_fnc_rearmCall};"'),

         store_dialog('8slots_L2: RscButton',
                      text="Auto Heal",
                      tooltip="AI squad mates will heal proactively each other",
                      action=r'"if (autoHeal) then {autoHeal = false; hint ""Auto Healing disabled"";} else {autoHeal = true; hint ""Auto Heal enabled""; nul = [] spawn A3A_fnc_autoHealFnc}"'),

         store_dialog('8slots_R2: RscButton',
                      text="Squad SITREP",
                      tooltip="Recover info about a HC squad status",
                      action=r'"[""stats""] call A3A_fnc_vehStats;"'),

         store_dialog('8slots_L3: RscButton',
                      text="Garrison Units / Squads",
                      tooltip="Adds selected units or squads to a map selected garrison",
                      action=r'"closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\addToGarrison.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\addToGarrison.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}"'),

         store_dialog('8slots_R3: RscButton',
                      text="Squad Add Vehicle",
                      tooltip="Look at some vehicle and assign it to the selected squad for it's use",
                      action=r'"closeDialog 0;[] call A3A_fnc_addSquadVeh;"'),

         store_dialog('8slots_L4: RscButton',
                      text="Dismiss Units / Squad",
                      tooltip="Dimiss selected units or squads, recovering it's cost to the proper resource pool",
                      action=r'"closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\dismissPlayerGroup.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\dismissSquad.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}"'),

         store_dialog('8slots_R4: RscButton',
                      text="Mount / Dismount",
                      tooltip="Force squad to mount or dismount their assigned vehicle",
                      action=r'"[""mount""] call A3A_fnc_vehStats"'),
     ]
     },

    # Commander Options Menu
    {'class origin': store_class_base('commander_comm'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Commander Battle Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;nul = createDialog ""radio_comm"";"'),

         store_dialog('8slots_L1: RscButton',
                      text="Recruit Squad",
                      tooltip="Recruit new squads and manage them with the HC Module (CTRL + SPACE)",
                      action=r'"closeDialog 0;if (player == theBoss) then {nul= [] execVM ""Dialogs\squad_recruit.sqf""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_R1: RscButton',
                      text="Air Support",
                      tooltip="Ask for Air Support (uses Airstrike points)",
                      action=r'"closeDialog 0;if (player == theBoss) then {_nul = createDialog ""carpet_bombing""} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_L2: RscButton',
                      text="O.Post - Roadblock",
                      tooltip="Establish a new watchpost or roadblock depending on the type of terrain you select",
                      action=r'''"if (player == theBoss) then {closeDialog 0;[""create""] spawn A3A_fnc_puestoDialog} else {hint ""You're not the Commander!""};"'''),

         store_dialog('8slots_R2: RscButton',
                      text="Garbage Clean",
                      tooltip="Cleans several things in game. Use with caution as it freezes the mission",
                      action=r'"if (player == theBoss) then {closedialog 0;[] remoteExec [""A3A_fnc_garbageCleaner"",2]} else {hint ""Only Player Commander has access to this function""};"'),

         store_dialog('8slots_L3: RscButton',
                      text="O.Post-Roadblock Delete",
                      tooltip="Remove selected observation post or roadblock, money will be refunded",
                      action=r'''"if (player == theBoss) then {closeDialog 0; [""delete""] spawn A3A_fnc_puestoDialog} else {hint ""You're not the Commander!""};"'''),

         store_dialog('8slots_R3: RscButton',
                      text="Faction Garage",
                      tooltip="Look at a vehicle and garage it into faction garage (shared among commanders)",
                      action=r'''"if (player == theBoss) then {closeDialog 0;nul = [true] call A3A_fnc_garageVehicle;} else {hint ""You're not the Commander!""};"'''),

         store_dialog('8slots_L4: RscButton',
                      text="Resign / Eligible",
                      tooltip="Step down from commander or toggle eligibility",
                      action=r'"if (isMultiplayer) then {closedialog 0;execVM ""orgPlayers\commResign.sqf""} else {hint ""This feature is MP Only""};"'),

         store_dialog('8slots_R4: RscButton',
                      text="Sell Vehicle",
                      tooltip="Look at a vehicle and sell it for money",
                      action=r'"if (player == theBoss) then {closeDialog 0; nul = [] call A3A_fnc_sellVehicle} else {hint ""Only the Commander can sell vehicles""};"'),
     ]
     },

    # Air Strike Request Menu
    {'class origin': store_class_base('carpet_bombing'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Carpet Bombing Strike', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0; nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="HE Bombs",
                      tooltip="Cost: 1 point",
                      action=r'"closeDialog 0;[""HE""] spawn A3A_fnc_NATObomb;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Carpet Bombing",
                      tooltip="Cost: 1 point",
                      action=r'"closeDialog 0;[""CARPET""] spawn A3A_fnc_NATObomb;"'),

         store_dialog('4slots_L2: RscButton',
                      text="NAPALM Bomb",
                      tooltip="Cost: 1 point",
                      action=r'"closeDialog 0;[""NAPALM""] spawn A3A_fnc_NATObomb;"'),

         store_dialog('4slots_R2: RscButton',
                      text="Add to Air Support",
                      tooltip="Gain Airstrike points giving this aircraft to the faction Air pool",
                      action=r'"closeDialog 0;nul = [] call A3A_fnc_addBombRun"'),
     ]
     },

    # Dismiss/Garrison menu(Deprecated/NOT IN USE?)
    {'class origin': store_class_base('dismiss_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Dismiss Options', position='background_frame'),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Dismiss Units / Squad",
                      tooltip="Dimiss selected units or squads, recovering it's cost to the proper resource pool",
                      action=r'"closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\dismissPlayerGroup.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\dismissSquad.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Garrison Units / Squads",
                      tooltip="Adds selected units or squads to a map selected garrison",
                      action=r'"closeDialog 0;if (count groupselectedUnits player > 0) then {nul = [groupselectedUnits player] execVM ""REINF\addToGarrison.sqf""} else {if (count (hcSelected player) > 0) then {nul = [hcSelected player] execVM ""REINF\addToGarrison.sqf""}}; if ((count groupselectedUnits player == 0) and (count hcSelected player == 0)) then {hint ""No units or squads selected""}"'),

         # store_dialog('HQ_button_Gremove: RscButton',
         #              text="Remove Garrison Squads",
         #              action=r'"nul = [] call removeGarrison"'),

     ]
     },

    # Construction Menu
    {'class origin': store_class_base('construction_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Small Trench",
                      tooltip="Make a quick small trench for one man",
                      action=r'"closeDialog 0;nul = [""ST""] spawn A3A_fnc_construir;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Medium Trench",
                      tooltip="A mid sized trench with capabilities for more than one soldier",
                      action=r'"closeDialog 0; nul = [""MT""] spawn A3A_fnc_construir;"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="Vehicle obstacles",
                      tooltip="Build some obstacles for vehicles",
                      action=r'"closeDialog 0;nul = [""RB""] spawn A3A_fnc_construir;"'),

         store_dialog('HQ_button_unlock: RscButton',
                      text="Bunker Options",
                      tooltip="Need to be built in garrison controlled zones and cost money",
                      action=r'"closeDialog 0;nul = createDialog ""bunker_menu"""'),
     ]
     },

    # Construction sub bunker menu
    {'class origin': store_class_base('bunker_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select Bunker Type', position='background_frame'),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Sandbag Bunker",
                      tooltip="Requires to be in a garrisoned zone. It will be permanent",
                      action=r'"closeDialog 0;nul = [""SB""] spawn A3A_fnc_construir;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Concrete Bunker",
                      tooltip="Requires to be in a garrisoned zone. It will be permanent",
                      action=r'"closeDialog 0;nul = [""CB""] spawn A3A_fnc_construir;"'),
     ]
     },

    # Commander Recruit Squad Menu
    {'class origin': store_class_base('squad_recruit'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Squad Recruitment Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0; _nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_infsquad: RscButton',
                      text="Recruit Inf. Squad",
                      action=r'"closeDialog 0;[] execVM ""Dialogs\squadOptions.sqf"";"'),

         store_dialog('HQ_button_infteam: RscButton',
                      text="Recruit Inf. Team",
                      action=r'"closeDialog 0;nul = [gruposSDKmid] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_ATteam: RscButton',
                      text="Recruit AT Team",
                      action=r'"closeDialog 0;nul = [gruposSDKAT] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_sniperTeam: RscButton',
                      text="Recruit Sniper Team",
                      action=r'"closeDialog 0;nul = [gruposSDKSniper] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_infsquadM: RscButton',
                      text="Recruit MG Team",
                      action=r'"closeDialog 0;nul = [SDKMGStatic] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_infteamM: RscButton',
                      text="Recruit AT Car",
                      action=r'"closeDialog 0;nul = [vehSDKAT] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_ATteamM: RscButton',
                      text="Recruit AA Truck",
                      action=r'"closeDialog 0;nul = [staticAABuenos] spawn A3A_fnc_addFIAsquadHC"'),

         store_dialog('HQ_button_mortar: RscButton',
                      text="Recruit Mortar Team",
                      action=r'"closeDialog 0;nul = [SDKMortar] spawn A3A_fnc_addFIAsquadHC"'),
     ]
     },

    # Players and Money Menu
    {'class origin': store_class_base('player_money'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Player and Money Interaction', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""radio_comm"";"'),

         store_dialog('HQ_button_mortar: RscButton',
                      text="Add Server Member",
                      tooltip="Use this option to add the player which you are currently looking to the member's list",
                      action=r'"if (isMultiplayer) then {closeDialog 0;nul = [""add""] call A3A_fnc_memberAdd;} else {hint ""This function is MP only""};"'),

         store_dialog('HQ_button_MG: RscButton',
                      text="Remove Server Member",
                      tooltip="Use this option to remove the player which you are currently looking to the member's list",
                      action=r'"if (isMultiplayer) then {closeDialog 0;nul = [""remove""] call A3A_fnc_memberAdd;} else {hint ""This function is MP only""};"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Donate 100 € to player",
                      action=r'"[true] call A3A_fnc_donateMoney;"'),

         store_dialog('HQ_button_AA: RscButton',
                      text="Donate 100 € to Faction",
                      tooltip="It will increase your prestige among your faction",
                      action=r'"[] call A3A_fnc_donateMoney;"'),
     ]
     },

    # Garage/Sell Submenu (only able to activate when using the lower level garage menu's back button????)
    {'class origin': store_class_base('garage_sell'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Sell or Garage Vehicle', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""vehicle_manager"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Garage Vehicle",
                      action=r'"closeDialog 0;if (player != theBoss) then {nul = [false] call A3A_fnc_garageVehicle} else {if (isMultiplayer) then {_nul = createDialog ""garage_check""} else {nul = [true] call A3A_fnc_garageVehicle}};"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Sell Vehicle",
                      action=r'"closeDialog 0; if (player == theBoss) then {nul = [] call A3A_fnc_sellVehicle} else {hint ""Only the Commander can sell vehicles""};"'),

     ]
     },

    # Garage selection menu
    {'class origin': store_class_base('garage_check'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Personal or Faction Garage?', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""garage_sell"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Personal Garage",
                      action=r'"closeDialog 0;nul = [false] call A3A_fnc_garageVehicle;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Faction Garage",
                      action=r'"closeDialog 0; nul = [true] call A3A_fnc_garageVehicle;"'),

     ]
     },

    # The Carpet Bombing Strike Menu!
    {'class origin': store_class_base('tu_madre'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Carpet Bombing Strike', position='background_frame'),
         store_dialog('HQ_button_back: RscListBox', text='Back', position='back_button', action=r'"closeDialog 0"',
                      extra=['sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 35) * 1.2)";',
                             'colorText[] = {1,1,1,1}; // Text and frame color',
                             'colorDisabled[] = {1,1,1,0.5}; // Disabled text color',
                             'colorSelect[] = {1,1,1,1}; // Text selection color',
                             'colorSelect2[] = {1,1,1,1}; // Text selection color '
                             '(oscillates between this and colorSelect)',
                             'colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)',
                             'pictureColor[] = {1,1,1,1}; // Picture color',
                             'pictureColorSelect[] = {1,1,1,1}; // Selected picture color',
                             'pictureColorDisabled[] = {0,1,0,1}; // Disabled picture color']),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="HE Bombs",
                      tooltip="Cost: 10 points",
                      action=r'"closeDialog 0;[""HE""] spawn A3A_fnc_NATObomb;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Carpet Bombing",
                      tooltip="Cost: 10 points",
                      action=r'"closeDialog 0;[""CARPET""] spawn A3A_fnc_NATObomb;"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="NAPALM Bomb",
                      tooltip="Cost: 10 points",
                      action=r'"closeDialog 0;[""NAPALM""] spawn A3A_fnc_NATObomb;"'),
     ]
     },

    # Artillery sub menu for mortar types
    {'class origin': store_class_base('mortar_type'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select Mortar Ammo', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="HE",
                      action=r'"closeDialog 0;tipoMuni = SDKMortarHEMag;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Smoke",
                      action=r'"closeDialog 0; tipoMuni = SDKMortarSmokeMag;"'),
     ]
     },

    # Artillery sub menu for mortar round quantities
    {'class origin': store_class_base('rounds_number'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select No. Rounds to be fired', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('HQ_button_AS: RscButton',
                      text="1",
                      action=r'"closeDialog 0;rondas = 1"'),
         # TODO "closeDialog 0;rondas = 1;" ... this line is different from the other 7

         store_dialog('HQ_button_CONV: RscButton',
                      text="2",
                      action=r'"closeDialog 0;rondas = 2"'),

         store_dialog('HQ_button_DES: RscButton',
                      text="3",
                      action=r'"closeDialog 0; rondas = 3"'),

         store_dialog('HQ_button_LOG: RscButton',
                      text="4",
                      action=r'"closeDialog 0;rondas = 4"'),

         store_dialog('HQ_button_RES: RscButton',
                      text="5",
                      action=r'"closeDialog 0;rondas = 5"'),

         store_dialog('HQ_button_vehicle: RscButton',
                      text="6",
                      action=r'"closeDialog 0;rondas = 6"'),

         store_dialog('HQ_button_fpsplus: RscButton',
                      text="7",
                      action=r'"closeDialog 0; rondas = 7"'),

         store_dialog('HQ_button_AA: RscButton',
                      text="8",
                      action=r'"closeDialog 0;rondas = 8"'),
     ]
     },

    # Artillery sub menu for mortar strike type
    {'class origin': store_class_base('strike_type'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select type of strike', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Single Point Strike",
                      action=r'"closeDialog 0;tipoArty = ""NORMAL"";"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Barrage Strike",
                      action=r'"closeDialog 0; tipoArty = ""BARRAGE"";"'),
     ]
     },

    # A nato vehicle purchase screen
    {'class origin': store_class_base('NATO_player'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='SpecOp Menu', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Quadbike",
                      action=r'"closeDialog 0;[] call A3A_fnc_NATOQuadbike"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Fast Travel",
                      action=r'"closeDialog 0;[] spawn A3A_fnc_NATOFT"'),
     ]
     },

    # Artillery sub menu for large shell artillery strikes
    {'class origin': store_class_base('mbt_type'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select type ammo for the strike', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="HE",
                      action=r'"closeDialog 0;tipoMuni = ""32Rnd_155mm_Mo_shells"";"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Laser Guided",
                      action=r'"closeDialog 0; tipoMuni = ""2Rnd_155mm_Mo_LG"";"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="Smoke",
                      action=r'"closeDialog 0; tipoMuni = ""6Rnd_155mm_Mo_smoke"";"'),
     ]
     },

    # Squad recruitment type sub menu
    {'class origin': store_class_base('squad_options'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Squad Options', position='background_frame'),
         store_dialog('HQ_button_back: RscButton', text='Back', position='back_button',
                      action=r'"closeDialog 0;_nul = createDialog ""squad_recruit"";"'),

         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Normal Squad",
                      action=r'"closeDialog 0;nul = [gruposSDKSquad] spawn A3A_fnc_addFIAsquadHC;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Engineer Squad",
                      action=r'"closeDialog 0; nul = [gruposSDKSquadEng] spawn A3A_fnc_addFIAsquadHC;"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="MG Squad",
                      action=r'"closeDialog 0;nul = [gruposSDKSquadSupp,""MG""] spawn A3A_fnc_addFIAsquadHC;"'),

         store_dialog('HQ_button_unlock: RscButton',
                      text="Mortar Squad",
                      action=r'"closeDialog 0;nul = [gruposSDKSquadSupp,""Mortar""] spawn A3A_fnc_addFIAsquadHC;"'),
     ]
     },

    # Game mode difficulty submenu (Deprecated? I've never seen it)
    {'class origin': store_class_base('diff_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Choose difficulty', position='background_frame'),
         store_dialog('HQ_button_mortar: RscButton',
                      text="Easy",
                      action=r'"closeDialog 0;skillMult = 0.5"'),

         store_dialog('HQ_button_MG: RscButton',
                      text="Normal",
                      action=r'"closeDialog 0;"'),

         store_dialog('HQ_button_AT: RscButton',
                      text="Hard",
                      action=r'"closeDialog 0; skillMult = 2"'),
     ]
     },

    # Game mode difficulty menu (Deprecated? I've never seen it)
    {'class origin': store_class_base('gameMode_menu'),
     'class controls': [
         store_dialog('HQ_BOX: BOX', position='background'),
         store_dialog('HQ_frame: RscFrame', text='Select your Game Mode', position='background_frame'),
         store_dialog('HQ_button_Gsquad: RscButton',
                      text="Reb vs Gov vs Inv",
                      action=r'"closeDialog 0;gameMode = 1;"'),

         store_dialog('HQ_button_Gstatic: RscButton',
                      text="Rev vs Gov & Inv",
                      action=r'"closeDialog 0;gameMode = 2;"'),

         store_dialog('HQ_button_Gremove: RscButton',
                      text="Reb vs Gov",
                      action=r'"closeDialog 0;gameMode = 3;"'),

         store_dialog('HQ_button_offroad: RscButton',
                      text="Reb vs Inv",
                      action=r'"closeDialog 0;gameMode = 4"'),
     ]
     },

]

# Menu  Example
# {'class origin': store_class_base(''),
# 'class controls': [
#     store_dialog('HQ_BOX: BOX', position='background'),
#     store_dialog('HQ_frame: RscFrame', text='', position='background_frame'),
#     store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),
#     store_dialog('', text='', position='button',
#                  tooltip='',
#                  action=r''),
#         # Sub menu Example
#         {'class origin': store_class_base(''),
#          'class controls': [
#              store_dialog('HQ_BOX: BOX', position='background'),
#              store_dialog('HQ_frame: RscFrame', text='', position='background_frame'),
#              store_dialog('HQ_button_back: RscButton', text='Back', position='back_button', action=r'"closeDialog 0"'),
#          ]
#          },
# ]
# },


# This is the custom block for things not handled above.
# The code here is only appended to the bottom of the dialog.hpp file.
custom_block = """
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

"""

if __name__ == '__main__':
    build_dialog_file(r'C:\Users\uamadman\Documents\A3-Antistasi\A3-Antistasi\dialogs.hpp', dialog_map, custom_block)
