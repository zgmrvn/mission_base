/*
	["test", "Succeeded", "vous avez réussi", true] call CRP_fnc_setTaskState;
	["test", "Failed", "mauvais...", true] call CRP_fnc_setTaskState;
*/

params [
	"_ref",
	"_state",
	"_text",
	["_notif", false]
];

// si je suis le serveur, je demande aux joueur d'exécuter cette fonction, même pour les JIP
if (isDedicated) then {
	["SET", [_ref, _state, _text, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_client, true];
};

// sinon, si je suis un joueur
if (!isDedicated) then {
	["SET", [_ref, _state, _text, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_server];
};