/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "RandomPatrols" >> "enabled")) == 1) then {
	// spawn parce que code bloquant
	[] spawn {
		_return	= (getNumber (missionConfigFile >> "RandomPatrols" >> "return")) == 1;
		_pause	= getNumber (missionConfigFile >> "RandomPatrols" >> "pause");

		if (_return) then {
			CPR_var_randomPatrols_patrolAreas	= [];
			CPR_var_randomPatrols_ready			= false;
		};

		{
			_patrolArea = _x; // zone de patrouille courante

			_center		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "center");
			_radius		= getNumber (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "radius");
			_side		= getText (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "side");
			_groups		= getArray (missionConfigFile >> "RandomPatrols" >> "Patrols" >> _x >> "groups");

			// on détermine le side
			_side = toUpper _side;
			_side = switch (_side) do {
				case "WEST": {west};
				case "INDEP": {independent};
				default {east};
			};

			// reçoit les groupes d'une zone de patrouille dans le cas où return est demandé
			_patrols = [];

			{
				// pause entre chaque patrouille
				sleep _pause;

				_group = _x;

				// concaténation des différentes parties qui composent le chemin de la config du groupe
				_path = configFile >> "CfgGroups";
				{
					_path = _path >> _x;
				} forEach _group;

				// création de la patrouille
				_patrol = [_center, _radius, _side, _path] call CRP_fnc_randomPatrols_patrol;

				if (_return) then {
					_patrols pushBack _patrol;
				};
			} forEach _groups;

			// on stock les groupes d'une zone dans un tableau associatif
			if (_return) then {
				[CPR_var_randomPatrols_patrolAreas, _patrolArea, _patrols] call BIS_fnc_setToPairs;
			};
		} forEach ((missionConfigFile >> "RandomPatrols" >> "Patrols") call BIS_fnc_getCfgSubClasses);

		// fin
		if (_return) then {
			CPR_var_randomPatrols_ready = true;
		};
	};
};
