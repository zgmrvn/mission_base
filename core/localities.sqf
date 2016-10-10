X_server	= false;
X_client	= false;
X_editor	= false;
X_init		= false;
X_JIP		= false;

// cible pour les commandes type remoteExec
X_remote_server = 2;
X_remote_client = if (isDedicated) then {-2} else {0};

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