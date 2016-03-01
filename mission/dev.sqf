/*******************************************
***** spawn d'IA pour le développement *****
***** de la caméra spectateur          *****
*******************************************/
[] spawn {
	while {true} do {
		_group = createGroup east;
		_unit = _group createUnit ["O_Soldier_TL_F", [[7522, 7514, 0], 50, random 360] call BIS_fnc_relPos, [], 0, "FORM"];
		_unit setBehaviour "CARELESS";
		_group addWaypoint [[_unit, 75, random 360] call BIS_fnc_relPos, 0];

		sleep (10 + (random 10));

		_unit setDamage 1;
	};
};
/*****************************************/

/******************************************
***** création d'objets pour le débug *****
***** de la fonction addActionGlobal  *****
******************************************/
{
	_computer = createVehicle ["Land_Laptop_unfolded_F", _x, [], 0, "CAN_COLLIDE"];
	_computer setDir 90;

	[
		_computer,
		"Action",
		objNull,
		format ["test%1", _forEachIndex],
		false,
		true
	] call CRP_fnc_addActionGlobal;
} forEach [
	[7516, 7452, 0],
	[7516, 7450, 0]
];
/****************************************/