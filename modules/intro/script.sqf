if ((getNumber (missionConfigFile >> "Intro" >> "enable")) == 0) exitWith {};
if (("PlayIntro" call BIS_fnc_getParamValue) == 0) exitWith {};

waitUntil {!isNil {X_alreadyConnected}};

_name = name _player;

// if player name isn't already referenced
if !(_name in X_alreadyConnected) exitWith {
	// reference it
	X_alreadyConnected pushBack _name;

	// then tell the player to play the intro
	[[], "modules\intro\intro.sqf"] remoteExec ["BIS_fnc_execVM", _player];
};