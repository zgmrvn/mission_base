/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "SpectatorCamera" >> "enabled")) == 1) then {
	// si le module de drapeaux est activé
	if ((getNumber (missionConfigFile >> "ActionsFlags" >> "enabled")) == 1) then {
		[] spawn {
			// on attend les informations d'objets créés par le serveur
			waitUntil {!isNil {CRP_var_actionsFlags_flags}};

			// on récupère les noms des drapeaux existants
			_flagsTemp = getArray (missionConfigFile >> "ActionsFlags" >> "flags");
			_flags = [];
			{
				_flags pushBack (_x select 0);
			} forEach _flagsTemp;

			// puis on ajoute l'action sur les drapeaux souhaités
			{
				if (_x in _flags) then {
					(_x call CRP_fnc_actionsFlags_getFlag) addAction [
						"Caméra Spectateur",
						{
							// création de la caméra spéctateur
							["Initialize", [
								player,	// spectator
								[],		// WhitelistedSides
								true,	// allowAi
								true,	// allowFreeCamera
								true,	// allow3PPCamera
								true,	// showFocusInfo
								true,	// showCameraButtons
								true,	// showControlsHelper
								true,	// showHeader
								true 	// showLists
							]] spawn BIS_fnc_EGSpectator;

							// on attend que le display existe
							waitUntil {!isNull (findDisplay 60492)};

							// puis on ajoute la posibilité de fermer la caméra en appuyant sur la touche échappe
							// par défaut il n'y a aucun moyen de fermer la caméra une fois ouverte
							_eh = (findDisplay 60492) displayAddEventHandler ["KeyDown", {
								_override = false;

								if ((_this select 1) == 1) then {
									["Terminate"] spawn BIS_fnc_EGSpectator;
									_override = true;
								};

								_override
							}];
						},
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
	} else {
		hint "le module ""SpectatorCamera"" a besoin du module ""ActionsFlags""";
	};
};
