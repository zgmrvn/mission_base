/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

private _center								= param [0, [0, 0, 0], [[]], 3];
private _size								= param [1, [0, 0], [[]], 2];
private _direction							= param [2, 0, [0]];
private _side								= param [3, east, [sideUnknown]];
private _groupConfigPathOrClassnamesArray	= param [4]; // config du groupe ou tableau de classenames d'unités

// fonction de séléction d'une position dans une zone rectangulaire
private _fnc_findPos = {
	private _origin		= param [0, [0, 0, 0], [[]], 3];
	private _direction	= param [1, 0, [0]];
	private _size		= param [2, [0, 0], [[]], 2];

	// horizontal
	_origin	= [_origin, random (_size select 0), (_direction + 90) + 180 * (round (random 1))] call BIS_fnc_relPos;

	// vertical
	_origin	= [_origin, random (_size select 1), _direction + 180 * (round (random 1))] call BIS_fnc_relPos;

	_origin
};

// on détermine la position des points de passage
private _waypointsPositions = [];

for [{private _i = 4}, {_i > 0}, {_i = _i - 1}] do {
	_pos = [_center, _direction, _size] call _fnc_findPos;
	_waypointsPositions pushBack _pos;
};

// on créé le groupe
private _group = [
	_waypointsPositions select 0,
	_side,
	_groupConfigPathOrClassnamesArray
] call BIS_fnc_spawnGroup;

// on attribue les points de passage
deleteWaypoint [_group, 0];

private _formations = ["STAG COLUMN","VEE","ECH LEFT","ECH RIGHT","COLUMN","LINE"];

_group setFormation (selectRandom _formations);
_group setCombatMode "SAFE";
_group setBehaviour "RED";
_group setSpeedMode "LIMITED";

{
	_type = ["MOVE", "CYCLE"] select (_forEachIndex == ((count _waypointsPositions) - 1));

	_wp = _group addWaypoint [_waypointsPositions select _forEachIndex, 0];
	_wp setWaypointCompletionRadius 4;
	_wp setWaypointFormation (selectRandom _formations);
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointType _type;
} forEach _waypointsPositions;

_group
