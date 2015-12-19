// déclaration des fonctions post-init
// ces fonctions ne peuvent pas être utilisées depuis l'éditeur
#include "functions\functions.sqf"

// définitions des localités
// et attente de l'initialisation
#include "core\localities.sqf"

// à partir d'ici, le client et le serveur sont prêts
// écrivez ce que vous voulez

if (X_server) then {
	// paramètres et actions du serveur par défaut
	// utilisé par les modules
	#include "core\defaultServer.sqf"

	/*************************************************
	***** script de développement et de débogage *****
	***** À SUPPRIMER                            *****
	*************************************************/
	[] execVM "mission\dev.sqf";
	/*************************************************
	*************************************************/

	// écrivez ce que vous voulez
};

if (X_client) then {
	// paramètres et actions du client par défaut
	// utilisé par les modules
	#include "core\defaultClient.sqf"

	// écrivez ce que vous voulez
};