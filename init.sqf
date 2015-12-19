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

	/*************************************************
	***** script de développement et de débogage *****
	***** À SUPPRIMER                            *****
	*************************************************/
	[] execVM "mission\dev.sqf";
	/*************************************************
	*************************************************/

	// write whatever you whant
};

if (X_client) then {
	// default client settings and actions
	#include "core\defaultClient.sqf"

	// write whatever you whant
};