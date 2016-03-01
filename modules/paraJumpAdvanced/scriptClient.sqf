_c130j			= _this select 0;
_delay			= _this select 1;
_coordinates	= _this select 2;
_bearing		= _this select 3;

sleep _delay;

_helper = "Sign_Sphere10cm_F" createVehicleLocal (getPos player);
_helper setPosASL (_coordinates vectorAdd [0, 0, 1]);
_helper setDir (_bearing + 180);
_helper hideObject true;
player attachTo [_helper, [0, 0, 0]];

sleep 0.5;

detach player;
deleteVehicle _helper;

// détection du C130J
//_c130j = (nearestObjects [ASLToAGL _coordinates, ["C130J_static_EP1"], 25]) select 0; // problème de type de position ?

_c130j spawn {
	while {(player distance _this) < 1000} do {
		_this say3D ["C130Engine", 400];

		sleep 7.1;
	};
};

[_c130j, _bearing] spawn {
	_c130j		= _this select 0;
	_bearing	= _this select 1;
	waitUntil {(((getposASL player) vectorDiff (getPosASL _c130j)) select 2) <= 0};

	player allowDamage false;

	{
		sleep (_x select 0);
		player setVelocity [((sin _bearing) * (_x select 1)), ((cos _bearing) * (_x select 1)), (velocity player) select 2];
	} forEach [
		[0.5, 8],
		[0.5, 12],
		[0.5, 20],
		[0.5, 30],
		[0.5, 40],
		[0.5, 50],
		[0.5, 70],
		[1.5, 70]
	];

	sleep 1;

	player allowDamage true;
};