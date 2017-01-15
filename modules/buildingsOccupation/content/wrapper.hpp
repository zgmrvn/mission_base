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

		// bâtiments de Tanoa
		#include "inc\tanoa.hpp"

		// bâtiments Tchernarus
		#include "inc\european.hpp"

		// bâtiments Takistan
		#include "inc\middleEastern.hpp"

		// bâtiments Sahrani
		#include "inc\sahrani.hpp"
	};
};
