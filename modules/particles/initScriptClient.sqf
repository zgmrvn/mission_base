// si le module est activé
if ((getNumber (missionConfigFile >> "Particles" >> "enabled")) == 1) then {
	// on boucle sur tous les effets
	{
		_effect = _x;

		// si l'effet est activé
		if ((getNumber (missionConfigFile >> "Particles" >> "Effects" >> _effect >> "enabled")) == 1) then {
			_effect spawn {
				_script		= getText (missionConfigFile >> "Particles" >> "Effects" >> _this >> "script");
				_radius		= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "radius");
				_expression	= getText (missionConfigFile >> "Particles" >> "Effects" >> _this >> "expression");
				_precision	= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "precision");
				_sources	= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "sources");
				_duration	= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "duration");
				_threshold	= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "threshold");
				_sleep		= getNumber (missionConfigFile >> "Particles" >> "Effects" >> _this >> "sleep");

				// pour éviter d'avoir plusieurs boucles d'effet sur le même tick
				sleep (random 1);

				while {true} do {
					_places = selectBestPlaces [ASLToATL (getPosASL player), _radius, _expression, _precision, _sources];

					// si au moins une position a été trouvée
					if ((count _places) > 0) then {
						{


							if ((_x select 1) > _threshold) exitWith {
								_place = _x select 0;
								[[_place select 0, _place select 1, 0], _duration] execVM (format ["modules\particles\effects\%1.sqf", _script]);
							};
						} forEach _places;
					};

					sleep _sleep;
				};
			};
		};
	} forEach ((missionConfigFile >> "Particles" >> "Effects") call BIS_fnc_getCfgSubClasses);
};