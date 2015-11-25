#include "ctrl.hpp"

class TeleportToLeaderDialog {
	idd = TELEPORT_DIALOG_IDD;

	onLoad = "['onLoad', _this, 'TeleportToLeaderDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\teleportToLeader\uiScript.sqf'";

	class controlsBackground {
		class Title: BaseTitle {
			text = "Téléportation";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: RscListBox {
			idc = TELEPORT_LIST_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.2;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class CloseButton: RscButton {
			idc = TELEPORT_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;

			text = "Annuler";
			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class TeleportButton: RscButton {
			idc = TELEPORT_TELEPORT_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Téléportation";
			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};
	};
};