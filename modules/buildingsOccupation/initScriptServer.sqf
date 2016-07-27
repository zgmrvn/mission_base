// si le module est activé
if ((getNumber (missionConfigFile >> "BuildingsOccupation" >> "enabled")) == 1) then {

	[] spawn {
		// boucle sur les zones
		if ((getNumber (missionConfigFile >> "BuildingsOccupation" >> "return")) == 1) then {
			CPR_var_buildingsOccupation_units = [];

			{
				_center		= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "center");
				_radius		= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "radius");
				_unitsCount	= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "unitsCount");
				_side		= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "side");
				_units		= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "units");

				_handle = [_center, _radius, _unitsCount, _side, _units, CPR_var_buildingsOccupation_units] spawn CRP_fnc_buildingsOccupation_area;
				waitUntil {scriptDone _handle};
			} forEach ((missionConfigFile >> "BuildingsOccupation" >> "Occupations") call BIS_fnc_getCfgSubClasses);
		} else {
			{
				_center		= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "center");
				_radius		= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "radius");
				_unitsCount	= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "unitsCount");
				_side		= getNumber (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "side");
				_units		= getArray (missionConfigFile >> "BuildingsOccupation" >> "Occupations" >> _x >> "units");

				_handle = [_center, _radius, _unitsCount, _side, _units] spawn CRP_fnc_buildingsOccupation_area;
				waitUntil {scriptDone _handle};
			} forEach ((missionConfigFile >> "BuildingsOccupation" >> "Occupations") call BIS_fnc_getCfgSubClasses);
		};
	};
};