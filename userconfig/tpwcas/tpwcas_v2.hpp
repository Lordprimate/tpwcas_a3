/*
CONFIGURATION FILE FOR TPWCAS v5.3
*/


/////////////////////
// GENERAL VARIABLES
/////////// /////////

// 0 STARTUP HINT (TPWCAS & BDETECT). 0 = NO HINT, 1 = HINT.
tpwcas_hint = 1;

// 1 DELAY BEFORE SUPPRESSION FUNCTIONS START. ALLOWS TIME FOR OTHER MODS TO INITIALISE ETC.
tpwcas_sleep = 15;

// 2 DEBUGGING. 0 = NO DEBUGGING, 1 = DISPLAY COLOURED BALLS OVER ANY SUPPRESSED UNITS, 2 = BALLS + BDETECT LOGGING.
tpwcas_debug = 0;

////////////////////
// BULLET VARIABLES
////////////////////

// 3 BULLET IGNORE RADIUS (M). BULLETS FROM A SHOOTER CLOSER THAN THIS WILL NOT SUPPRESS.
tpwcas_ir = 25;

// 4 MAXIMUM BULLET DISTANCE (m). A BULLET FURTHER THAN THIS FROM ITS SHOOTER WILL NOT SUPPRESS. SET LARGER IF YOU PLAN ON DOING A LOT OF SNIPING - BUT MAY IMPACT PERFORMANCE.
tpwcas_maxdist = 1500;

// 5 BULLET LIFETIME (sec). BULLETS STILL ALIVE THIS LONG AFTER BEING SHOT ARE IGNORED.
tpwcas_bulletlife = 3;

// 6 SHOT THRESHOLD. MORE SHOTS THAN THIS WILL CAUSE UNIT TO DROP/CRAWL.
tpwcas_st = 6;

// 7 PISTOL AND SMG AMMO TO IGNORE. ADD CUSTOM AMMO (EG SUPPRESSED) OR CHANGE TO TASTE.
tpwcas_mags[] =	{};

/////////////////////////
// SUPPRESSION VARIABLES
/////////////////////////

// 8 AI SKILL SUPPRESSION. 0 = SKILLS WILL NOT BE CHANGED, ONLY STANCE. 1 = SKILLS AND STANCE CHANGED UNDER SUPPRESSION.
tpwcas_skillsup = 1;

// 9 MINIMUM SKILL VALUE, NONE OF A UNIT'S SKILLS WILL DROP BELOW THIS UNDER SUPPRESSION.
tpwcas_minskill = 0.65; // minimum 20% of original skill

// 10 REVEAL VALUE WHEN SUPPRESSED. 0 = REVEAL DISABLED. <1 = SUPPRESSED UNIT KNOWS NOTHING ABOUT SHOOTER. 4 = UNIT KNOWS THE SHOOTER'S SIDE, POSITION, SHOE SIZE ETC.
//    [ 0 , 1.5 ] - side unknown, some position offset, identified as SoldierWB
//    [ 1.5, 1.6 ] - side identified, subjective cost set
//    [ 1.6, 2 ] - type identified better (USMC_Soldier_Base)
//    [ 2 , 3.6 ] - type identified precisely (USMC_Soldier)
//    [ 3.6, 4 ] - position identified precisely
tpwcas_reveal = 0;

// 11 UNITS CAN FLEE IF COURAGE AND MORALE TOO LOW. 0 = UNITS WILL NOT FLEE. 1 = UNITS WILL FLEE. SET TO 0 IF TOO MANY UNITS ARE FLEEING OR UNSUPPRESSABLE.
tpwcas_canflee = 0;

///////////
//TPW LOS VARIABLES
///////////

// 12 EMBEDDED TPWLOS: DISABLE = 0, ENABLE = 1
tpwcas_los_enable = 0;

// 13 MAXIMUM LOS DISTANCE (M). LOS STUFF ONLY WORKS FOR UNITS CLOSER THAN THIS.
tpwcas_los_maxdist = 0;

// 14 MINIMUM LOS DISTANCE (M). ENEMIES ARE CONSIDERED "VISIBLE" IF IN LOS, NO MATTER WHAT (CAMO, STANCE, VISIBILITY), IF LESS THAN THIS DISTANCE - EXCEPT FOR SNIPERS AND SPOTTER WITH GHILLIE SUITS
tpwcas_los_mindist = 2;

// 15 EMBEDDED TPWLOS REQUIRED MINIMAL SERVER FPS, ELSE PROCESS IS SKIPPED
tpwcas_los_minfps = 100;

// 16 EMBEDDED TPWLOS MAXIMAL KNOWSABOUT VALUE: ABOVE WILL SKIP TPWLOS FOR THIS SPECIFIC SPOTTER-TARGET COMBI
//    VALUES: SEE TPWCAS_REVEAL ABOVE
tpwcas_los_knowsabout = 5;
		
// 17 AI SEARCH COVER: DISABLE = 0, ENABLE = 1 
tpwcas_getcover = 1;

// 18 AI SEARCH COVER MAX DISTANCE (M). RECOMMENDED TO KEEP LOW NUMBER (5 to 12)
tpwcas_coverdist = 25;

// 19 AI SEARCH COVER REQUIRED MINIMAL SERVER FPS, ELSE PROCESS IS SKIPPED
tpwcas_getcover_minfps = 10;

// 20 PLAYER SUPPRESSION SHAKE. 0 = NO SUPPRESSION, 1 = SUPPRESSION.    
tpwcas_playershake = 1; //FORCED OFF IF RUNNING ON DEDICATED SERVER in tpwcas mode 3

// 21 PLAYER SUPPRESSION VISUALS. 0 = NO SUPPRESSION, 1 = SUPPRESSION.     
tpwcas_playervis = 1; //FORCED OFF IF RUNNING ON DEDICATED SERVER in tpwcas mode 3

// 22 TPWCAS MODE: if not specified will switch to '1' for SP and '3' for MP games
//    Remove '//' in front of 'tpwcas_mode'to activate the setting:
//		mode 0: forced setting to disable tpwcas completely: e.g. set tpwcas_mode = 0; in init of mission to disable. 
//		mode 1: Single Player (determined automatically in case of SP usage)
//		mode 2: Multiplayer (automatic default MP value for either locally hosted or dedicated server,
//				full funcionality in combination with required tpwcas mod client on each player pc 
//		mode 3: Dedicated server coop play mode - only player shot bullets will suppress AI local to server
//
//	DEPRECATED:	mode 4: Headless client: (experimental) special manual mode setting to enable AI suppression by player shot bullets local to HC
//	DEPRECATED:	mode 5: Manual mode to disable tpwcas completely: e.g. set tpwcas_mode = 5; in init of mission to disable. 
tpwcas_mode = 2;
