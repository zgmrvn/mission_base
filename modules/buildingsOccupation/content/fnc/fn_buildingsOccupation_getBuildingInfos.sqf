/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

private ["_building"];
_building = typeOf ((nearestObjects [player, ["Building"], 50]) select 0);

[_building, isClass (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> _building)]
