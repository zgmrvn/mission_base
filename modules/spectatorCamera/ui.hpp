#include "ctrl.hpp"

class SpectatorCameraDialog {
	idd = SPECTATOR_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'SpectatorCameraDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiStartScript.sqf';";
	onUnload	= "['onUnload', _this, 'SpectatorCameraDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiStopScript.sqf';";

	class controlsBackground {
		class HelpCtrl: RscText {
			idc = SPECTATOR_HELP_IDC;
			type = CT_STATIC;
			style = ST_LEFT;

			x = safeZoneX;
			y = safeZoneY + safeZoneH * 0.9;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.1;

			text = "masque l'interface : H";
		};

		class EventCtrl: RscListBox {
			idc = SPECTATOR_EVENT_IDC;
			type = CT_LISTBOX;

			x = safeZoneX + safeZoneW * 0.1;
			y = safeZoneY;
			w = safeZoneW * 0.9;
			h = safeZoneH;

			colorBackground[] = {0, 0, 0, 0};
		};
	};

	class Controls {
		class PlayersList: RscListBox {
			idc = SPECTATOR_LIST_IDC;

			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.9;

			colorBackground[] = {0, 0, 0, 0};
			rowHeight = safeZoneH * 0.02;
			canDrag = 0;
		};
	};
};