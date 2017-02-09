#define ACTION_PRIORITY 5.99

CRP_var_debug_allowDamage = true;

player addAction [
	"Désactiver dégâts",
	{
		player allowDamage false;
		CRP_var_debug_allowDamage = false;

		// l'invincibilité est désactivée à la sortie de la caméra spectateur
		// ce script la réactive en surveillant la fermeture du display
		[] spawn {
			// tant que les dégâts sont désactivés
			while {!CRP_var_debug_allowDamage} do {
				// on attend que
				// caméra spectateur affichée || dégâts réactivés
				waitUntil { !isNull (findDisplay 60492) || CRP_var_debug_allowDamage };

				// si les dégâts ne sont plus désactivés, on sort de la boucle
				if (CRP_var_debug_allowDamage) exitWith {};

				// sinon, on continue et on attend que la caméra spectateur soit refermée
				waitUntil { isNull (findDisplay 60492) };

				// on re-désactive les dégâts
				sleep 0.1;
				player allowDamage false;
			};
		};
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
