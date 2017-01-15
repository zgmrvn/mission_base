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

			// si le module aiMultiplier est activé et que l'on est en multijoueur
			if (isMultiplayer && {(getNumber (missionConfigFile >> "aiMultiplier" >> "enabled")) == 1}) then {
				_multiplier = "aiMultiplier" call BIS_fnc_getParamValue;

				if (_multiplier != 1) then {
					_groupCountBefore	= count _groups;
					_groupCountAfter	= round (_groupCountBefore * _multiplier);

					// s'il faut réduire le nombre de groupes créés
					if (_multiplier < 1) then {
						if ((_groupCountAfter > 0) && {(_groupCountBefore - _groupCountAfter) > 0}) then {
							for "_i" from _groupCountBefore to (_groupCountAfter + 1) step -1 do {
								_groups deleteAt ((count _groups) - 1);
							};
						};
					};

					// s'il faut augmenter le nombre de groupes créés
					if (_multiplier > 1) then {
						_groupsTemp = _groups;

						if ((_groupCountAfter - _groupCountBefore) > 0) then {
							for "_i" from _groupCountBefore to (_groupCountAfter - 1) do {
								_groups pushBack (selectRandom _groupsTemp);
							};
						};
					};
				};
			};

			// reçoit les groupes d'une zone de patrouille dans le cas où return est demandé
			_patrols = [];

			{
				// pause entre chaque patrouille
				sleep _pause;

				_group = _x;

				// on détermine si la donnée est une config de groupe ou un tableau de classenames d'unités
				_customGroup = !((_group select 0) in ["West", "East", "Indep"]);

				// si on est dans le cas d'une config de groupe et pas un groupe custom
				// concaténation des différentes parties qui composent le chemin de la config
				// sinon, le tableau _group sera directement passé à la fonction de création du groupe
				if (!_customGroup) then {
					_path = configFile >> "CfgGroups";
					{
						_path = _path >> _x;
					} forEach _group;

					_group = _path;
				};

				// dans le cas d'un groupe custom, mélange du tableau des classnames
				if (_customGroup) then {
					_group = _group call CRP_fnc_realShuffle;
				};

				// création de la patrouille
				_patrol = [_center, _radius, _side, _group] call CRP_fnc_randomPatrols_patrol;

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
