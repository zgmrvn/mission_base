/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

#include "ctrl.hpp"

class TeleportToLeaderDialog {
	idd = TELEPORT_DIALOG_IDD;

	onLoad = "['onLoad', _this, 'TeleportToLeaderDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\teleportToLeader\content\uiScriptStart.sqf';";

	class controlsBackground {
		class Title: BaseTitle {
			text = "Téléportation";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: BaseListBox {
			idc = TELEPORT_LIST_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class CloseButton: CancelButton {
			idc = TELEPORT_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;
		};

		class TeleportButton: ValideButton {
			idc = TELEPORT_TELEPORT_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Téléportation";
		};
	};
};
