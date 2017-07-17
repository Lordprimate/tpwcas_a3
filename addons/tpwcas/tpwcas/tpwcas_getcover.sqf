/*
GET COVER
- tpwcas_fnc_find_cover: AI will look for cover closeby
*/
//===================================================================================================================================================================================================
//Zooloo75 Firefight improvement system evasive movement
tpwcas_fnc_evasive_move =
{
	_unit = _this select 0;
	if(currentWeapon _unit isEqualTo "") exitWith {};
	
	_chance = round(random 100);
	if(_chance > 75) then
	{	
		_stance = stance _unit;
		_anim = round(random 11);
		_randomPos = [(getPosATL _unit select 0) + random 15 - random 15,(getPosATL _unit select 1) + random 15 - random 15,0];
		
		if (tpwcas_debug > 0) then 
		{	
			if (tpwcas_debug isEqualTo 2) then 
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
		sleep 1;
		
		switch _stance do
		{
			case "PRONE":
			{
				if ((currentWeapon _unit) isEqualTo (handgunWeapon _unit)) then {
				_playanim = selectRandom ["AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDl","AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDr"];
				_unit playMoveNow _playanim;			
				} else {
				_playanim = selectRandom ["AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl","AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr"];
				_unit playMoveNow _playanim;
				};
			};
			case "CROUCH":
			{
				if ((weaponLowered _unit) && ((currentWeapon _unit) isEqualTo (handgunWeapon _unit))) then {
				_playanim = selectRandom ["AmovPknlMrunSlowWpstDl","AmovPknlMrunSlowWpstDr"];
				_unit playMoveNow _playanim;
				};
				
				if ((currentWeapon _unit) isEqualTo (handgunWeapon _unit)) then {
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
				if ((weaponLowered _unit) && ((currentWeapon _unit) isEqualTo (handgunWeapon _unit))) then {
				_playanim = selectRandom ["AmovPercMrunSlowWpstDl","AmovPercMrunSlowWpstDr"];
				_unit playMoveNow _playanim;
				};
				if ((currentWeapon _unit) isEqualTo (handgunWeapon _unit)) then {
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
if (isBurning _this) exitWith {false}; 
private _tfilter = false;
private _type = typeOf _this;
if (_type isEqualTo "") then {
	if (damage _this isEqualTo 1) then {_tfilter = true};
} else {
	scopeName "haveType";
	if (_type find "Wire" > -1) then {_tfilter = true; breakOut "haveType"};
	if (getText (configfile>>"CfgVehicles">>_type>>"vehicleClass") in ["","Ammo","Flag","Helpers","Lamps","Signs","Small_items","Submerged","Structures_Fences"]) then {_tfilter = true};
};
if (_tfilter) exitWith {false};
if ((boundingCenter _this) select 2 < 0.4) exitWith {false};
if (_this getVariable ["ace_cookoff_isCookingOff", false]) exitWith {false};
true
};


tpwcas_fnc_find_cover =
{
	private ["_unit","_status","_cover","_allcover","_objects","_shooter","_lineIntersect","_inCover","_coverPosition","_cPos","_vPos","_dz","_dx","_coverTarget","_isHouse","_bcover","_bcoverPos","_bpos"];

	_unit = _this select 0;
	_status = _this select 1;

	_cover = [];
	_allcover = [];
	_inCover = false;
	
	_unit setvariable ["tpwcas_cover", _status];	
	
	//potential cover objects list
	_objects = [ (nearestObjects [_unit, ["Car","Motorcycle","Tank","HouseBase","Wall","Wreck"], tpwcas_coverdist]), { _x call tpwcas_fnc_cover_filter } ] call BIS_fnc_conditionalSelect;
	_objects append (nearestTerrainObjects [_unit, ["RUIN", "ROCK", "ROCKS", "HIDE", "STACK"], tpwcas_coverdist]);
	
	if ( count _objects > 0 ) then
	{
		// check if current location of unit already provides cover from shooter
		_shooter = _unit getVariable "tpwcas_shooter";
		_lineIntersect = lineIntersects [eyePos _shooter, boundingCenter _unit, _shooter];

		if !(_lineIntersect) then
		{	
			if (tpwcas_debug isEqualTo 2) then 
			{
				diag_log format ["Cover objects for unit %1 found: %2", _unit, _objects];
			};
		
			// start count _objects
			{
				if !(_inCover) then
				{
					//_x is potential cover object
					_bbox = boundingBoxReal _x;
					_dz = abs(((_bbox select 1) select 2) - ((_bbox select 0) select 2));//height
					_dx = abs(((_bbox select 1) select 0) - ((_bbox select 0) select 0));//width
					
					_cPos = (getPosATL _x);
					_vPos = ((getPosASL _shooter) vectorFromTo (getPosASL _unit));
					
					
					//set coverposition to 3 m behind the found cover
					_coverPosition = [((_cPos select 0) + (3 * (_vPos select 0))), ((_cPos select 1) + (3 * (_vPos select 1))), (_cPos select 2)];
					
					//Any object which is high and wide enough is potential cover position, excluding water
					if ( (_dx > 2) && {(_dz > 1)} && {!(surfaceIsWater _coverPosition)}) then
					{
						if ( ( _coverPosition distance _unit ) < 0.75 )  exitWith 
						{
							if (tpwcas_debug > 0) then 
							{	
								if (tpwcas_debug isEqualTo 2) then 
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
			// end count _objects
		}
		else
		{
			if (tpwcas_debug > 0) then 
				{
					if (tpwcas_debug isEqualTo 2) then 
					{
						diag_log format ["abort: [%1] in cover from shooter [%2] : shooter [%2 cannot see me]", _unit, _shooter];
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
		_coverTarget = (_cover select 0) select 0;
		_coverPosition = (_cover select 0) select 1;		
		_isHouse = false;
		if ((_coverTarget isKindOf "HouseBase") && ([_coverTarget,3] call BIS_fnc_isBuildingEnterable)) then 
		{
			//check chosen cover is a enterable building, if so select random building pos
			_bcover = [];
			_bpos = _coverTarget buildingPos -1;
			
			if (count _bpos > 2) then
			{
				_bpos deleteAt 0;
				_bpos deleteAt 1;
				_bpos = selectRandom _bpos;
				_bcover = _coverTarget buildingPos ((_bpos select 2));
				_isHouse = true;
			};
		};
		if (_isHouse) exitWith //if closest cover is a building, choose random builcing pos and GO.
		{
			if (tpwcas_debug > 0) then 
			{
				_coverTarget = (_cover select 0) select 0;
				_coverPosition = (_cover select 0) select 1;
				_dx = (_cover select 0) select 2;
				_dz = (_cover select 0) select 3;
				if (tpwcas_debug isEqualTo 2) then 
				{
					diag_log format ["[%1] cover: [%2] - distance [%3] - box: [%4] - (size: x:%5 - z:%6)]", _unit, _coverTarget, _coverPosition distance _unit, boundingBoxReal _coverTarget, _dx, _dz]; 
				};
				[['yellow', _coverPosition],"tpwcas_fnc_debug_smoke",true,false] spawn BIS_fnc_MP;
				if (hasInterface) then {
				['yellow', _coverPosition] spawn tpwcas_fnc_debug_smoke;
				};
			};
			//_cover set (_cover select 0), [_coverTarget, _bcover, _dx, _dz];
			[_unit, [_coverTarget, _bcover, _dx, _dz], _shooter] spawn tpwcas_fnc_move_to_cover;
		};
		
		if (tpwcas_debug > 0) then 
		{
			//_coverTarget = (_cover select 0) select 0;
			_coverPosition = (_cover select 0) select 1;
			_dx = (_cover select 0) select 2;
			_dz = (_cover select 0) select 3;
			if (tpwcas_debug isEqualTo 2) then 
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
		_lineIntersect = lineIntersects [eyePos _shooter, boundingCenter _unit, _shooter];
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
	private ["_unit","_cover","_coverArray","_coverPosition","_coverDist","_coverTarget","_cPos","_vPos","_debug_flag","_dist","_shooter","_continue","_logOnce","_startTime","_checkTime","_stopped","_tooFar","_tooLong","_elapsedTime","_whileloop"];
	
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
	_checkTime =  (_startTime + (2 * _coverDist) + 30);
	_whileloop = 0;
	
	while { _continue } do 
	{
		if ( _logOnce && (tpwcas_debug > 0) ) then 
		{
			_debug_flag = "Land_TTowerSmall_2_F" createVehicle [0,0,0];
			_debug_flag enableSimulation false;
			_debug_flag setPosATL _coverPosition;

			if (tpwcas_debug isEqualTo 2) then 
			{
				diag_log format ["Unit [%1] moving to cover [%2]: distance [%3] m", _unit, _cover, _coverDist];
			};
			_logOnce = false;
		};
		
		_dist = round ( _unit distance _coverPosition );
						
		if ( !( unitReady _unit ) && {( alive _unit )} && {( _dist > 1 )} ) then
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
					if (tpwcas_debug isEqualTo 2) then
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
			sleep 1;
			_whileloop = _whileloop + 1;
			if (_whileloop in [10,20,30,40]) then
			{
				_unit doMove _coverPosition;
			};
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
			if (tpwcas_debug isEqualTo 2) then
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
		if (tpwcas_debug isEqualTo 2) then {
			diag_log format["[%1] DID NOT reach selected cover [%2]",_unit, _cover];
		};
	};
};