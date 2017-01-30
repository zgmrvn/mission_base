#define ACTION_PRIORITY 5.98

player addAction [
	"Devenir captif",
	{ player setCaptive true },
	nil,
	ACTION_PRIORITY,
	false,
	true,
	"",
	"!captive _target"
];

player addAction [
	"Ne plus être captif",
	{ player setCaptive false },
	nil,
	ACTION_PRIORITY,
	false,
	true,
	"",
	"captive _target"
];
