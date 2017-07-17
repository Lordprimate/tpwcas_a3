class CfgPatches
{
	class tpwcas
		{
		
			author = "";
			units[] = { };
			weapons[] = { };
			requiredAddons[] = {"CBA_Main"};
			version = "5.5.2";
			versionStr = "5.5.2";
			versionDesc="TPWCAS_A3";
			versionAr[] = {5,5,2};
			authors[] = {"TPW","-Coulum-","fabrizio_T","Ollem","Lordprimate"};
		};
};

class Extended_PostInit_EventHandlers {
    class tpwcas_init {
		init = "if (isNil 'tpwcas_init') then { tpwcas_init = true;[] execVM '\tpwcas\init.sqf'};"; 
    };
}; 

class tpwcas_key_setting
{
	#include "\userconfig\tpwcas\tpwcas_v2.hpp"
};

class cfgVehicles
{
	class Logic ;
		
	class tpwcas_module_disable : Logic
	{
		displayName = "(TPWCAS) Disable mod (tpwcas_mode = 0)";
		icon = "\tpwcas\data\tpwcas_0.paa";
		picture = "\tpwcas\data\tpwcas_0.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_mode = 0; publicVariable 'tpwcas_mode'";
		};
	};
	
	class tpwcas_module_dedicated : Logic
	{
		displayName = "(TPWCAS) Dedicated Server mode / no clients (tpwcas_mode = 3) - Enable";
		icon = "\tpwcas\data\tpwcas_1.paa";
		picture = "\tpwcas\data\tpwcas_1.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_mode = 3; publicVariable 'tpwcas_mode'";
		};
	};
	
	class tpwcas_module_clientserver : Logic
	{
		displayName = "(TPWCAS) Client Server mode (tpwcas_mode = 2) - Enable";
		icon = "\tpwcas\data\tpwcas_1.paa";
		picture = "\tpwcas\data\tpwcas_1.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_mode = 2; publicVariable 'tpwcas_mode';";
		};
	};
	
	class tpwcas_module_tpwlos_enable : Logic
	{
		displayName = "(TPWCAS) Embedded TPW LOS - Enable";
		icon = "\tpwcas\data\tpwcas_1.paa";
		picture = "\tpwcas\data\tpwcas_1.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_los_enable = 1; publicVariable 'tpwcas_los_enable';";
		};
	};
	
	class tpwcas_module_tpwlos_disable : Logic
	{
		displayName = "(TPWCAS) Embedded TPW LOS - Disable";
		icon = "\tpwcas\data\tpwcas_0.paa";
		picture = "\tpwcas\data\tpwcas_0.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_los_enable = 0; publicVariable 'tpwcas_los_enable';";
		};
	};
	
	class tpwcas_module_cover_enable : Logic
	{
		displayName = "(TPWCAS) Find Cover - Enable";
		icon = "\tpwcas\data\tpwcas_1.paa";
		picture = "\tpwcas\data\tpwcas_1.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_getcover = 1; publicVariable 'tpwcas_getcover';";
		};
	};
	
	class tpwcas_module_cover_disable : Logic
	{
		displayName = "(TPWCAS) Find Cover - Disable";
		icon = "\tpwcas\data\tpwcas_0.paa";
		picture = "\tpwcas\data\tpwcas_0.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_getcover = 0; publicVariable 'tpwcas_getcover';";
		};
	};
	
	class tpwcas_module_debug_enable : Logic
	{
		displayName = "(TPWCAS) Visual Debug - Enable";
		icon = "\tpwcas\data\tpwcas_1.paa";
		picture = "\tpwcas\data\tpwcas_1.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_debug = 1; publicVariable 'tpwcas_debug';";
		};
	};
	
	class tpwcas_module_debug_disable : Logic
	{
		displayName = "(TPWCAS) Visual Debug - Disable";
		icon = "\tpwcas\data\tpwcas_0.paa";
		picture = "\tpwcas\data\tpwcas_0.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "tpwcas_debug = 0; publicVariable 'tpwcas_debug';";
		};
	};
};