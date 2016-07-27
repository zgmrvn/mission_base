// module de drapeaux
CRP_fnc_actionsFlags_getFlag = compile preprocessFileLineNumbers "modules\actionsFlags\fnc\fn_actionsFlags_getFlag.sqf";

// module d'occupation des bâtiments par l'ia
CRP_fnc_buildingsOccupation_area = compile preprocessFileLineNumbers "modules\buildingsOccupation\fnc\fn_buildingsOccupation_area.sqf";
// fonctions de développement disponibles uniquement dans l'éditeur
if (X_editor) then  {
	CRP_fnc_buildingsOccupation_getRelPos = compile preprocessFileLineNumbers "modules\buildingsOccupation\fnc\fn_buildingsOccupation_getRelPos.sqf";
	CRP_fnc_buildingsOccupation_getBuildingInfos = compile preprocessFileLineNumbers "modules\buildingsOccupation\fnc\fn_buildingsOccupation_getBuildingInfos.sqf";
};

// module de patrouilles aléatoires
CRP_fnc_randomPatrols_patrols = compile preprocessFileLineNumbers "modules\randomPatrols\fnc\fn_randomPatrols_patrols.sqf";