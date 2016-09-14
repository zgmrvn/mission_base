params ["_center", "_radius", "_unitsCount", "_side", "_units"];
private ["_positions", "_buildings", "_return", "_i"];

_positions	= [];
_buildings	= nearestObjects [_center, ["Building"], _radius];
_return		= if (count _this > 5) then {true} else {false};

_side = switch (_side) do {
	case "West": {west};
	case "East": {east};
	case "Indep": {independent};
	case "Civ": {civilian};
};

// récupération de toutes les positons de bâtiments de la zone renseignée
{
	_building = _x;

	if (isClass (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> (typeOf _building))) then {
		_buildingsPositions = getArray (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> (typeOf _building) >> "positions");

		{
			_positions pushBack [_building, _x select 0, _x select 1];
		} forEach _buildingsPositions;
	};
} forEach _buildings;

_positions = _positions call CRP_fnc_realShuffle;
_positionsCount = count _positions;

// on place les unités dans les bâtiments
// tant que le nombre d'unités créées est inférieur au nombre demandé
// et tant qu'il-y-a moins d'unités que le nombre de positions disponibles
for [{_i = 0}, {(_i < _unitsCount) && (_i < _positionsCount)}, {_i = _i + 1}] do {
	_position	= _positions select _i;
	_building	= _position select 0;
	_pos 		= _position select 1;
	_dir		= _position select 2;

	_group = createGroup _side;
	_wp = _group addWaypoint [_pos, 0];
	deleteWaypoint [_group, (count (waypoints _group)) - 1];
	_unit = _group createUnit [_units call BIS_fnc_selectRandom, _building modelToWorld _pos, [], 0, "CAN_COLLIDE"];
	_unit setPos (_building modelToWorld _pos);
	_group setFormDir ((getDir _building) + _dir);
	_group setCombatMode "RED";
	_group setBehaviour "SAFE";
	_group setSpeedMode "LIMITED";
	_wp setWaypointType "HOLD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointCompletionRadius 3;
	_unit setUnitPos "UP";

	if (_return) then {
		(_this select 2) pushBack _unit;
	};
};