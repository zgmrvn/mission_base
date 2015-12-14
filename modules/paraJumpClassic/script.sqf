// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "ParaJumpClassic" >> "enabled")) == 0) exitWith {};

// quitter si le module de drapeaux n'est pas activé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 0) exitWith {hint "le module ""ParaJumpClassic"" a besoin du module ""ActionsFlags"""};

[] spawn {
	waitUntil {!isNil {CRP_var_actionsFlags_flags}};

	{
		(_x call CRP_fnc_actionsFlags_getFlag) addAction [
			"ParaJump classique",
			{CRP_var_paraJumpClassic_flag = (_this select 0); createDialog "ParaJumpClassicDialog";},
			nil,
			1.5,
			true,
			true,
			"",
			"(_target distance player) < 6"
		];
	} forEach (getArray (missionConfigFile >> "ParaJumpClassic" >> "flags"));
};