_coordinates	= _this select 0;
_bearing		= _this select 1;

_c130j = createVehicle ["C130J_static_EP1", _coordinates, [], 0, "CAN_COLLIDE"];
_c130j setPosASL _coordinates;
_c130j setDir _bearing;

waitUntil {(count (nearestObjects [_c130j, ["Man"], 50])) > 0};
waitUntil {(count (nearestObjects [_c130j, ["Man"], 50])) == 0};

sleep 10;

deleteVehicle _c130j;