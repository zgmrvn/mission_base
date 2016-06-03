/*
	NAME :			addActionGlobal
	VERSION :		1.0
	AUTHOR :		zgmrvn
	DESCRIPTION :	adds a global addAction, handles JIP issues

	EXAMPLE :
		// server side
		[
			_ammoBox,							// object
			"<t color='#FF0000'>My action</t>",	// action title
			"addActionScriptClient.sqf",		// script to execute client side
			"addActionScriptServer.sqf",		// script to execute server side
			"actionLabel",						// action label, to differenciate actions when you want to add more than one action on the same object
			6,									// distance the action displays
			false,								// remove object
			true								// remove action, doesn't matters if object removed
		] call CRP_fnc_addActionGlobal;

		// in the case of a JIP where the object could have been removed
 		// you have to check the object before to pass it to the function

 		if (!isNil {objectVariable}) then {
			[...] call CRP_fnc_addActionGlobal;
		};

	REVISIONS :
		1.0 - 2015/11/03 - zgmrvn
			CREATED - first version
*/

/*
	remplacer la référence par une random string, s'assurer que ça ne pose pas de problème pour la vérification avant ajout dans le cas d'une exécution coté client et serveur à la fois
	remplacer les remoteExec de BIS_fnc_spawn par un bloc dans la fonction et un paramètre facultatif afin réduire la charge réseau
	rendre le paramère suppression action facultatif
	ajouter un paramètre de distance pour l'action
	séparer script serveur, script client
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

			_client = if (isServer) then {0} else {-2};
			_server = 2;

			// should we remove the object
			if (_removeObject) then {
				[[_object], {deleteVehicle (_this select 0)}] remoteExec ["BIS_fnc_spawn", _server];
			} else {
				// if not, should we remove the action
				if (_removeAction) then {
					// we don't want the server to execute this command if it's a dedicated game
					// only in editor
					_client = if (isServer) then {0} else {-2};

					// remove action for everyone
					[
						[_object, _reference],
						{
							(_this select 0) removeAction ([((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_getFromPairs);
							[((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_removeFromPairs;
						}
					] remoteExec ["BIS_fnc_spawn", _client, true];
				};
			};

			// if object has not been removed, pass it to the scripts
			_data = if (_removeObject) then {[_this select 1]} else {[_this select 1, _object]};

			// if a client script has been given, run it
			if ((typeName _scriptClient) == "STRING") then {
				// run script for clients only
				[_data, _scriptClient] remoteExec ["BIS_fnc_execVM", _client];
			};

			// if a server script has been given, run it
			if ((typeName _scriptServer) == "STRING") then {
				// run script for server only
				[_data, _scriptServer] remoteExec ["BIS_fnc_execVM", _server];
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