/*
	framework de mission du CORP
	http://www.corp-arma.fr

	NOM :			addActionGlobal
	AUTEUR :		zgmrvn
	DESCRIPTION :	ajoute une action globale, compatible JIP

	EXAMPLE :
		// serveur
		[
			_ammoBox,							// objet
			"<t color='#FF0000'>My action</t>",	// texte de l'action
			"addActionScriptClient.sqf",		// script à exécuter chez les clients
			"addActionScriptServer.sqf",		// script à exécuter côté serveur
			"actionLabel",						// label de l'action, permêt de différencier les actions quand il y en a plusieurs sur un même objet
			6,									// distance d'affichage de l'action
			false,								// supprimer l'objet
			true								// supprimer l'action, pas d'importance si l'objet est supprimé
		] call CRP_fnc_addActionGlobal;

 		// dans le cas d'un JIP où l'objet pourrait avoir été supprimé
 		// il vaut vérifier que l'object existe toujours avant de le passer à la fonction

 		if (!isNil {objectVariable}) then {
			[...] call CRP_fnc_addActionGlobal;
		};
*/

#define ACTIONS_ARRAY "CRP_var_actionsArray"

params [
	"_object",
	"_title",
	"_scriptClient",
	"_scriptServer",
	"_reference",
	"_distance",
	"_removeObject",
	"_removeAction"
];

// si je suis le serveur, on demande aux joueurs d'exécuter la fonction pour ajouter l'action
if (isDedicated) then {
	[_object, _title, _scriptCLient, _scriptServer, _reference, _distance, _removeObject, _removeAction] remoteExec ["CRP_fnc_addActionGlobal", -2, true];
};

// sinon, je suis un joueur, ajouter l'action
if (!isDedicated) then {
	// verifier si l'objet a déjà un tableau d'actions
	if (isNil {_object getVariable ACTIONS_ARRAY}) then {
		_object setVariable [ACTIONS_ARRAY, []];
	};

	// vérifier qu'une action avec ce label n'éxiste pas déjà
	// si c'est le cas, on sort de la fonction
	if (!isNil {[_object getVariable ACTIONS_ARRAY, _reference] call BIS_fnc_getFromPairs}) exitWith {};

	// addAction
	_id = _object addAction [
		_title,
		{
			// récupération des paramètres passés à l'action qui sont les paramètres passés à la fonction elle-même
			_params			= _this select 3;
			_object			= _params select 0;
			_title			= _params select 1;
			_scriptClient	= _params select 2;
			_scriptServer	= _params select 3;
			_reference		= _params select 4;
			_distance		= _params select 5;
			_removeObject	= _params select 6;
			_removeAction	= _params select 7;

			_client = [-2, 0] select isServer;
			_server = 2;

			// faut-il supprimer l'objet ?
			if (_removeObject) then {
				[_object, {deleteVehicle _this}] remoteExec ["spawn", _server];
			} else {
				// si non, faut-il supprimer l'action ?
				if (_removeAction) then {

					// supprimer l'action pour tous les joueurs
					[
						[_object, _reference],
						{
							(_this select 0) removeAction ([((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_getFromPairs);
							[((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_removeFromPairs;
						}
					] remoteExec ["spawn", _client, true];
				};
			};

			// on prépare le tableau de données qui sera passé aux scripts client et serveur
			// si l'objet n'a pas été supprimé, on l'ajoute au tableau de données
			_data = [[_this select 1, _object], [_this select 1]] select _removeObject;

			// si un script client a été renseigné, on l'exécute
			if ((typeName _scriptClient) == "STRING") then {
				// exécution du script pour les clients seulement
				[_data, _scriptClient] remoteExec ["execVM", _client];
			};

			// si un script serveur a été renseigné, on l'exécute
			if ((typeName _scriptServer) == "STRING") then {
				// exécution du script pour le serveur seulement
				[_data, _scriptServer] remoteExec ["execVM", _server];
			};
		},
		[
			_object,
			_title,
			_scriptClient,
			_scriptServer,
			_reference,
			_distance,
			_removeObject,
			_removeAction
		],
		1.5,
		true,
		true,
		"",
		format ["(player distance _target) < %1", _this select 5]
	];

	[_object getVariable ACTIONS_ARRAY, _reference, _id] call BIS_fnc_addToPairs;
};