if (X_server) then {
	_crate = createVehicle ["B_supplyCrate_F", [4008, 4000, 0], [], 0, "NONE"];

	[
		_crate,
		"<t color='#FF0000'>created object</t>",
		"mission\addActionScript.sqf",
		"test3",
		true,
		true
	] call CRP_fnc_addActionGlobal;
};