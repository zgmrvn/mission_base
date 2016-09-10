#define BACKGROUND_COLOR_BASE {0, 0, 0, 0.5}
#define TEXT_RATIO (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)

class BaseTitle: RscText {
	idc = -1;
	type = CT_STATIC;
	style = ST_CENTER;

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

class BaseEdit: RscEdit {
	idc = -1;
	type = CT_EDIT;

	font = "RobotoCondensed";
	colorBackground[] = {0.1, 0.1, 0.1, 1};
};

class BaseText: RscText {
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;

	font = "RobotoCondensed";
};

class BaseListBox: RscListBox {
	idc = -1;
	font = "RobotoCondensed";
	rowHeight = safeZoneH * 0.02;
	canDrag = 0;
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

	tooltip = "";
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

class BaseMap {
	access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = -1; // Control identification (without it, the control won't be displayed)
	type = CT_MAP_MAIN; // Type
	style = ST_PICTURE; // Style
	default = 0; // Control selected by default (only one within a display can be used)
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	sizeEx = TEXT_RATIO; // Text size
	font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
	colorText[] = {0,0,0,1}; // Text color

	tooltip = "";
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

	moveOnEdges = 1; // Move map when cursor is near its edge. Discontinued.

	// Rendering density coefficients
	ptsPerSquareSea =	5;	// seas
	ptsPerSquareTxt =	20;	// textures
	ptsPerSquareCLn =	10;	// count-lines
	ptsPerSquareExp =	10;	// exposure
	ptsPerSquareCost =	10;	// cost

	// Rendering thresholds
	ptsPerSquareFor =	9;	// forests
	ptsPerSquareForEdge =	9;	// forest edges
	ptsPerSquareRoad =	6;	// roads
	ptsPerSquareObj =	9;	// other objects

	scaleMin = 0.001; // Min map scale (i.e., max zoom)
	scaleMax = 1.0; // Max map scale (i.e., min zoom)
	scaleDefault = 0.16; // Default scale

	alphaFadeStartScale = 0.1; // Scale at which satellite map starts appearing
	alphaFadeEndScale = 0.01; // Scale at which satellite map is fully rendered
	maxSatelliteAlpha = 0.85; // Maximum alpha of satellite map

	text = "#(argb,8,8,3)color(1,1,1,1)"; // Fill texture
	colorBackground[] = {1,1,1,1}; // Fill color

	colorOutside[] = {0,0,0,1}; // Color outside of the terrain area (not sued when procedural terrain is enabled)
	colorSea[] = {0.4,0.6,0.8,0.5}; // Sea color
	colorForest[] = {0.6,0.8,0.4,0.5}; // Forest color
	colorForestBorder[] = {0.6,0.8,0.4,1}; // Forest border color
	colorRocks[] = {0,0,0,0.3}; // Rocks color
	colorRocksBorder[] = {0,0,0,1}; // Rocks border color
	colorLevels[] = {0.3,0.2,0.1,0.5}; // Elevation number color
	colorMainCountlines[] = {0.6,0.4,0.2,0.5}; // Main countline color (every 5th)
	colorCountlines[] = {0.6,0.4,0.2,0.3}; // Countline color
	colorMainCountlinesWater[] = {0.5,0.6,0.7,0.6}; // Main water countline color (every 5th)
	colorCountlinesWater[] = {0.5,0.6,0.7,0.3}; // Water countline color
	colorPowerLines[] = {0.1,0.1,0.1,1}; // Power lines color
	colorRailWay[] = {0.8,0.2,0,1}; // Railway color
	colorNames[] = {1.1,0.1,1.1,0.9}; // Unknown?
	colorInactive[] = {1,1,0,0.5}; // Unknown?
	colorTracks[] = {0.8,0.8,0.7,0.2}; // Small road border color
	colorTracksFill[] = {0.8,0.7,0.7,1}; // Small road color
	colorRoads[] = {0.7,0.7,0.7,1}; // Medium road border color
	colorRoadsFill[] = {1,1,1,1}; // Medium road color
	colorMainRoads[] = {0.9,0.5,0.3,1}; // Large road border color
	colorMainRoadsFill[] = {1,0.6,0.4,1}; // Large road color
	colorGrid[] = {0.1,0.1,0.1,0.6}; // Grid coordinate color
	colorGridMap[] = {0.1,0.1,0.1,0.6}; // Grid line color

	fontLabel = GUI_FONT_NORMAL; // Tooltip font from CfgFontFamilies
	sizeExLabel = GUI_GRID_CENTER_H * 0.5; // Tooltip font size

	fontGrid = GUI_FONT_SYSTEM; // Grid coordinate font from CfgFontFamilies
	sizeExGrid = GUI_GRID_CENTER_H * 0.5; // Grid coordinate font size

	fontUnits = GUI_FONT_SYSTEM; // Selected group member font from CfgFontFamilies
	sizeExUnits = GUI_GRID_CENTER_H * 0.5; // Selected group member font size

	fontNames = GUI_FONT_NARROW; // Marker font from CfgFontFamilies
	sizeExNames = GUI_GRID_CENTER_H * 0.5; // Marker font size

	fontInfo = GUI_FONT_NORMAL; // Unknown?
	sizeExInfo = GUI_GRID_CENTER_H * 0.5; // Unknown?

	fontLevel = GUI_FONT_SYSTEM; // Elevation number font
	sizeExLevel = GUI_GRID_CENTER_H * 0.5; // Elevation number font size

	showCountourInterval = 1;

	class Task {
		icon = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = {1,1,0,1};

		iconCreated = "#(argb,8,8,3)color(1,1,1,1)";
		colorCreated[] = {0,0,0,1};

		iconCanceled = "#(argb,8,8,3)color(1,1,1,1)";
		colorCanceled[] = {0,0,0,0.5};

		iconDone = "#(argb,8,8,3)color(1,1,1,1)";
		colorDone[] = {0,1,0,1};

		iconFailed = "#(argb,8,8,3)color(1,1,1,1)";
		colorFailed[] = {1,0,0,1};

		size = 8;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class ActiveMarker {
		color[] = {0,0,0,1};
		size = 2;
	};

	class LineMarker {
		lineDistanceMin = 3e-005;
		lineLengthMin = 5;
		lineWidthThick = 0.014;
		lineWidthThin = 0.008;
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	};

	class Waypoint {
		coefMax = 1;
		coefMin = 4;
		color[] = {0,0,0,1};
		icon = "#(argb,8,8,3)color(0,0,0,1)";
		importance = 1;
		size = 2;
	};

	class WaypointCompleted: Waypoint {};
	class CustomMark: Waypoint {};
	class Command: Waypoint {};
	class Bush: Waypoint {};
	class Rock: Waypoint {};
	class SmallTree: Waypoint {};
	class Tree: Waypoint {};
	class BusStop: Waypoint {};
	class FuelStation: Waypoint {};
	class Hospital: Waypoint {};
	class Church: Waypoint {};
	class Lighthouse: Waypoint {};
	class Power: Waypoint {};
	class PowerSolar: Waypoint {};
	class PowerWave: Waypoint {};
	class PowerWind: Waypoint {};
	class Quay: Waypoint {};
	class Transmitter: Waypoint {};
	class Watertower: Waypoint {};
	class Cross: Waypoint {};
	class Chapel: Waypoint {};
	class Shipwreck: Waypoint {};
	class Bunker: Waypoint {};
	class Fortress: Waypoint {};
	class Fountain: Waypoint {};
	class Ruin: Waypoint {};
	class Stack: Waypoint {};
	class Tourism: Waypoint {};
	class ViewTower: Waypoint {};
};