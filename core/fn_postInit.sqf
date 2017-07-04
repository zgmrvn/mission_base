/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

if (!isDedicated) then {
	if (isNull player) then {
		X_JIP = true;

		[] spawn {
			waitUntil {!(isNull player)};

			X_init = true;
		};
	} else {
		X_init = true;
	};
};
