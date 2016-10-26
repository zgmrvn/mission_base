/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

_coordinates	= _this select 0;
_players		= _this select 1;
_boatData		= (getArray (missionConfigFile >> "BoatProjection" >> "boats")) select (_this select 2);
_boatClassname	= _boatData select 0;
_boatPlaces		= _boatData select 1;
_center			= getArray (missionConfigFile >> "BoatProjection" >> "center");
_dir			= [_coordinates, _center] call BIS_fnc_dirTo;

_boat = objNull;

for [{_i = 0; _c = count _players;}, {_i < _c}, {_i = _i + 1}] do {
	_mod = _i mod _boatPlaces;

	if (_mod == 0) then {
		_boat = createVehicle [_boatClassname, [_coordinates, (_i / 5) * 10, _dir + 135] call BIS_fnc_relPos, [], 0, "CAN_COLLIDE"];
		_boat setDir _dir;
	};

	// modification de la couleur du bateau dans le cas d'un RHIB
	if (_boatClassname == "C_Boat_Transport_02_F") then {
		[_boat, ["Black", 1], true] call BIS_fnc_initVehicle;
	};

	[[_boat, _mod], "modules\boatProjection\content\scriptClient.sqf"] remoteExec ["execVM", _players select _i];
};
