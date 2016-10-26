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
		"mission\testScriptClient.sqf",
		"mission\testScriptServer.sqf",
		format ["test%1", _forEachIndex],
		2,
		false,
		true
	] call CRP_fnc_addActionGlobal;
} forEach [
	[7516, 7452, 0],
	[7516, 7450, 0]
];
/****************************************/
