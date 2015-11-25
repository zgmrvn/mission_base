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