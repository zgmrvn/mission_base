// si c'est la touche H
// pour afficher/masquer les chemins et icônes
if (keyName (_this select 1) == """H""") then {
	[] spawn {
		disableSerialization;

		_display	= findDisplay SPECTATOR_DIALOG_IDD;
		_list		= _display displayCtrl SPECTATOR_LIST_IDC;
		_help		= _display displayCtrl SPECTATOR_HELP_IDC;

		// on bascule l'état de l'interface
		CRP_var_spectatorCamera_uiVisible = !CRP_var_spectatorCamera_uiVisible;

		// on fade la liste de joueur
		_fade = if (CRP_var_spectatorCamera_uiVisible) then {0} else {1};

		{
			_x ctrlSetFade _fade;
			_x ctrlCommit 0.25;
		} forEach [_list, _help];

		// on masque progressivement les chemins et icônes en modifiant un multiplicateur
		// utilisé dans le calcul de l'alpha des lines 3D et icônes
		if (CRP_var_spectatorCamera_uiVisible) then {
			while {(CRP_var_spectatorCamera_uiFadeValue < 1) && CRP_var_spectatorCamera_uiVisible} do {
				CRP_var_spectatorCamera_uiFadeValue = CRP_var_spectatorCamera_uiFadeValue + 0.1;

				sleep 0.025;
			};
		} else {
			while {(CRP_var_spectatorCamera_uiFadeValue > 0) && !CRP_var_spectatorCamera_uiVisible} do {
				CRP_var_spectatorCamera_uiFadeValue = CRP_var_spectatorCamera_uiFadeValue - 0.1;

				sleep 0.025;
			};
		};
	};
};

// si c'est la touche pour ouvrir la carte
// on affiche la carte
if ((_this select 1) in (actionKeys "ShowMap")) then {
	CRP_var_spectatorCamera_map = !CRP_var_spectatorCamera_map;

	_dialog	= findDisplay SPECTATOR_DIALOG_IDD;
	_map	= _dialog displayCtrl SPECTATOR_MAP_IDC;

	_map ctrlShow CRP_var_spectatorCamera_map;
	ctrlSetFocus _map;
};
