/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

private _center			= param [0, [0, 0, 0], [objNull, []], 3];
private _radius			= param [1, 100, [0]];
private _unitsCount		= param [2, 5, [0]];
private _side			= param [3, east, [sideUnknown]];
private _units			= param [4, [], [[]]];
private _keepPosition	= param [5, 0.5, [0]];

private _positions	= []; // toutes les positions trouvées dans la zone
private _buildings	= nearestObjects [_center, ["Building"], _radius];
private _return		= [];

// récupération de toutes les positons de bâtiments de la zone renseignée
{
	private _building = _x;

	if (isClass (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> (typeOf _building))) then {
		private _buildingsPositions = getArray (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> (typeOf _building) >> "positions");

		{
			_positions pushBack [_building, _x select 0, _x select 1];
		} forEach _buildingsPositions;
	};
} forEach _buildings;

_positions = _positions call CRP_fnc_realShuffle;
private _positionsCount = count _positions;

// on place les unités dans les bâtiments
// tant que le nombre d'unités créées est inférieur au nombre demandé
// et tant qu'il-y-a moins d'unités que le nombre de positions disponibles
for [{private _i = 0}, {(_i < _unitsCount) && {_i < _positionsCount}}, {_i = _i + 1}] do {
	private _position	= _positions select _i;
	private _building	= _position select 0;
	private _pos 		= _position select 1;
	private _dir		= _position select 2;

	private _group = createGroup _side;
	private _wp = _group addWaypoint [_pos, 0];
	deleteWaypoint [_group, (count (waypoints _group)) - 1];
	private _unit = _group createUnit [selectRandom _units, _building modelToWorld _pos, [], 0, "CAN_COLLIDE"];
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

	// si un poucentage d'unités fixes demandé
	// on désactive la capacité de l'ia à chercher un chemin
	if (_keepPosition != 0) then {
		if ((random 1) < _keepPosition) then {
			_unit disableAI "PATH";
		};
	};

	_return pushBack _unit;
};

_return
