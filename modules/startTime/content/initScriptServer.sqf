/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// spawn pour éviter le bloquage
[] spawn {
	// il faut attendre que le serveur soit prêt et que la mission ait démarrée
	// sinon l'heure est réglée à 0 h 00
	waitUntil {X_init};
	waitUntil {time > 0};

	// si le module est activé
	if ((getNumber (missionConfigFile >> "StartTime" >> "enabled")) == 1) then {
		_time = "StartTime" call BIS_fnc_getParamValue;

		// si une heure a été selectionnée
		if (_time >= 0) then {
			_time spawn {
				_date = date;
				setDate [_date select 0, _date select 1, _date select 2, _this, 0];
			};
		};
	};
};
