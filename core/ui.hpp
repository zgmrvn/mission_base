#define BACKGROUND_COLOR_BASE {0, 0, 0, 0.5}
#define TEXT_RATIO (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)

class BaseTitle: RscText {
	idc = -1;
	type = CT_STATIC;
	style = ST_CENTER

	x = safeZoneX;
	y = safeZoneY + safeZoneH * 0.1;
	w = safeZoneW;
	h = safeZoneH * 0.1;

	text = "Titre";
	SizeEx = TEXT_RATIO * 3;
	shadow = 0;
	font = "PuristaLight";
};

class BaseBackgroundBox: RscText {
	idc = -1;
	type = CT_STATIC;

	x = safeZoneX;
	y = safeZoneY + safeZoneH * 0.2;
	w = safeZoneW;
	h = safeZoneH * 0.6;

	colorBackground[] = BACKGROUND_COLOR_BASE;
};

class CancelButton: RscButton {
	idc = -1;

	text = "Annuler";
	colorBackground[] = {0.1, 0.1, 0.1, 1};
};

class ValideButton: RscButton {
	idc = -1;

	text = "Valider";
	colorBackground[] = {0.1, 0.1, 0.1, 1};
};

class BaseTreeView {
	idc = -1;
	type = CT_TREE;
	style = ST_LEFT;
	default = 0;
	blinkingPeriod = 0;

	colorBorder[] = {0,0,0,0}; // Frame color

	colorBackground[] = {0.1, 0.1, 0.1, 1}; // Fill color
	colorSelect[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 0)
	colorMarked[] = {1,0.5,0,0.5}; // Marked item fill color (when multiselectEnabled is 1)
	colorMarkedSelected[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 1)

	sizeEx = TEXT_RATIO; // Text size
	font = PuristaLight; // Font from CfgFontFamilies
	shadow = 1; // Shadow (0 - none, 1 - N/A, 2 - black outline)
	colorText[] = {1,1,1,1}; // Text color
	colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
	colorMarkedText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 1)

	tooltip = "CT_TREE"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	multiselectEnabled = 1; // Allow selecting multiple items while holding Ctrl or Shift
	expandOnDoubleclick = 1; // Expand/collapse item upon double-click
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa"; // Expand icon
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa"; // Collapse icon
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it

	class ScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.01;

		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";

		color[] = {1,1,1,1}; // Scrollbar color
	};

	colorDisabled[] = {0,0,0,0};
	colorArrow[] = {0,0,0,0};
};