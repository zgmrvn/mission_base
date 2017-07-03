/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

class CORP {
	class Framework {
		class localities {
			file	= "core\fn_localities.sqf";
			preInit	= 1;
		};
	};

	class Tasks {
		class createTaskGlobal {};
		class setTaskStateGlobal {};
		class taskProceed {};
	};
};
