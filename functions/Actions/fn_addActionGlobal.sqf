/*
	remplacer la référence par une random string
	remplacer _object par _target
	remplacer les remoteExec de BIS_fnc_spawn par un bloc dans la fonction et un paramètre facultatif afin réduire la charge réseau
*/
#define ACTIONS_ARRAY "CRP_var_actionsArray"

// in the case of a JIP where the object could have been removed
// you have to check the object before to pass it to the function
/*
if (!isNil {objectVariable}) then {
	[...] call CRP_fnc_addActionGlobal;
};
*/

params [
	"_object",
	"_title",
	"_script",
	"_reference",
	"_removeObject",
	"_removeAction"
];

// if i'm the server, tell the players to run this function so it adds the action
if (isDedicated) then {
	[_object, _title, _script, _reference, _removeObject, _removeAction] remoteExec ["CRP_fnc_addActionGlobal", -2, true];
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
			_script			= _params select 2;
			_reference		= _params select 3;
			_removeObject	= _params select 4;
			_removeAction	= _params select 5;

			// should we remove the object
			if (_removeObject) then {
				[[_object], {deleteVehicle (_this select 0)}] remoteExec ["BIS_fnc_spawn", 2];
			} else {
				// if not, should we remove the action
				if (_removeAction) then {
					// we don't want the server to execute this command if it's a dedicated game
					_server = if (isServer) then {0} else {-2};

					// remove action for everyone
					[
						[_object, _reference],
						{
							(_this select 0) removeAction ([((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_getFromPairs);
							[((_this select 0) getVariable ACTIONS_ARRAY), _this select 1] call BIS_fnc_removeFromPairs;
						}
					] remoteExec ["BIS_fnc_spawn", _server, true];
				};
			};

			// if a script has been given, run it
			if ((typeName _script) == "STRING") then {
				// if object has not been removed, pass it to the script
				_data = if (_removeObject) then {[]} else {[_object]};

				// run script for everyone
				[_data, _script] remoteExec ["BIS_fnc_execVM", 0];
			};
		},
		[
			_object,
			_title,
			_script,
			_reference,
			_removeObject,
			_removeAction
		]
	];

	[_object getVariable ACTIONS_ARRAY, _reference, _id] call BIS_fnc_addToPairs;
};