_driver		= _this select 0;
_boat		= vehicle _driver;
_coast		= _this select 1;
_return		= _this select 2;

// on supprime tous les points de passage
while {(count (waypoints (group _driver))) > 0} do {
	deleteWaypoint ((waypoints (group _driver)) select 0);
};

// oon attend que le bateau soit vide
waitUntil {count (crew _boat) == 1};

sleep (4 + (random 4));

// on repousse le bateau
_i = 0;
_start = getPosASL _boat;
_end = [_start, 50, (getDir _boat) + 180] call BIS_fnc_relPos;

while {_i < 1} do {
	_boat setVelocityTransformation [
		_start,
		_end,
		(vectorDirVisual _boat) vectorMultiply -2,
		(vectorDirVisual _boat) vectorMultiply -2,
		vectorDir _boat,
		vectorDir _boat,
		[0,0,0],
		[0,0,0],
		_i
	];

	_i = _i + 1 / 150;
	sleep 0.33;
};

// point de retour du bateau
_wp = (group _driver) addWaypoint [_return, 0];
_wp setWaypointCompletionRadius 50;
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointCombatMode "BLUE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true", "deleteVehicle (vehicle this); deleteVehicle this;"];