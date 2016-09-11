_playerPosition	= _this select 0;
_coordinates	= _this select 1;
_bearing		= _this select 2;

_c130j = createVehicle ["C130J_static_EP1", _playerPosition, [], 0, "CAN_COLLIDE"];
_c130j setDir _bearing;

sleep 1;

_c130j setPosASL _coordinates;

waitUntil {(count (nearestObjects [_c130j, ["Man"], 50])) > 0};
waitUntil {(count (nearestObjects [_c130j, ["Man"], 50])) == 0};

sleep 10;

deleteVehicle _c130j;