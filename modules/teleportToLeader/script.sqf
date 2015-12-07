// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "TeleportToLeader" >> "enabled")) == 0) exitWith {};

// quitter si le module de drapeaux n'est pas activé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 0) exitWith {hint "le module ""TeleportToLeader"" a besoin du module ""ActionsFlags"""};

[] spawn {
	waitUntil {!isNil {CRP_var_actionsFlags_flags}};

	{
		(_x call CRP_fnc_actionsFlags_getFlag) addAction [
			"Téléportation vers un chef d'équipe",
			{createDialog "TeleportToLeaderDialog"},
			nil,
			1.5,
			true,
			true,
			"",
			"(_target distance player) < 6"
		];
	} forEach (getArray (missionConfigFile >> "TeleportToLeader" >> "flags"));
};