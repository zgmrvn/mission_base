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
		systemChat str _this;
	}];

	_teleport ctrlAddEventHandler ["MouseButtonDown", {
		_index = lbCurSel TELEPORT_LIST_IDC;

		if (_index >= 0) then {
			_player = lbData [TELEPORT_LIST_IDC, _index];

			{
				if ((name _x) == _player) exitWith {
					closeDialog TELEPORT_DIALOG_IDD;

					_pos = [_x, 2, getDir _x] call BIS_fnc_relPos;
					_pos set [2, (getPosASL _x) select 2];
					player setPosASL _pos;
					player setDir ([player, _x] call BIS_fnc_dirTo);
				}
			} forEach allPlayers;
		};
	}];
};