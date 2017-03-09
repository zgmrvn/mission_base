/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

X_server	= false;
X_client	= false;
X_headless	= false;
X_editor	= false;
X_init		= false;
X_JIP		= false;

// cible pour les commandes type remoteExec
X_remote_server = 2;
X_remote_client = [0, -2] select isDedicated;

if (isServer) then {
	X_server = true;

	if (!isDedicated) then {
		X_client = true;
	};

	if (isServer && !isDedicated) then {
		X_editor = true;
	};

	X_init = true;
} else {
	X_client = true;

	if (!hasInterface) then {
		X_headless = true;
	};

	if (isNull player) then {
		X_JIP = true;

		[] spawn {
			waitUntil {!(isNull player)};

			X_init = true
		};
	} else {
		X_init = true;
	};
};
