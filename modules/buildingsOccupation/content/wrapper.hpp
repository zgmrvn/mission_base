/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

class BuildingsOccupation {
	#include "..\config.hpp"

	// bâtiments et positions d'occupation
	class Buildings {
		// bâtiments Arma 3 vanilla, Stratis, Altis
		#include "inc\vanilla.hpp"

		// bâtiments portés d'Arma 2
		#include "inc\arma2.hpp"

		// bâtiments de Tanoa
		#include "inc\tanoa.hpp"
	};
};
