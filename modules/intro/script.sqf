if ((getNumber (missionConfigFile >> "Intro" >> "enabled")) == 0) exitWith {};
if (("PlayIntro" call BIS_fnc_getParamValue) == 0) exitWith {};

waitUntil {!isNil {CRP_var_intro_alreadyConnected}};

_name = name _player;

// if player name isn't already referenced
if !(_name in CRP_var_intro_alreadyConnected) exitWith {
	// reference it
	CRP_var_intro_alreadyConnected pushBack _name;

	// then tell the player to play the intro
	[[], "modules\intro\intro.sqf"] remoteExec ["BIS_fnc_execVM", _player];
};