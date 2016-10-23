/*
	NAME :			addActionGlobal
	VERSION :		1.0
	AUTHOR :		zgmrvn
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

// if i'm the server, tell the players to run this function so it adds the action
if (isDedicated) then {
	[_object, _title, _scriptCLient, _scriptServer, _reference, _distance, _removeObject, _removeAction] remoteExec ["CRP_fnc_addActionGlobal", -2, true];
};

// otherwise, i'm the player, add action
if (!isDedicated) then {
	// check if this object already has an actions array
	if (isNil {_object getVariable ACTIONS_ARRAY}) then {
		_object setVariable [ACTIONS_ARRAY, []];
	};

	// check if an action with this name already exists
	if (!isNil {[_object getVariable ACTIONS_ARRAY, _reference] call BIS_fnc_getFromPairs}) exitWith {};

	// add action
	_id = _object addAction [
		_title,
		{
			// retrieve addAction params which are addActionGlobal params
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

			// should we remove the object
			if (_removeObject) then {
				[_object, {deleteVehicle _this}] remoteExec ["spawn", _server];
			} else {
				// if not, should we remove the action
				if (_removeAction) then {

					// remove action for everyone
					[
						[_object, _reference],
						{
							(_this select 0) removeAction ([((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_getFromPairs);
							[((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_removeFromPairs;
						}
					] remoteExec ["spawn", _client, true];
				};
			};

			// if object has not been removed, pass it to the scripts
			_data = if (_removeObject) then {[_this select 1]} else {[_this select 1, _object]};

			// if a client script has been given, run it
			if ((typeName _scriptClient) == "STRING") then {
				// run script for clients only
				[_data, _scriptClient] remoteExec ["execVM", _client];
			};

			// if a server script has been given, run it
			if ((typeName _scriptServer) == "STRING") then {
				// run script for server only
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