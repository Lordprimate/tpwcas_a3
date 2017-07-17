/*
GET COVER
- tpwcas_fnc_find_cover: AI will look for cover closeby
*/
//===================================================================================================================================================================================================
//Zooloo75 Firefight improvement system evasive movement
tpwcas_fnc_evasive_move =
{
	_unit = _this select 0;
	if(currentWeapon _unit == "") exitWith {};
	
	_chance = round(random 100);
	if(_chance > 75) then
	{	
		_stance = stance _unit;
		_anim = round(random 11);
		_randomPos = [(getPosATL _unit select 0) + random 15 - random 15,(getPosATL _unit select 1) + random 15 - random 15,0];
		
		if (tpwcas_debug > 0) then 
		{	
			if (tpwcas_debug == 2) then 
			{
				diag_log format ["Executing evasive movement [%1] for unit %2 (%3)", _anim, name _unit, _unit];
			};
			[['orange', _randomPos],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
			if (hasInterface) then {
				['orange', _randomPos] spawn tpwcas_fnc_debug_smoke;
			};
		};

		_unit doMove _randomPos;
		(group _unit) setSpeedMode "FULL";
		sleep 0.5;
		
		switch _stance do
		{
			case "PRONE":
			{
				if ((currentWeapon _unit) == (handgunWeapon _unit)) then {
				_playanim = selectRandom ["AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDl","AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDr"];
				_unit playMoveNow _playanim;			
				} else {
				_playanim = selectRandom ["AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl","AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"];
				_unit playMoveNow _playanim;
				};
			};
			case "CROUCH":
			{
				if ((weaponLowered _unit) && ((currentWeapon _unit) == (handgunWeapon _unit))) then {
				_playanim = selectRandom ["AmovPknlMrunSlowWpstDl","AmovPknlMrunSlowWpstDr"];
				_unit playMoveNow _playanim;
				};
				
				if ((currentWeapon _unit) == (handgunWeapon _unit)) then {
				_playanim = selectRandom ["AmovPknlMrunSrasWpstDl","AmovPknlMrunSrasWpstDr"];
				_unit playMoveNow _playanim;			
				};
				
				if (weaponLowered _unit) then {
				_playanim = selectRandom ["AmovPknlMrunSlowWrflDl","AmovPknlMrunSlowWrflDr"];
				_unit playMoveNow _playanim; 
				} else {
				_playanim = selectRandom ["AmovPknlMevaSrasWrflDl","AmovPknlMevaSrasWrflDr"];
				_unit playMoveNow _playanim;			
				};
			};
			case "STAND":
			{
				if ((weaponLowered _unit) && ((currentWeapon _unit) == (handgunWeapon _unit))) then {
				_playanim = selectRandom ["AmovPercMrunSlowWpstDl","AmovPercMrunSlowWpstDr"];
				_unit playMoveNow _playanim;
				};
				if ((currentWeapon _unit) == (handgunWeapon _unit)) then {
				_playanim = selectRandom ["AmovPercMevaSrasWpstDl","AmovPercMevaSrasWpstDr","AmovPercMrunSrasWpstDl","AmovPercMrunSrasWpstDr"];
				_unit playMoveNow _playanim;			
				};
				
				if (weaponLowered _unit) then {
				_playanim = selectRandom ["AmovPercMstpSlowWrflDnon_AmovPknlMstpSlowWrflDnon","AmovPercMstpSlowWrflDnon_AmovPpneMstpSrasWrflDnon"];
				_unit playMoveNow _playanim; 
				} else {
				_playanim = selectRandom ["AmovPercMevaSrasWrflDfr_AmovPknlMstpSrasWrflDnon","AmovPercMevaSrasWrflDf_AmovPknlMstpSrasWrflDnon","AmovPercMevaSrasWrflDfl_AmovPknlMstpSrasWrflDnon","AmovPercMevaSrasWrflDl","AmovPercMevaSrasWrflDr","AmovPknlMevaSrasWrflDl","AmovPknlMevaSrasWrflDr"];
				_unit playMoveNow _playanim;			
				};
			};
		};	
		if(_chance > 98) then
		{
			_unit forceWeaponFire [currentWeapon _unit, "Single"];
		};
	};
};

//======================================================================================================================================================================================================

//Robalo ASR_AI object filter for finding suitable cover
tpwcas_fnc_cover_filter = 
{
//	private ["_type","_z"];
//if (_this isKindOf "Man" || _this isKindOf "Bird") exitWith {false};
//if (_this isKindOf "BulletCore" || _this isKindOf "Grenade") exitWith {false};
//if (_this isKindOf "WeaponHolder" || _this isKindOf "WeaponHolderSimulated") exitWith {false};
//if (_this isKindOf "Lamps_base_F") exitWith {false};
//if (_this isKindOf "Sound") exitWith {false};
//if (!isTouchingGround _this) exitWith {false};
	if (isBurning _this) exitWith {false};
	//if (["fence", (format ["%1", _this])] call BIS_fnc_inString) exitWith {false};
	//if ([": b_", (format ["%1", _this])] call BIS_fnc_inString) exitWith {false};
	//if ([": t_", (format ["%1", _this])] call BIS_fnc_inString) exitWith {false};
	//if (["slop", (format ["%1", _this])] call BIS_fnc_inString) exitWith {false};
	//if (["rater", (format ["%1", _this])] call BIS_fnc_inString) exitWith {false};
private _tfilter = false;
private _type = typeOf _this;
if (_type == "") then {
	if (damage _this == 1) then {_tfilter = true};
} else {
	scopeName "haveType";
	//if (_type in ["#crater","#crateronvehicle","#soundonvehicle","#particlesource","#lightpoint","#slop","#mark"]) then {_tfilter = true; breakOut "haveType"};
	if (_type find "Wire" > -1) then {_tfilter = true; breakOut "haveType"};
	if (getText (configfile>>"CfgVehicles">>_type>>"vehicleClass") in ["","Ammo","Flag","Helpers","Lamps","Signs","Small_items","Submerged","Structures_Fences"]) then {_tfilter = true};
};
if (_tfilter) exitWith {false};
if ((boundingCenter _this) select 2 < 0.4) exitWith {false};
true
};


tpwcas_fnc_find_cover =
{
	private ["_unit","_status","_cover","_allcover","_objects","_shooter","_lineIntersect","_terrainIntersect","_inCover","_coverPosition","_cPos","_vPos","_dz","_dx"];

	_unit = _this select 0;
	_status = _this select 1;

	_cover = [];
	_allcover = [];
	_inCover = false;
	
	_unit setvariable ["tpwcas_cover", _status];	
	
	//potential cover objects list
	_objects = [ (nearestObjects [_unit, ["All"], tpwcas_coverdist]), { _x call tpwcas_fnc_cover_filter } ] call BIS_fnc_conditionalSelect;
	_objects append (nearestTerrainObjects [_unit, ["TREE", "BUILDING", "HOUSE", "CHURCH", "CHAPEL", "ROCK", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "WALL", "HIDE", "BUSSTOP", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "TRACK", "ROCKS", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK"], tpwcas_coverdist]);
	
	if ( count _objects > 0 ) then
	{
		// check if current location of unit already provides cover from shooter
		_shooter = _unit getVariable "tpwcas_shooter";
		_lineIntersect = lineIntersects [eyePos _shooter, eyePos _unit, _shooter];

		if !(_lineIntersect) then
		{	
			if (tpwcas_debug == 2) then 
			{
				diag_log format ["Cover objects for unit %1 found: %2", _unit, _objects];
			};
		
			// start forEach _objects
			{ 
				//if ( !(_x isKindOf "CaManBase") && !(_inCover) ) then
				if !(_inCover) then
				{
					//_x is potential cover object
					_bbox = boundingBoxReal _x;
					_dz = abs(((_bbox select 1) select 2) - ((_bbox select 0) select 2));//height
					_dx = abs(((_bbox select 1) select 0) - ((_bbox select 0) select 0));//width
					
					_cPos = (getPosATL _x);
					_vPos = (vectorDir _shooter);
					
					//set coverposition to 1.15 m behind the found cover
					_coverPosition = [((_cPos select 0) + (1.15 * (_vPos select 0))), ((_cPos select 1) + (1.15 * (_vPos select 1))), (_cPos select 2)];
					
					//Any object which is high and wide enough is potential cover position, excluding water
					if ( (_dx > 0.45) && {(_dz > 0.45)} && {!(surfaceIsWater _coverPosition)}) then
					{
						if ( ( _coverPosition distance _unit ) < 1.25 )  exitWith 
						{
							if (tpwcas_debug > 0) then 
							{	
								if (tpwcas_debug == 2) then 
								{
									diag_log format ["abort: [%1] close to cover [%2] now: distance [%3] m", _unit, _x, _coverPosition distance _unit];
								};
								[['green', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
								if (hasInterface) then {
									['green', _coverPosition] spawn tpwcas_fnc_debug_smoke;
								};
							};
							_inCover = true;
						};

						_cover set [count _cover, [_x, _coverPosition, _dx, _dz]];					
					};
				};
			} count _objects;
			// end forEach _objects
		}
		else
		{
			if (tpwcas_debug > 0) then 
				{
					if (tpwcas_debug == 2) then 
					{
						diag_log format ["abort: [%1] already in cover for shooter [%2]", _unit, _shooter];
					};
					[['cyan', getPosATL _unit],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
					if (hasInterface) then {
						['cyan', getPosATL _unit] spawn tpwcas_fnc_debug_smoke;
					};
				};
		};
	};
	
	//if cover found order unit to move into cover
	if ( ((count _cover) > 0) && !(_inCover) ) then
	{
		if (tpwcas_debug > 0) then 
		{
			_coverTarget = (_cover select 0) select 0;
			_coverPosition = (_cover select 0) select 1;
			_dx = (_cover select 0) select 2;
			_dz = (_cover select 0) select 3;
			
			if (tpwcas_debug == 2) then 
			{
				diag_log format ["[%1] cover: [%2] - distance [%3] - box: [%4] - (size: x:%5 - z:%6)]", _unit, _coverTarget, _coverPosition distance _unit, boundingBoxReal _coverTarget, _dx, _dz]; 
			};
			[['yellow', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
			if (hasInterface) then {
				['yellow', _coverPosition] spawn tpwcas_fnc_debug_smoke;
			};
		};
		
		[_unit, _cover select 0, _shooter] spawn tpwcas_fnc_move_to_cover;
	}
	else
	{		
		// check if current location of unit already provides cover from shooter
		_shooter = _unit getVariable "tpwcas_shooter";
		_lineIntersect = lineIntersects [eyePos _shooter, eyePos _unit, _shooter];
		// trigger evasive movement
		if (!(_lineIntersect) && ((random 1) > 0.25)) then 
		{
			[_unit] call tpwcas_fnc_evasive_move;
		};
	};
};

//======================================================================================================================================================================================================

tpwcas_fnc_move_to_cover =
{
	private ["_unit","_cover","_coverArray","_coverPosition","_coverDist","_coverTarget","_cPos","_vPos","_debug_flag","_dist","_shooter","_continue","_logOnce","_startTime","_checkTime","_stopped","_tooFar","_tooLong","_elapsedTime"];
	
	_unit 			=	_this select 0;
	_coverArray 	=	_this select 1;
	_shooter 		=	_this select 2;
	
	_cover 			=	_coverArray select 0;
	_coverPosition 	= 	_coverArray select 1;


	//doStop _unit;
	_unit forceSpeed -1;
	_unit doMove _coverPosition;

	_coverDist = round ( _unit distance _coverPosition );

	_stopped = false;
	_continue = true;
	_logOnce = true;
	
	_startTime = time;
	_checkTime =  (_startTime + (1.7 * _coverDist) + 9);
	
	/*
	_speed = speedMode _unit;
	_unit setSpeedMode "FULL";
	_unit doMove _cover;
	_unit setDestination [_cover, "LEADER PLANNED", true];
	waitUntil {moveToCompleted _unit || moveToFailed _unit || unitReady _unit || time > _until + 30};
	_unit setSpeedMode _speed;
	if (_unit == leader _unit) then {(group _unit) lockwp false};
	*/
	
	while { _continue } do 
	{
		if ( _logOnce && (tpwcas_debug > 0) ) then 
		{
			_debug_flag = "Flag_FD_Red_F" createVehicle _coverPosition;
			_debug_flag setPosATL _coverPosition;

			if (tpwcas_debug == 2) then 
			{
				diag_log format ["Unit [%1] moving to cover [%2]: distance [%3] m", _unit, _cover, _coverDist];
			};
			_logOnce = false;
		};
		
		_dist = round ( _unit distance _coverPosition );
						
		if ( !( unitReady _unit ) && {( alive _unit )} && {( _dist > 1.25 )} ) then
		{
			//if unit takes too long to reach cover or moves too far out stop at current location
			_tooFar = ( _dist > ( _coverDist + 10 ));
			_tooLong = ( time >  _checkTime );
			_elapsedTime = time - _checkTime;
			
			if ( _tooFar || _tooLong ) exitWith
			{
				_coverPosition = getPosATL _unit;
				_unit forceSpeed -1;
				_unit doMove _coverPosition;

				_stopped = true;
				_continue = false;
				
				if (tpwcas_debug > 0) then 
				{
					if (tpwcas_debug == 2) then
					{
						diag_log format ["Unit [%1] moving wrong way to cover [%2]: [%3] m - drop here - tooFar: [%4] - tooLong: [%5] - ([%6] seconds)", _unit, _cover, _dist, _tooFar, _tooLong, _elapsedTime];
					};
					[['red', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
					if (hasInterface) then {
						['red', _coverPosition] spawn tpwcas_fnc_debug_smoke;
					};
		
					deleteVehicle _debug_flag;
				};
			};
			sleep 0.5;
		}
		else
		{	
			_continue = false;
		};
	}; 

	if ( !( _stopped) ) then 
	{
		if (tpwcas_debug > 0) then 
		{
			if (tpwcas_debug == 2) then
			{
				diag_log format["[%1] reached cover [%2]",_unit, _cover];
			};
			[['blue', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
			if (hasInterface) then {
				['blue', _coverPosition] spawn tpwcas_fnc_debug_smoke;
			};
		
			deleteVehicle _debug_flag;
		};
				
		//doStop _unit;
		_unit setUnitPos "down"; 
		sleep (10 + random 15);
			
		//doMove:
		//Order the given unit(s) to move to the given position (without radio messages). 
		//After reaching his destination, the unit will immediately return to formation (if in a group); or order his group to form around his new position (if a group leader). 
		_coverPosition = getPosATL _unit;
		_unit forceSpeed -1;
		_unit doMove _coverPosition;

		if (tpwcas_debug > 0) then 
		{
			[['green', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
			if (hasInterface) then {
				['green', _coverPosition] spawn tpwcas_fnc_debug_smoke;
			};
		};
	}
	else
	{
		if (tpwcas_debug == 2) then {
			diag_log format["[%1] DID NOT reach selected cover [%2]",_unit, _cover];
		};
	};
};

/*
tpwcas_fnc_in_building = 
{
	private ["_building","_logic","_id","_bbox","_b1","_b2","_bbx","_bby","_dotX","_dotY","_bottomLeft","_left","_bottom","_topRight","_right","_top","_pos","_corners","_return"];

	_unit = _this select 0;
	_building = _this select 1;

	//_bbox = boundingboxreal _building;
	//_b1 = _bbox select 0;
	//_b2 = _bbox select 1;
	//_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
	//_bby = (abs(_b1 select 1) + abs(_b2 select 1));
	
	_pos     = getPosATL _unit;
	_corners = boundingboxreal _building;
	_return  = false;

	_dotX = _pos select 0;
	_dotY = _pos select 1;

	_bottomLeft = _corners select 0;
	_left       = _bottomLeft select 0;
	_bottom     = _bottomLeft select 1;

	_topRight   = _corners select 1;
	_right      = _topRight select 0;
	_top        = _topRight select 1;

	// x is between left and right
	// y is between bottom and top
	if (_dotX >= _left && _dotX < _right && _dotY >= _bottom && _dotY < _top) then {
	  _return = true;
	};

	_return
};
*/
