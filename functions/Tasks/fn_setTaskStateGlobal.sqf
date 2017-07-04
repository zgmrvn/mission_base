/*
	framework de mission du CORP
	http://www.corp-arma.fr

	NOM :			setTaskStateGlobal
	AUTEUR :		zgmrvn
	DESCRIPTION :	change l'état d'une tâche de façon globale, compatible JIP

	EXAMPLES :
		["test", "Succeeded", true, "vous avez réussi"] call CORP_fnc_setTaskStateGlobal;
		["test", "Failed", true, "mauvais..."] call CORP_fnc_setTaskStateGlobal;
		["test", "Failed", true] call CORP_fnc_setTaskStateGlobal;
		["test", "Succeeded"] call CORP_fnc_setTaskStateGlobal;
*/

params [
	"_ref",
	"_state",
	["_notif", false],
	["_text", false]
];

// si je suis le serveur, je demande aux joueur d'exécuter cette fonction, même pour les JIP
if (isDedicated) then {
	["SET", [_ref, _state, _notif, _text]] remoteExec ["CORP_fnc_taskProceed", X_remote_client, true];
};

// sinon, si je suis un joueur
if (!isDedicated) then {
	["SET", [_ref, _state, _notif, _text]] remoteExec ["CORP_fnc_taskProceed", X_remote_server];
};
