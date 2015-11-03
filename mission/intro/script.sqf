if (("PlayIntro" call BIS_fnc_getParamValue) == 1) then {
	_name = name _player;

	// if player name isn't already referenced
	if !(_name in X_alreadyConnected) exitWith {
		// reference it
		X_alreadyConnected pushBack _name;

		// then tell the player to play the intro
		[[], "mission\intro\intro.sqf"] remoteExec ["BIS_fnc_execVM", _player];
	};
};