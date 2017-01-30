#define ACTION_PRIORITY 5.99

CRP_var_debug_allowDamage = true;

player addAction [
	"Désactiver dégâts",
	{
		player allowDamage false;
		CRP_var_debug_allowDamage = false;
	},
	nil,
	ACTION_PRIORITY,
	false,
	true,
	"",
	"CRP_var_debug_allowDamage"
];

player addAction [
	"Activer dégâts",
	{
		player allowDamage true;
		CRP_var_debug_allowDamage = true;
	},
	nil,
	ACTION_PRIORITY,
	false,
	true,
	"",
	"!CRP_var_debug_allowDamage"
];
