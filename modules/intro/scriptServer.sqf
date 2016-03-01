// si le module est activé
if ((getNumber (missionConfigFile >> "Intro" >> "enabled")) == 1) then {
	_enabledInEditor = (getNumber (missionConfigFile >> "Intro" >> "enabledInEditor")) == 1;

	if (_enabledInEditor || isDedicated) then {
		// si l'intro est activée dans les paramètres de mission
		if (("PlayIntro" call BIS_fnc_getParamValue) == 1) then {
			// on attend que le serveur ait initialisé la variable dont on a besoin
			// le thread dans lequel on se trouve a été initialisé par initPlayerServer.sqf
			// mais la variable est créée dans un thread initié par init.sqf
			waitUntil {!isNil {CRP_var_intro_alreadyConnected}};

			_name = name _player;

			// si le nom du joueur n'est pas déjà référencé
			if !(_name in CRP_var_intro_alreadyConnected) exitWith {
				// on le référence
				CRP_var_intro_alreadyConnected pushBack _name;

				// puis on dit au joueur de jouer l'intro
				[[], "modules\intro\intro.sqf"] remoteExec ["BIS_fnc_execVM", _player];
			};
		};
	};
};