/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "AreaPatrols" >> "enabled")) == 1) then {
	// spawn parce que code bloquant
	[] spawn {
		_return	= (getNumber (missionConfigFile >> "AreaPatrols" >> "return")) == 1;
		_pause	= getNumber (missionConfigFile >> "AreaPatrols" >> "pause");

		if (_return) then {
			CPR_var_areaPatrols_patrolAreas	= [];
			CPR_var_areaPatrols_ready		= false;
		};

		{
			_patrolArea = _x; // zone de patrouille courante

			_center		= getArray (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "center");
			_size		= getArray (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "size");
			_direction	= getNumber (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "direction");
			_side		= getText (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "side");
			_groups		= getArray (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "groups");
			_debug		= (getNumber (missionConfigFile >> "AreaPatrols" >> "Patrols" >> _x >> "debug")) == 1;

			// on détermine le side
			_side = toUpper _side;
			_side = switch (_side) do {
				case "WEST": {west};
				case "INDEP": {independent};
				default {east};
			};

			// on divise les dimensions finales par 2
			// pour que le marqeur final fasse les dimensions indiquées et non pas le double
			_size set [0, (_size select 0) * 0.5];
			_size set [1, (_size select 1) * 0.5];

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
					_group = _group call BIS_fnc_arrayShuffle;
				};

				// création de la patrouille
				_patrol = [_center, _size, _direction, _side, _group] call CRP_fnc_areaPatrols_patrol;

				if (_return) then {
					_patrols pushBack _patrol;
				};
			} forEach _groups;

			// si débug, création du marqueur
			if (_debug) then {
				_marker = createMarker [_patrolArea, _center];
				_marker setMarkerShape "RECTANGLE";
				_marker setMarkerDir _direction;
				_marker setMarkerSize _size;
				_marker setMarkerBrush "Border";
				_marker setMarkerColor (format ["Color%1", _side]);
			};

			// on stock les groupes d'une zone dans un tableau associatif
			if (_return) then {
				[CPR_var_areaPatrols_patrolAreas, _patrolArea, _patrols] call BIS_fnc_setToPairs;
			};
		} forEach ((missionConfigFile >> "AreaPatrols" >> "Patrols") call BIS_fnc_getCfgSubClasses);

		// fin
		if (_return) then {
			CPR_var_AreaPatrols_ready = true;
		};
	};
};
