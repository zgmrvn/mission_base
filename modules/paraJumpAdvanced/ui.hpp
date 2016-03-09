#include "ctrl.hpp"

class ParaJumpAdvancedDialog {
	idd = PARAJUMP_ADVANCED_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'ParaJumpAdvancedDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\paraJumpAdvanced\uiScriptStart.sqf';";
	onUnload	= "['onUnload', _this, 'ParaJumpAdvancedDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\paraJumpAdvanced\uiScriptStop.sqf';";

	class ControlsBackground {
		class Title: BaseTitle {
			text = "ParaJump avancé";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: BaseListBox {
			idc = PARAJUMP_ADVANCED_DIVERLIST_IDC;

			x = safeZoneX + safeZoneW * 0.2;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class DropList: BaseListBox {
			idc = PARAJUMP_ADVANCED_DROPLIST_IDC;

			x = safeZoneX + safeZoneW * 0.305;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class Map: BaseMap {
			idc = PARAJUMP_ADVANCED_MAP_IDC;

			x = safeZoneX + safeZoneW * 0.41;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.39;
			h = safeZoneH * 0.52;
		};

		class CloseButton: CancelButton {
			idc = PARAJUMP_ADVANCED_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;
		};

		class TeleportButton: ValideButton {
			idc = PARAJUMP_ADVANCED_JUMP_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Saut";
		};
	};
};