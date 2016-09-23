#include "ctrl.hpp"

class TaxiBoatDialog {
	idd = TAXI_BOAT_DIALOG_IDD;

	onLoad		= "['onLoad', _this, 'TaxiBoatDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\taxiBoat\content\uiScriptStart.sqf';";
	onUnload	= "['onUnload', _this, 'TaxiBoatDialog', 'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); [] execVM 'modules\taxiBoat\content\uiScriptStop.sqf';";

	class ControlsBackground {
		class Title: BaseTitle {
			text = "Bateau taxi";
		};

		class Background: BaseBackgroundBox {};
	};

	class Controls {
		class PlayersList: BaseListBox {
			idc = TAXI_BOAT_LIST_IDC;

			x = safeZoneX + safeZoneW * 0.2;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class BoatList: BaseListBox {
			idc = TAXI_BOAT_BOATLIST_IDC;

			x = safeZoneX + safeZoneW * 0.305;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.1;
			h = safeZoneH * 0.52;

			colorBackground[] = {0.1, 0.1, 0.1, 1};
		};

		class Map: BaseMap {
			idc = TAXI_BOAT_MAP_IDC;

			x = safeZoneX + safeZoneW * 0.41;
			y = safeZoneY + safeZoneH * 0.21;
			w = safeZoneW * 0.39;
			h = safeZoneH * 0.52;

			tooltip = "Double-cliquez pour séléctionner la côte où accoster";
		};

		class CloseButton: CancelButton {
			idc = TAXI_BOAT_CLOSE_IDC;

			x = safeZoneX + safeZoneW * 0.4;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.0975;
			h = safeZoneH * 0.05;
		};

		class ProjectionButton: ValideButton {
			idc = TAXI_BOAT_TAXI_IDC;

			x = safeZoneX + safeZoneW * 0.5025;
			y = safeZoneY + safeZoneH * 0.74;
			w = safeZoneW * 0.095;
			h = safeZoneH * 0.05;

			text = "Taxi";
		};
	};
};