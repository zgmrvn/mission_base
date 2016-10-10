#include "ctrl.hpp"

[] spawn {
	waitUntil {!isNull (findDisplay TELEPORT_DIALOG_IDD)};

	disableSerialization;

	_dialog		= findDisplay TELEPORT_DIALOG_IDD;
	_list		= _dialog displayCtrl TELEPORT_LIST_IDC;
	_close		= _dialog displayCtrl TELEPORT_CLOSE_IDC;
	_teleport	= _dialog displayCtrl TELEPORT_TELEPORT_IDC;

	{
		lbAdd [TELEPORT_LIST_IDC, name _x];
		lbSetData [TELEPORT_LIST_IDC, _forEachIndex, name _x];
	} forEach allPlayers;

	_close ctrlAddEventHandler ["MouseButtonDown", {
		closeDialog TELEPORT_DIALOG_IDD;
	}];

	_teleport ctrlAddEventHandler ["MouseButtonDown", {
		_index = lbCurSel TELEPORT_LIST_IDC;

		if (_index >= 0) then {
			_player = lbData [TELEPORT_LIST_IDC, _index];

			{
				if ((name _x) == _player) exitWith {
					closeDialog TELEPORT_DIALOG_IDD;

					player setPosATL (_x getRelPos [2, 0]);
					player setDir ([player, _x] call BIS_fnc_dirTo);
				}
			} forEach allPlayers;
		};
	}];
};