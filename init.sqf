// post init functions declaration
// these functions can't be used in editor
#include "functions\functions.sqf"

// localities definition
// and initialization awaiting
#include "core\localities.sqf"

// from here both client and server are ready
// write whatever you whant
/*
if (!isDedicated) then {
	_clientBox = createVehicle ["B_supplyCrate_F", [7515,7456,0], [], 0, "NONE"];
	[
		_clientBox,
		"<t color='#FF0000'>client</t>",
		"mission\addActionScript.sqf",
		"client",
		false,
		true
	] call CRP_fnc_addActionGlobal;
};
*/
if (isServer) then {
	_serverBox = createVehicle ["B_supplyCrate_F", [7520,7456,0], [], 0, "NONE"];

	[
		_serverBox,
		"<t color='#FF0000'>Première action ajoutée depuis le serveur</t>",
		"mission\addActionScript.sqf",
		"serverSideAction1",
		false,
		true
	] call CRP_fnc_addActionGlobal;

	[
		_serverBox,
		"<t color='#FF0000'>Deuxième action ajoutée depuis le serveur</t>",
		"mission\addActionScript.sqf",
		"serverSideAction2",
		true,
		true
	] call CRP_fnc_addActionGlobal;
};

if (X_server) then {
	// default server settings and actions
	#include "core\defaultServer.sqf"

	// write whatever you whant
};

if (X_client) then {
	// default client settings and actions
	#include "core\defaultClient.sqf"

	// write whatever you whant
};