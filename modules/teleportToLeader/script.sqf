// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "TeleportToLeader" >> "enabled")) == 0) exitWith {};

// quitter si le module de drapeaux n'est pas activé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 0) exitWith {hint "le module ""TeleportToLeader"" a besoin du module ""ActionsFlags"""};

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
				"Téléportation vers un chef d'équipe",
				{createDialog "TeleportToLeaderDialog"},
				nil,
				1.5,
				true,
				true,
				"",
				"(_target distance player) < 6"
			];
		} else {
			hint format ["TeleportToleader : le drapeau ""%1"" n'existe pas", _x];
		};
	} forEach (getArray (missionConfigFile >> "TeleportToLeader" >> "flags"));
};