#include "ctrl.hpp"

class BoatProjectionDialog {
	idd = BOAT_PROJECTION_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'BoatProjectionDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\boatProjection\uiScriptStart.sqf';";
	onUnload	= "['onUnload', _this, 'BoatProjectionDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\boatProjection\uiScriptStop.sqf';";

	class ControlsBackground {
		class Title: BaseTitle {
			text = "Projection en embarcation";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: BaseListBox {
			idc = BOAT_PROJECTION_LIST_IDC;

			x = safeZoneX + safeZoneW * 0.2;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class BoatList: BaseListBox {
			idc = BOAT_PROJECTION_BOATLIST_IDC;

			x = safeZoneX + safeZoneW * 0.305;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class Map: BaseMap {
			idc = BOAT_PROJECTION_MAP_IDC;

			x = safeZoneX + safeZoneW * 0.41;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.39;
			h = safeZoneH * 0.52;

			tooltip = "Double-cliquez pour définir le point de projection";
		};

		class CloseButton: CancelButton {
			idc = BOAT_PROJECTION_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;
		};

		class ProjectionButton: ValideButton {
			idc = BOAT_PROJECTION_PROJECTION_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Projection";
		};
	};
};