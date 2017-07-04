/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

class CORP {
	class Framework {
		class PreInit {
			file	= "core\fn_preInit.sqf";
			preInit	= 1;
		};
	};

	class Tasks {
		class createTaskGlobal {};
		class setTaskStateGlobal {};
		class taskProceed {};
	};
};
