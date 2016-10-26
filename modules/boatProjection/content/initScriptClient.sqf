/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "BoatProjection" >> "enabled")) == 1) then {
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
						"Insertion en bateau",
						{CRP_var_boatProjection_flag = (_this select 0); createDialog "BoatProjectionDialog";},
						nil,
						1.5,
						true,
						true,
						"",
						"(_target distance player) < 6"
					];
				} else {
					hint format ["BoatProjection : le drapeau ""%1"" n'existe pas", _x];
				};
			} forEach (getArray (missionConfigFile >> "BoatProjection" >> "flags"));
		};
	} else {
		hint "le module ""BoatProjection"" a besoin du module ""ActionsFlags""";
	};
};
