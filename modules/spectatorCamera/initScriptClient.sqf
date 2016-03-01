// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "SpectatorCamera" >> "enabled")) == 0) exitWith {};

// quitter si le module de drapeaux n'est pas activé
if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 0) exitWith {hint "le module ""SpectatorCamera"" a besoin du module ""ActionsFlags"""};

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
				"Caméra Spectateur",
				{createDialog "SpectatorCameraDialog"},
				nil,
				1.5,
				true,
				true,
				"",
				"(_target distance player) < 6"
			];
		} else {
			hint format ["SpectatorCamera : le drapeau ""%1"" n'existe pas", _x];
		};
	} forEach (getArray (missionConfigFile >> "SpectatorCamera" >> "flags"));
};