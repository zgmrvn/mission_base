// post init functions declaration
// these functions can't be used in editor
#include "functions\functions.sqf"

// localities definition
// and initialization awaiting
#include "core\localities.sqf"

// from here both client and server are ready
// write whatever you whant
[
	scriptingAmmoBox,
	"<t color='#FF0000'>custom from scripting 1</t>",
	"mission\addActionScript.sqf",
	"test1",
	false,
	true
] call CRP_fnc_addActionGlobal;

[
	scriptingAmmoBox,
	"<t color='#FF0000'>2e action</t>",
	"mission\addActionScript.sqf",
	"test5",
	false,
	true
] call CRP_fnc_addActionGlobal;

[
	scriptingAmmoBox2,
	"<t color='#FF0000'>custom from scripting 2</t>",
	"mission\create.sqf",
	"test2",
	true,
	true
] call CRP_fnc_addActionGlobal;

if (!isNil {scriptingAmmoBox3}) then {
	[
		scriptingAmmoBox3,
		"<t color='#FF0000'>removed object</t>",
		objNull,
		"destroyed",
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