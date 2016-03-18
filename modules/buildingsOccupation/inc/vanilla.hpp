// petit bungalow en béton
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_House_Small_03_V1_F.jpg
class Land_i_House_Small_03_V1_F {
	positions[] = {
		{{0.177734,3.85059,0.0352173},286},
		{{0.389648,2.84473,-0.579865},286},
		{{-0.162109,3.11621,-2.63818},108},
		{{3.95508,-5.13086,-0.743637},105},
		{{4.1084,-0.199219,-0.712112},15},
		{{4.22559,3,-0.709061},7.982},
		{{-0.421875,3.45898,3.559097},286},
		{{3.65137,-0.421875,3.697159},17},
		{{2.45605,-4.62695,3.695145},110}
	};
};

// grande maison méditerranéenne à deux étages avec porche sur facade alpha
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_House_Big_01_V1_F.jpg
class Land_i_House_Big_01_V1_F {
	positions[] = {
		// rdc
		{{-0.823242,-0.521484,-2.56494},270},
		{{-3.48584,5.53711,-2.56494},270},
		{{3.84521,-5.2041,-2.56494},90},
		// étage
		{{-3.50488,0.598633,0.855064},270},
		{{-3.49463,-3.29883,0.855064},270},
		{{3.8125,-5.20117,0.855064},90},
		{{-3.50537,5.52051,0.855064},270},
		{{3.77393,5.53613,0.855064},90}
	};
};
class Land_i_House_Big_01_V2_F: Land_i_House_Big_01_V1_F {};
class Land_i_House_Big_01_V3_F: Land_i_House_Big_01_V1_F {};

// petite maison à 2 étages et 2 balcons
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_House_Big_02_V1_F.jpg
class Land_i_House_Big_02_V1_F {
	positions[] = {
		// rdc
		{{0.175781,-3.14063,-2.62327},180},
		{{-2.9165,4.29297,-2.62327},0},
		{{3.19067,4.62695,-2.62328},0},
		{{3.88159,2.83301,-2.62327},90},
		// étage
		{{0.154297,-3.53027,0.784065},180},
		{{0.0917969,4.63281,0.784058},0},
		{{3.17651,4.51367,0.784058},0},
		{{3.87939,2.81152,0.784058},90},
		// balcons
		{{-3.16772,6.25488,0.72406},315},
		{{3.38647,6.12598,0.724056},45},
		{{0.970215,-5.12891,0.784061},130},
		{{-3.58862,-5.11719,0.784065},225}
	};
};
class Land_i_House_Big_02_V2_F: Land_i_House_Big_02_V1_F {};
class Land_i_House_Big_02_V3_F: Land_i_House_Big_02_V1_F {};

// maisons de pierre avec étage
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Stone_HouseBig_V3_F.jpg
class Land_i_Stone_HouseBig_V1_F {
	positions[] = {
		// rez-de-chaussée
		{{3.00098,-0.206543,-1.64301},180},
		{{-1.30225,3.58545,-1.65424},270},
		// étage
		{{4.17236,3.50586,1.21892},90},
		{{2.94775,-0.611328,1.21892},180},
		// balcon
		{{5.96436,3.31201,1.18892},45},
		{{5.8501,1.31885,1.18892},125}
	};
};
class Land_i_Stone_HouseBig_V2_F: Land_i_Stone_HouseBig_V1_F {};
class Land_i_Stone_HouseBig_V3_F: Land_i_Stone_HouseBig_V1_F {};

// petite dépendance abandonnée
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_u_Addon_02_V1_F.jpg
class Land_u_Addon_02_V1_F {
	positions[] = {
		{{-1.44629,0.503418,0.0981369},180},
		{{2.3623,0.657715,0.0981369},180}
	};
};

// petite dépendance en état (même qu'au dessus)
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Addon_02_V1_F.jpg
class Land_i_Addon_02_V1_F {
	positions[] = {
		{{-1.44629,0.503418,0.0981369},180}
	};
};

// petite maison en pierre de plein-pied
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Stone_Shed_V1_F.jpg
class Land_i_Stone_Shed_V1_F {
	positions[] = {
		{{2.30859,1.83545,-0.100506},90},
		{{-1.91748,3.60229,-0.100506},0},
		{{-1.875,0.192139,-0.100506},180}
	};
};
class Land_i_Stone_Shed_V2_F: Land_i_Stone_Shed_V1_F {};
class Land_i_Stone_Shed_V3_F: Land_i_Stone_Shed_V1_F {};

// maison boutique à étage avec balcon
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Shop_01_V1_F.jpg
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Shop_01_V2_F.jpg
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Shop_01_V3_F.jpg
class Land_i_Shop_01_V1_F {
	positions[] = {
		// rdc
		{{1.33594,-0.831055,-2.76158},180},
		{{-0.739258,-1.40527,-2.76158},180},
		{{-2.79883,-1.43066,-2.76157},180},
		// étage
		{{0.0507813,5.9043,1.10955},0},
		{{-2.57617,6.19141,1.10984},0},
		{{1.3584,-1.39941,1.11001},180},
		{{-2.59277,-1.3584,1.10999},180},
		// balcon
		{{-3.09863,-3.1377,1.0803},225},
		{{2.36133,-3.26855,1.0803},135}
	};
};
class Land_i_Shop_01_V2_F: Land_i_Shop_01_V1_F {};
class Land_i_Shop_01_V3_F: Land_i_Shop_01_V1_F {};

// grande terrasse couverte
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_i_Addon_03_V1_F.jpg
class Land_i_Addon_03_V1_F {
	positions[] = {
		{{-3.61816,-0.497803,-0.0501022},270},
		{{-3.95605,2.56079,-0.0501022},270},
		{{-2.81836,-1.22656,-0.0501022},180},
		{{3.25195,-1.27368,-0.0501022},180},
		{{3.76563,2.50024,-0.0501022},90},
		{{3.7666,-0.358398,-0.0501022},90}
	};
};

// bâtiments en construction inachevé
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Unfinished_Building_01_F.jpg
class Land_Unfinished_Building_01_F {
	positions[] = {
		{{-3.36523,-1.80273,1.37755},180},
		{{3.10156,-0.916016,1.1979},129},
		{{0.191406,3.7832,1.1979},103},
		{{-2.47461,4.85059,4.49521},163},
		{{-3.14258,-1.56641,-2.2971},174}
	};
};

// tour de château
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Castle_01_tower_F.jpg
class Land_Castle_01_tower_F {
	positions[] = {
		// entrée
		{{-0.0639648,-1.53027,-9.47995},179},
		// escaliers
		{{-2.19385,2.73535,-3.95515},132},
		{{2.2832,2.61084,-6.67592},213},
		{{0.0991211,-1.65234,0.508522},178},
		{{2.39453,-1.93066,1.70361},310},
		{{2.2627,2.5791,4.41951},221},
		// sommet
		{{-1.96729,0.441406,7.94255},268},
		{{-0.114746,-1.50684,7.94255},177},
		{{2.10254,0.438965,7.94255},90}
	};
};

// tour de câteau en ruine
//https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Castle_01_tower_ruins_F.jpg
class Land_Castle_01_tower_ruins_F {
	positions[] = {
		// entrée
		{{-0.339355,-2.66406,-3.00752},177},
		{{-1.72266,-0.399902,-2.35877},158},
		// escaliers
		{{2.11182,1.03027,-1.24273},211},
		{{-2.38672,1.04736,1.48034},135},
		{{-2.39014,-3.26758,4.33982},212}
	};
};

// abris métalique
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Metal_Shed_F.jpg
class Land_Metal_Shed_F {
	positions[] = {
		{{4.00635,-1.81299,-1.40652},89},
		{{0.043457,-0.499512,-1.24019},358},
		{{-3.52881,1.85815,-0.438736},53}
	};
};

// grande cabane
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Slum_House03_F.jpg
class Land_Slum_House03_F {
	positions[] = {
		{{-1.02979,0.0883789,-1.01504},180},
		{{-1.57251,0.318848,-1.05071},264}
	};
};

// petite casemate en sacs de sables
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_BagBunker_Small_F.jpg
class Land_BagBunker_Small_F {
	positions[] = {
		{{0.103027,-0.645264,-0.963562},180},
		{{0.829102,-0.155518,-0.960739},91},
		{{-0.871094,-0.274658,-0.963699},269}
	};
};

// kiosks
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Kiosk_blueking_F.jpg
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Kiosk_gyros_F.jpg
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Kiosk_papers_F.jpg
// https://community.bistudio.com/wiki/File:Arma3_CfgVehicles_Land_Kiosk_redburger_F.jpg
class Land_Kiosk_blueking_F {
	positions[] = {
		{{0,-0.737305,-1.97606},180}
	};
};
class Land_Kiosk_gyros_F: Land_Kiosk_blueking_F {};
class Land_Kiosk_papers_F: Land_Kiosk_blueking_F {};
class Land_Kiosk_redburger_F: Land_Kiosk_blueking_F {};