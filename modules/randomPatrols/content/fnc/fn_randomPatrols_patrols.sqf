/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

private _center		= param [0, [0, 0, 0], [objNull, []], 3];
private _radius		= param [1, 100, [0]];
private _side		= param [2, west, [sideUnknown]];
private _configPath	= param [3]; // config

private _rotation = [-1, 1] select ((random 1) > 0.5); // horaire, anti-horaire

// tous les groupes passent par le centre de la zone
private _waypointsPositions = [_center];

// on calcule le nombre de waypoints et leurs positions
private _waypointsCount = round (_radius / 12);
private _part = 360 / _waypointsCount;
private _angle = random 360;

for [{private _i = _waypointsCount}, {_i > 0}, {_i = _i - 1}] do {
	_pos = [_center, (_radius / 2) + (random _radius / 2), _angle + (_part * _i * _rotation)] call BIS_fnc_relPos,
	_waypointsPositions pushBack _pos;
};

// on créé le groupe
private _group = [
	_waypointsPositions call BIS_fnc_selectRandom,
	_side,
	_configPath
] call BIS_fnc_spawnGroup;

// on attribue les points de passage
deleteWaypoint [_group, 0];

private _formations = ["STAG COLUMN","VEE","ECH LEFT","ECH RIGHT","COLUMN","LINE"];

_group setFormation (_formations call BIS_fnc_selectRandom);
_group setCombatMode "SAFE";
_group setBehaviour "RED";
_group setSpeedMode "LIMITED";

{
	_type = ["MOVE", "CYCLE"] select (_forEachIndex == ((count _waypointsPositions) - 1));

	_wp = _group addWaypoint [_waypointsPositions select _forEachIndex, 0];
	_wp setWaypointCompletionRadius 4;
	_wp setWaypointFormation (_formations call BIS_fnc_selectRandom);
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointType _type;
} forEach _waypointsPositions;

_group
