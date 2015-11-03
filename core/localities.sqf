X_server = false;
X_client = false;
X_init = false;

if (isServer) then {
	X_server = true;

	if (!isDedicated) then {
		X_client = true;
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