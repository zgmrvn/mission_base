#include "ctrl.hpp"

class ParaJumpClassicDialog {
	idd = PARAJUMP_CLASSIC_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'ParaJumpClassicDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\paraJumpClassic\uiScriptStart.sqf';";
	onUnload	= "['onUnload', _this, 'ParaJumpClassicDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\paraJumpClassic\uiScriptStop.sqf';";

	class ControlsBackground {
		class Title: BaseTitle {
			text = "ParaJump classique";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: BaseListBox {
			idc = PARAJUMP_CLASSIC_LIST_IDC;

			x = safeZoneX + safeZoneW * 0.2;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class Altitude: BaseEdit {
			idc = PARAJUMP_CLASSIC_ALTITUDE_IDC;

			x = safeZoneX + safeZoneW * 0.305;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.05;

			text = "5000";
			tooltip = "Altitude, vous pouvez utliser la molette de votre souris";
		};

		class Map: BaseMap {
			idc = PARAJUMP_CLASSIC_MAP_IDC;

			x = safeZoneX + safeZoneW * 0.41;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.39;
			h = safeZoneH * 0.52;

			tooltip = "Double-cliquez pour définir le point de saut";
		};

		class CloseButton: CancelButton {
			idc = PARAJUMP_CLASSIC_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;
		};

		class TeleportButton: ValideButton {
			idc = PARAJUMP_CLASSIC_JUMP_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Saut";
		};
	};
};