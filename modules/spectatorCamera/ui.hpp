#include "ctrl.hpp"

class SpectatorCameraDialog {
	idd = SPECTATOR_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'SpectatorCameraDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiStartScript.sqf';";
	onUnload	= "['onUnload',_this,'RscDisplayCorpCameraTool','GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiStopScript.sqf';";

	class controlsBackground {
		class EventCtrl: RscListBox {
			idc = SPECTATOR_EVENT_IDC;
			type = CT_LISTBOX;

			x = safeZoneX + safeZoneW * 0.15;
			y = safeZoneY;
			w = safeZoneW * 0.85;
			h = safeZoneH;

			colorBackground[] = {0, 0, 0, 0};
		};
	};

	class Controls {
		class PlayersTree: BaseTreeView {
			idc = SPECTATOR_TREE_IDC;

			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW * 0.15;
			h = safeZoneH;

			colorBackground[] = {0, 0, 0, 0};
		};
	};
};