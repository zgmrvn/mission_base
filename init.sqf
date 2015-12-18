// post init functions declaration
// these functions can't be used in editor
#include "functions\functions.sqf"

// localities definition
// and initialization awaiting
#include "core\localities.sqf"

// from here both client and server are ready
// write whatever you whant

if (X_server) then {
	// default server settings and actions
	#include "core\defaultServer.sqf"





	/*************************************
	****** test pour la camera ***********
	*************************************/

	[] spawn {
		while {true} do {
			_group = createGroup east;
			_unit = _group createUnit ["O_Soldier_TL_F", [[7522, 7514, 0], 50, random 360] call BIS_fnc_relPos, [], 0, "FORM"];
			_unit setBehaviour "CARELESS";
			_group addWaypoint [[_unit, 75, random 360] call BIS_fnc_relPos, 0];

			sleep (10 + (random 10));

			_unit setDamage 1;
		};
	};

	/**************************************/




	// write whatever you whant
};

if (X_client) then {
	// default client settings and actions
	#include "core\defaultClient.sqf"

	// write whatever you whant
};