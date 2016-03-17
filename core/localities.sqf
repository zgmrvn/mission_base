X_server	= false;
X_client	= false;
X_editor	= false;
X_init		= false;

// cible pour les commandes type remoteExec
X_remote_server = if (isDedicated) then {2} else {0};
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
		[] spawn {
			waitUntil {!(isNull player)};

			X_init = true
		};
	} else {
		X_init = true;
	};
};

waitUntil {X_init};
waitUntil {time > 0};