/*
	cette fonction ne devrait jamais être utilisée directement
	utilisez CRP_fnc_addTask et CRP_fnc_setTaskState
*/

params [
	"_mode",
	"_params"
];

switch (_mode) do
{
	// si on doit ajouter la tâche
	case "ADD": {
		// on extrait les paramètres
		_ref	= _params select 0;
		_title	= _params select 1;
		_desc	= _params select 2;
		_notif	= _params select 3;

		// si je suis le serveur, on demande aux joueurs d'exécuter cette fonction, même pour les JIP
		if (isDedicated) then {
			["ADD", [_ref, _title, _desc, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_client, true];
		};

		// si je suis un joueur
		if (!isDedicated) then {
			// si le tableau des tâches n'existe pas, je le créé
			if (isNil {CRP_var_tasks}) then {
				CRP_var_tasks = [];
			};

			// si la tâche n'éxiste pas déjà
			if (isNil {[CRP_var_tasks, _ref] call BIS_fnc_getFromPairs}) then {
				// je créé la tâche et la sauvegarde dans le tableau des tâches
				_task = player createSimpleTask [_ref];
				[CRP_var_tasks, _ref, _task] call BIS_fnc_setToPairs;

				// on décrit la tâche
				_task setSimpleTaskDescription [_desc, _title, ""];

				// on affiche la notification si demandé
				if (_notif && (time > 1)) then {
					["TaskCreated", ["", _title]] call BIS_fnc_showNotification;
				};
			};
		};
	};

	// si on doit définir son état
	case "SET": {
		// on extrait les paramètres
		_ref	= _params select 0;
		_state	= _params select 1;
		_text	= _params select 2;
		_notif	= _params select 3;

		// si je suis le serveur, je demande aux joueurs d'exécuter cette fonction, même pour les JIP
		if (isDedicated) then {
			["SET", [_ref, _state, _text, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_client, true];
		};

		// sinon, si je suis un joueur
		if (!isDedicated) then {
			[_ref, _state, _text, _notif] spawn {
				_ref	= _this select 0;
				_state	= _this select 1;
				_text	= _this select 2;
				_notif	= _this select 3;

				// on s'assure que la tâche a été créée
				waitUntil {!isNil {[CRP_var_tasks, _ref] call BIS_fnc_getFromPairs}};

				// modifie l'état de la tâche
				([CRP_var_tasks, _ref] call BIS_fnc_getFromPairs) setTaskState _state;

				// on affiche la notification si demandé
				if (_notif && (time > 1)) then {
					[format ["Task%1", _state], ["", _text]] call BIS_fnc_showNotification;
				};
			};
		};
	};
};