/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// déclaration post-init des fonctions
#include "functions\functions.sqf"

// inclusion de l'initialisation client et serveur
#include "init\clientServer.sqf"

if (X_server) then {
	// paramètres et actions par défaut du serveur
	// utilisé par les modules
	#include "core\defaultServer.sqf"

	// inclusion de l'initialisation serveur
	#include "init\server.sqf"
};

if (X_client) then {
	// paramètres et actions par défaut du client
	// utilisé par les modules
	#include "core\defaultClient.sqf"

	// inclusion de l'initialisation client
	#include "init\client.sqf"
};
