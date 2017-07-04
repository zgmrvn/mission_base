/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

X_server	= false;
X_client	= false;
X_headless	= false;
X_editor	= false;
X_JIP		= false; // post init
X_init		= false; // post init

// cible pour les commandes type remoteExec
X_remote_server = 2;
X_remote_client = [0, -2] select isDedicated;

// serveur
if (isServer) then {
	X_server = true;

	if (!isDedicated) then {
		X_client = true;
		X_editor = true;
	};

	X_init = true;
};

// client
if (!isDedicated) then {
	X_client = true;

	if (!hasInterface) then {
		X_headless = true;
	};
};
