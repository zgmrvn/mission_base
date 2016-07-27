params ["_center", "_radius", "_side", "_groupName"];
private ["_rotation", "_return", "_expression", "_path", "_waypointsPositions", "_waypointsCount", "_part", "_angle", "_i", "_group", "_formations"];

_rotation = if ((random 1) > 0.5) then {1} else {-1};
_return	= if (count _this > 4) then {true} else {false};

// on retrouve le chemin config du groupe passé
_expression = format ["configName(_x) == '%1'", _groupName];
_path = "";

{
	_res = _expression configClasses (configFile >> "CfgGroups" >> _side >> _x >> "Infantry");

	if ((count _res) > 0) exitWith {
		_path = _res select 0;
	};
} forEach ((configFile >> "CfgGroups" >> _side) call BIS_fnc_getCfgSubClasses);

// on calcule le nombre de waypoints et leurs positions
_waypointsPositions = [_center];

_waypointsCount = round (_radius / 12);
_part = 360 / _waypointsCount;
_angle = random 360;

for [{_i = _waypointsCount}, {_i > 0}, {_i = _i - 1}] do {
	_pos = [_center, (_radius / 2) + (random _radius / 2), _angle + (_part * _i * _rotation)] call BIS_fnc_relPos,
	_waypointsPositions pushBack _pos;
};

// on détermine le side
_side = switch (_side) do {
	case "West": {west};
	case "East": {east};
	case "Indep": {independent};
};

// on créé le groupe
_group = [
	_waypointsPositions select 0,
	_side,
	_path
] call BIS_fnc_spawnGroup;

// on attribue les points de passage
deleteWaypoint [_group, 0];

_formations = ["STAG COLUMN","VEE","ECH LEFT","ECH RIGHT","COLUMN","LINE"];

_group setFormation (_formations call BIS_fnc_selectRandom);
_group setCombatMode "SAFE";
_group setBehaviour "RED";
_group setSpeedMode "LIMITED";

{
	_type = if (_forEachIndex == ((count _waypointsPositions) - 1)) then {"CYCLE"} else {"MOVE"};

	_wp = _group addWaypoint [_waypointsPositions select _forEachIndex, 0];
	_wp setWaypointCompletionRadius 4;
	_wp setWaypointFormation (_formations call BIS_fnc_selectRandom);
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointType _type;
} forEach _waypointsPositions;

// si option activée, on retoune les groupes dans un tableau global
if (_return) then {
	(_this select 4) pushBack _group;
};