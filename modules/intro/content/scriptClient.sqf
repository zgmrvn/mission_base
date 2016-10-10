// si le module est activé
if ((getNumber (missionConfigFile >> "Intro" >> "enabled")) == 1) then {
	_enabledInEditor = (getNumber (missionConfigFile >> "Intro" >> "enabledInEditor")) == 1;

	// si c'est une partie multi, que l'intro est activée dans les paramètres de mission et que le joueur n'est pas JIP
	// ou que l'on est en édition et que le paramètre pour jouer l'intro en édition est activé
	if ((isMultiplayer && (("PlayIntro" call BIS_fnc_getParamValue) == 1) && !X_JIP) || {_enabledInEditor}) then {
		// jouer l'intro
		execVM "modules\intro\intro.sqf";
	};
};
