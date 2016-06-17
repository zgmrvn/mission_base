// définitions des localités
// et attente de l'initialisation
#include "core\localities.sqf"

// déclaration post-init des fonctions
#include "functions\functions.sqf"

// écrivez ce que vous voulez

if (X_server) then {
	// paramètres et actions par défaut du serveur
	// utilisé par les modules
	#include "core\defaultServer.sqf"

	/*************************************************
	***** script de développement et de débogage *****
	***** À SUPPRIMER                            *****
	*************************************************/
	// [] execVM "mission\dev.sqf";
	/*************************************************
	*************************************************/

	// écrivez ce que vous voulez
};

if (X_client) then {
	// paramètres et actions par défaut du client
	// utilisé par les modules
	#include "core\defaultClient.sqf"

	// écrivez ce que vous voulez
};