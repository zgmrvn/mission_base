// activer ou désactiver le module
enabled = 1;

// effet de feuilles qui tombent dans les forêts

class Effects {
	// effet de feuilles qui tombes dans les forêts
	class Leaves {
		enabled		= 1;

		script		= "leaves"; // type d'effet, nom du script qui sera utilisé et qui est préconfiguré pour un certain effet
		radius		= 25; // rayon dans lequel il faut chercher des positions où créer l'effet
		precision	= 10; // précision des positions
		sources		= 5; // nombre de sources
		duration	= 5; // durée de l'effet
		threshold	= 0.4; // seuil de correspondance du terrain en dessous duquel l'effet n'est pas créé
		sleep		= 5; // delais entre chaque itération de la boucle qui créé l'effet
		expression	= "1.5 * trees * (1 - meadow)";
	};

	// effet de poussière au sol
	class GroundDust {
		enabled		= 0;

		script		= "goundDust";
		radius		= 25;
		precision	= 10;
		sources		= 5;
		duration	= 5;
		threshold	= 0.4;
		sleep		= 5;
		expression	= "1";
	};

	// effet de poussière ambiante
	class AmbiantDust {
		enabled		= 1;

		script		= "ambiantDust";
		radius		= 50;
		precision	= 10;
		sources		= 5;
		duration	= 5;
		threshold	= 0.4;
		sleep		= 5;
		expression	= "1";
	};
};