_boatCoordinates	= _this select 0;
_coastCoordinates	= _this select 1;
_players			= _this select 2;
_boatData			= (getArray (missionConfigFile >> "TaxiBoat" >> "boats")) select (_this select 3);
_boatClassname		= _boatData select 0;
_boatPlaces			= _boatData select 1;
_dir				= [_boatCoordinates, _coastCoordinates] call BIS_fnc_dirTo;

_playerCount = count _players;
_currentPlayer = 0;
_i = 0;

while {_currentPlayer < _playerCount} do {
	_places = _boatPlaces;

	_coast = [_coastCoordinates, _i * 15, ([_boatCoordinates, _coastCoordinates] call BIS_fnc_dirTo) + 90] call BIS_fnc_relPos;

	// création du bateau
	_boat = createVehicle [_boatClassname, [_boatCoordinates, _i * 15, _dir + 135] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
	_boat setDir _dir;

	// modification de la couleur du bateau dans le cas d'un RHIB
	if (_boatClassname == "C_Boat_Transport_02_F") then {
		[_boat, ["Black", 1], true] call BIS_fnc_initVehicle;
	};

	// création du conducteur
	_group = createGroup west;
	_unit = _group createUnit ["B_CTRG_Soldier_tna_F", [0,0,0], [], 0, "FORM"];
	_unit moveInDriver _boat;
	_places = _places - 1;

	// équipement du conducteur
	_unit execVM "modules\taxiBoat\content\gear.sqf";

	// waypoints
	deleteWaypoint [_group, 0];

	_distance = 100;

	_wp = _group addWaypoint [[_coast, _distance, _dir + 180] call BIS_fnc_relPos, 0];
	_wp setWaypointCompletionRadius 10;
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "BLUE";
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointStatements ["true", format ["[this, %1, %2] execVM 'modules\taxiBoat\content\slowDown.sqf';", _coast, _distance]];


	_wp = _group addWaypoint [_coast, 0];
	_wp setWaypointCompletionRadius 10;
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointCombatMode "BLUE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointType "MOVE";
	_wp setWaypointStatements ["true", format ["[this, %1, %2] execVM 'modules\taxiBoat\content\unload.sqf';", _coast, _boatCoordinates]];

	// embarquement des joueurs
	while {_places > 0} do {
		[[_boat, _places], "modules\taxiBoat\content\scriptClient.sqf"] remoteExec ["execVM", _players select _currentPlayer];

		_places = _places - 1;
		_currentPlayer = _currentPlayer + 1;
	};

	_i = _i + 1;
};