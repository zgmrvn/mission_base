// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "TeleportToLeader" >> "enable")) == 0) exitWith {};

X_teleportToLeaderFlags = [];

{
	_veh = createVehicle ["FlagPole_F", _x, [], 0, "NONE"];

	X_teleportToLeaderFlags pushBack _veh;

	publicVariable "X_teleportToLeaderFlags";
} forEach (getArray (missionConfigFile >> "TeleportToLeader" >> "flags"));

if (isDedicated) then {
	X_teleportToLeaderFlags = nil;
};