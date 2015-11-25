// quitter le script si le module est désactivé
if ((getNumber (missionConfigFile >> "TeleportToLeader" >> "enable")) == 0) exitWith {};

[] spawn {
	waitUntil {!isNil {X_teleportToLeaderFlags}};

	{
		_x addAction [
			"Téléportation vers un chef d'équipe",
			{createDialog "TeleportToLeaderDialog"},
			nil,
			1.5,
			true,
			true,
			"",
			"(_target distance player) < 6"
		];
	} forEach X_teleportToLeaderFlags;

	X_teleportToLeaderFlags = nil;
};