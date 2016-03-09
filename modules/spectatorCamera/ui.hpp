#include "ctrl.hpp"

class Map: BaseMap {
		idc = SPECTATOR_MAP_IDC;
		enable = 0;

		x = safeZoneX;
		y = safeZoneY;
		w = safeZoneW;
		h = safeZoneH;

		tooltip = "Double-cliquez pour déplacer la caméra";
	};

class SpectatorCameraDialog {
	idd = SPECTATOR_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'SpectatorCameraDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiScriptStart.sqf';";
	onUnload	= "['onUnload', _this, 'SpectatorCameraDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\spectatorCamera\uiScriptStop.sqf';";

	class controlsBackground {
		class Help: BaseText {
			idc = SPECTATOR_HELP_IDC;

			x = safeZoneX;
			y = safeZoneY + safeZoneH * 0.9;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.1;

			text = "Interface : H";
		};

		class Event: RscListBox {
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
		class PlayersList: BaseListBox {
			idc = SPECTATOR_LIST_IDC;

			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.9;

			colorBackground[] = {0, 0, 0, 0};
		};
	};
};