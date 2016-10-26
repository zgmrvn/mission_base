/*
	framework de mission du CORP
	http://www.corp-arma.fr

	NOM :			createTaskGlobal
	AUTEUR :		zgmrvn
	DESCRIPTION :	créé une tâche de façon globale, compatible JIP

	EXAMPLE :
		["test", "titre tâche", "description tâche", true] call CRP_fnc_createTaskGlobal;
*/

params [
	"_ref",
	"_title",
	"_desc",
	["_notif", false]
];

// si je suis le serveur, je demande aux joueur d'exécuter cette fonction, même pour les JIP
if (isDedicated) then {
	["ADD", [_ref, _title, _desc, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_client, true];
};

// sinon, si je suis un joueur
if (!isDedicated) then {
	["ADD", [_ref, _title, _desc, _notif]] remoteExec ["CRP_fnc_taskProceed", X_remote_server];
};
