/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "BuildingsOccupation" >> "enabled")) == 1) then {
	// spawn parce que code bloquant
	[] spawn {
		_return	= (getNumber (missionConfigFile >> "BuildingsOccupation" >> "return")) == 1;
		_pause	= getNumber (missionConfigFile >> "BuildingsOccupation" >> "pause");

		if (_return) then {
			CPR_var_buildingsOccupation_occupation	= [];
			CPR_var_buildingsOccupation_ready		= false;
		};

		// boucle sur les zones d'occupation
		{
			// pause entre chaque zone d'occupation
			sleep _pause;

			_center			= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "center");
			_radius			= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "radius");
			_unitCount		= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "unitCount");
			_side			= getText (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "side");
			_units			= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "units");
			_keepPosition	= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "keepPosition");

			// on détermine le side
			_side = toUpper _side;
			_side = switch (_side) do {
				case "WEST": {west};
				case "INDEP": {independent};
				case "CIV": {civilian};
				default {east};
			};

			// si le module aiMultiplier est activé et que l'on est en multijoueur
			if (isMultiplayer && {(getNumber (missionConfigFile >> "aiMultiplier" >> "enabled")) == 1}) then {
				_multiplier = "aiMultiplier" call BIS_fnc_getParamValue;

				if (_multiplier != 1) then {
					_unitCount = round (_unitCount * _multiplier);
				};
			};

			// création des unités
			_occupation = [_center, _radius, _unitCount, _side, _units, _keepPosition] call CRP_fnc_buildingsOccupation_occupation;

			if (_return) then {
				[CPR_var_buildingsOccupation_occupation, _x, _occupation] call BIS_fnc_setToPairs;
			};
		} forEach ((missionConfigFile >> "BuildingsOccupation" >> "Occupations") call BIS_fnc_getCfgSubClasses);

		// fin
		if (_return) then {
			CPR_var_buildingsOccupation_ready = true;
		};
	};
};
