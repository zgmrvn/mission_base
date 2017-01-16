/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

class Hunters {
	class Base {
		start[]			= {0, 0, 0};
		hunterSide		= "Indep";
		condition		= "false";
		hunterGroups[]	= {{"Indep", "IND_C_F", "Infantry", "BanditCombatGroup"}};
		pause			= 30;
	};

	#include "..\config.hpp"
};
