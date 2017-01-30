#define ACTION_PRIORITY 6

player addAction [
	"Arsenal",
	{
		["Open", true] spawn BIS_fnc_arsenal;
	},
	nil,
	ACTION_PRIORITY,
	false,
	true
];
