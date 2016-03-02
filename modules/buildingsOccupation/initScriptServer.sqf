// si le module est activé
if ((getNumber (missionConfigFile >> "BuildingsOccupation" >> "enabled")) == 1) then {
	[] spawn {

		// récupération des classnames des untités à utiliser pour peupler les zones
		_units = getArray (missionConfigFile >> "BuildingsOccupation" >> "units");

		// boucle sur les zones
		{
			_handle = [_x, _units] spawn CRP_fnc_buildingsOccupation_area;
			waitUntil {scriptDone _handle};
		} forEach (getArray (missionConfigFile >> "BuildingsOccupation" >> "occupations"));
	};
};