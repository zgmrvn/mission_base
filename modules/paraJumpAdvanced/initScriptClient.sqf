// si le module est désactivé
if ((getNumber (missionConfigFile >> "ParaJumpAdvanced" >> "enabled")) == 1) then {
	// si le mod qui contient le C130J (CUP) est chargé
	if (isClass (configFile >> "CfgVehicles" >> "C130J_static_EP1")) then {
		// si le module de drapeaux est activé
		if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 1) then {
			[] spawn {
				waitUntil {!isNil {CRP_var_actionsFlags_flags}};

				_flagsTemp = getArray (missionConfigFile >> "ActionsFlags" >> "flags");
				_flags = [];
				{
					_flags pushBack (_x select 0);
				} forEach _flagsTemp;

				{
					if (_x in _flags) then {
						(_x call CRP_fnc_actionsFlags_getFlag) addAction [
							"ParaJump avancé",
							{CRP_var_paraJumpAdvanced_flag = (_this select 0); createDialog "ParaJumpAdvancedDialog";},
							nil,
							1.5,
							true,
							true,
							"",
							"(_target distance player) < 6"
						];
					} else {
						hint format ["ParaJumpAdvanced : le drapeau ""%1"" n'existe pas", _x];
					};
				} forEach (getArray (missionConfigFile >> "ParaJumpAdvanced" >> "flags"));
			};
		} else {
			hint "le module ""ParaJumpAdvanced"" a besoin du module ""ActionsFlags""";
		};
	} else {
		hint "le mode qui contient le C130J (CUP) n'est pas chargé";
	};
};