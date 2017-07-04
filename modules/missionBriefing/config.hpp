/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// activer ou désactiver le module
enabled = 1;

// liste des "diaries" dans l'onglet briefing
class Diaries {
	class Objerctif1 {
		title		 = "Saboter l'antenne relais";
		paragraphs[] = {
			"Sabotez l'<marker name='antenna'>antenne relais</marker> pour empêcher les <marker name='renforcementNorth'>renforts au Nord</marker> d'être prévenus.",
			"Un 2e paragraphe, gestion des paragraphes pour simplifier la rédaction de briefing."
		};
	};

	class Test2 {
		title		 = "Éliminer les scientifiques";
		paragraphs[] = {
			"Éliminez les scientifiques qui travaillent sur l'enrichissement d'uranium."
		};
	};
};
