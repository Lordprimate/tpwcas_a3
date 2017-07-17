TPWCAS - TPWC AI Suppression System for ArmA 3

Description: Singleplayer, Multiplayer and Dedicated Server Compatible AI Suppression System
Authors: TPW && -Coulum- && fabrizio_T && Ollem && Lordprimate
Latest Version: 5.3
Released: 20131030
Mod Package: both addon and scripts 
Requirements: CBA

Introduction:
-------------
One of the things sorely missing from Arma2 is reaction to passing bullets. An AI unit will often stand quite happily whilst bullets whiz by. This makes effective suppression of AI enemies difficult - you basically always have to aim to kill them since you can't make them keep their heads down by shooting nearby.

This addon aims to address this problem by making AI units react to passing projectiles. If a bullet snaps by within around 10m of an AI unit, it will crouch/kneel (depending on movement), and if more than around 10 bullets pass by a unit in 5 seconds, the unit will drop/crawl. After 10 seconds without bullets, the unit will return to its previous stance. 

Additionally, suppressive fire can alter the aiming shake, accuracy and courage of the suppressed unit. The more fire directed near a unit, the lower its skills will become. Nearby casualties will further decrease a unit's courage. After 5 or so seconds without bullets, the skills will gradually return to normal. Player units will optionally experience some visual effects if suppressed (camera shake, vision blur and darkening).

Currently there is no "suppressed" eventhandler in the game engine, so TPWCAS aims to mimic one by constantly monitoring whether any active bullet/shell projectile objects have units within a 10m radius. This allows TPWCAS to work for any opfor, blufor or independent on the map, whether editor-placed or spawned.

TPWCAS significantly changes gameplay, allowing for longer engagements and more thought required to survive them.

IMPORTANT NOTE:
TPWCAS is not an all-in-one AI behaviour modification mode. Its primary purpose at this time is to cause units to duck/drop and lose some shooting competence under suppressive fire. It's designed to play well with mods which DO alter AI behaviours under combat stress, and you are encouraged to use these if you require additional realism such as moving to cover.
An optional feature is included to trigger a basic move to cover by AI in case of close by cover. 

VERY IMPORTANT NOTE:
TPWCAS started life as an SP only mod, but a large amount of effort has gone into modifying the bullet detection, suppression and visual debugging framework to work for MP and dedicated server. While every effort has gone into testing in SP, MP and dedi, we simply cannot vouch for perfect operation under all circumstances. 


Demo video:
-----------
Here's what TPWCAS looks like in action. Many thanks to McLupo for this video.
http://www.youtube.com/watch?v=WBJ-n...1&feature=plcp


Features:
---------
TPWCAS enables stance and skill modification under fire.
 
* Units react to bullets passing within 10m.
* Units on foot or operating vehicle or static guns are affected. 
* Units driving are unaffected.
* Only uninjured units are affected.
* Bullets fired from less than 25m away are ignored.
* Bullets from small calibre pistols and SMG are ignored.
* Units react differently according to the side of the shooter.
* Friendly shooter: > 0 bullets --> kneel/crouch.
* Enemy shooter: 1 - 10 bullets --> kneel/crouch, > 10 bullets -->drop/crawl. 
* Units regain previous stance after 10 or so seconds without nearby bullets.
* Friendly shooter: no skill reduction.
* Enemy shooter: skills reduced according to number of bullets.
* Units gradually regain skills after 5 or so seconds without bullets.
* Shooter may be "revealed" to the suppressed unit.
* Units are more easily suppressed if there are nearby friendly casualties.
* Player experiences visual effects if suppressed.

Changes version 5.5.2
- Hashed out call for ASRAI function "asr_ai3_main_fnc_setUnitSkill", no idea why its throwing an error. however, it seems to be reduntant anyway, as it calls asrai set skill function again after ASRAI the mod has already done it....


Changes version 5.5.1
- Update to ASR_AI classnames "asr_ai3_sysaiskill_fnc_setUnitSkill" is now "asr_ai3_main_fnc_setUnitSkill" should now work properly/ and in conjuction with ASR_AI3 again.
- Updated check for ASR_AI3 running. Using "asr_ai3_main" as "asr_ai3_danger" was removed from ASR_AI3. Again now tpwcas will now ASR_AI is running and work together appropriatly.
- Removed a few animations "Bunnyhop","L/R sideProne"
- ReWrote evasive manuver. Script check's to see the stance of the unit supressed, and the weapon (pistol / rifle), and weather or not its raised or lowerd. (If the unit is holding a pistol and has it lowered they will get a animation with a lowerd pistol for smooth animation interpolation)
- Removed One Behavior change, "Stealth" mode call was removed.
- Added Prone Roll if being supressed by multipule bullets And are already Prone And are in the open.. Hopefully AI will only roll when Line of Site is clear to the shooter (Out of Cover).
- Added check to see if unit is in cover before performing evasive manouver. (So they dont jump out from cover) 
- Updated Rabolo's object filter for cover positions.
- Added nearestTerrainObjects search based off of ASRAI3's filter, added a few perameters just to make sure they do not use bushes and a few other things that are not good for cover. ( when did they add this)
- Reintroduced CBA_fnc_addPerFrameHandler for single player. see how that goes?
- Minor code optimizations (replaced nearestObjects with nearEntities, reduced some probabilities)
- KNOWN ISSUES IN RPT: 1) DEBUG SPHERE HAS NO SOME MISSING CONFIG STUFF?? so just dont use debugging for your main missions and youll be ok! 
                       2) Sometimes when a AI dies or Person dies tpwcas throws a small error while it removes the entity from its list.. error goes away this happend before, as well, if i remember correctly.
		       3) ??

Changes version 5.5:
- update: player controlled AI should no longer change combat behaviour
- update: added simple check to verify if unit is in building to recover to standing after suppression

Changes version 5.3:
- updated for Arma 3 compatibility
- added evasive manouvres
- suppression will impact combat behaviour to allow BIS default actions to impact AI behavior too
- code improvements

Changes version 5.01:
- update: fixed minor bug due to typo

Changes version 5.0:
- update: fixed error messages which appeared after latest A2 beta patch

Changes version 4.5:
- New: fully automatic detection and support of HeadLess client
- New: 'find cover' function has been made FPS aware too: below configurable server FPS threshold (default 17 FPS) find cover function will be skipped to save some CPU for more important tasks
       new usercondig file entry: // 19 AI SEARCH COVER REQUIRED MINIMAL SERVER FPS, ELSE PROCESS IS SKIPPED
       tpwcas_getcover_minfps = 17;
- Update: updated bullet detection framework based on Fabrizio_T's latest bDetect v0.76 framework.
- Update: tpwcas_mode = 5 (forced disable of tpwcas) will become 'tpwcas_mode = 0' ('tpwcas_mode = 5' will be deprecated*)
- Update: embedded 'tpwlos' will be disabled by default and can be switched on by changing setting in userconfig file
- Fixed: all hint commands will be optional and by request have been replaced by hintsilent
- Fixed: other really minor changes

Changes version 4.x:
- New: Merger of TPWC_AI_SUPPRESS and TPWCAS_DSC version
- New: Same mod can be used for SinglePlayer, Dedicated Server, and Client-Server setup
- Auto detection of SinglePlayer setup (tpwcas = 1)
- Auto detection of MultiPlayer Dedicated Server setup (tpwcas = 3)
- Auto disable of client if Server started in Dedicated Server mode (server tpwcas = 3/client tpwcas = 5)
- Manual config option to configure client/server setup (tpwcas = 2)
- Manual config option to disable TPWCAS (tpwcas = 5)
- Experimental config mode specifically for 'Headless Clients' (tpwcas = 4)
- Update: Performance improvements and code optimisations
- Update: Bullet detection frequency (==server load) will always automatically reduce if server or SP FPS drops
- Fixed: all files names to lowercase for Linux Server compliance
- Fixed: tpwcas will work after respawn
- Fixed: Vehicle EventHandlers for vehicles will not be duplicated in case of locality change
- New: basic take cover functionality: can be disabled/enabled in config file
- New: config parameter to set radius to search for cover (recommended to keep low number)
- New: Embedded TPW LOS (Line Of Sight - slightly modified version): can be disabled/enabled in config file
- New: Embedded TPW LOS will automatically pause when (server) FPS is below (configurable) threshold value
- New: Civilians will run in random directions when bullets are close to them
- New: Handgrenades and AT/RPG will cause suppression too
- New: TPWCAS Logic Modules (F7 in editor) to allow Missionmakers to overrule (server) config file parameter settings to:
- Disable TPWCAS (if enabled in userconfig file)
- Enable TPWCAS (if disabled in userconfig file)
- Disable TPWCAS embedded TPW LOS (if enabled in userconfig file)
- Enable TPWCAS embedded TPW LOS (if disabled in userconfig file)
- Disable TPWCAS embedded Find Cover (if enabled in userconfig file)
- Enable TPWCAS embedded Find Cover (if disabled in userconfig file)

Visual Debugging:
----------

Coloured debug balls can be enabled to assist to visualize TPWCAS suppression functionality:

* No ball - unsuppressed.
* Green ball - close friendly fire detected - going crouched
* Yellow ball - sporadic enemy fire detected - going crouched
* Red ball - threshold value of enemy fire detected - going prone
* Black ball - unit is fleeing (fleeing does not mean the unit is running away, but will not be able to be suppressed).

* Purple ball - indicates LOS (Line Of sight) was triggered

Smoke and flagpoles are related to take cover and civilian runaway trigger:
Enemy AI:
* Yellow smoke + flag pole - selected cover position
* Blue smoke - unit reached cover
* Green smoke - unit stayed a few random seconds in/close to cover position and default AI behavior will take over again
* Red smoke - unit went (too far) to wrong direction or took too long to reach cover and default AI behavior will take over again
* Cyan smoke - unit is already in cover (or at least no Line of Sight to shooter)
Civilians:
* Yellow smoke + flag pole - runaway destination position
* Blue smoke - unit reached selected destination and should go prone
* Green smoke - unit stayed a few random (20 to 40 seconds) at position and default AI behavior will take over again
* Red smoke - unit went (too far) to wrong direction or took too long to reach cover and default AI behavior will take over again 

Readme:
    Please read this for full details of TPWCAS, including features, installation, configuration, caveats, credits and changelog.

Installation:
-------------
TPWCAS comes as a script version and an addon version.
CBA (community base addons) is required for both versions.

Script version: 
Save tpwcas and all the scripts in it to your mission directory.
Call it with: null = [<tpwcas mode value>] execvm "tpwcas\tpwcas_script_init.sqf", in your init.sqf or in the init of any object on the map.

Addon version:
Unpack the addon version and call it by your favourite method. For more info on running mods please check out http://www.armaholic.com/plug.php?e=faq&q=18
Copy the configuration userconfig\tpwcas_v2.hpp file to: your_arma_directory\userconfig\tpwcas\tpwcas_v2.hpp
To configure it adjust the parameter values in the config file

Debugging:
----------
TPWCAS enables text and graphic debugging, and both are enabled by default for this beta release. If switched on, graphic debugging will show a coloured ball over any units. This may also come in handy for training. Markers are also shown on map. You may also switch on dDetect logging, but be warned this may lead to a lot of disk activity and a large RPT file.

* No ball - unsuppressed.
* Green ball - suppressed by friendly fire.
* Yellow ball - suppressed by sporadic enemy fire.
* Red ball - suppressed by heavy enemy fire.
* Black ball - unit is fleeing (fleeing does not mean the unit is running away, but will not be able to be suppressed).

If text debugging is switched on, then coloured floating text showing the number of enemy bullets will be displayed under each unit. 

* White text - unsuppressed.
* Green text - suppressed by friendly fire.
* Yellow text - suppressed by sporadic enemy fire.
* Red text - suppressed by heavy enemy fire.
* Black text - unit is fleeing (fleeing does not mean the unit is running away, but will not be able to be suppressed).

Text debugging is not as pretty, but potentially more informative, and eliminates problems that some people have reported where debug balls are registered as civilians, and lead to a decrease in performance. Text debugging is disabled on dedicated server.


Configuration:
--------------
TPWCAS is highly configurable. The script version has a number of well commented variables to change aspects of the system. 
The addon version allows the same variables to be changed in the tpwcas_v2.hpp config file.
The config file is a prerequisite: copy the tpwcas\tpwcas_v2.hpp directory+file to <your arma2 dir>\userconfig directory. 
Each entry in the config file has a description about the usage.

Please note: The format of tpwcas_v2.hpp introduced with v4.00 is different than previous versions.

TPWCAS Modes:
-------------

* tpwcas_mode 1: Both player and all available AI will be subject to suppression as well as TPW LOS, and be able to trigger suppression
    - Single Player mode - automatically set
* tpwcas_mode 2: Multiplayer mode - All available AI and players will be subject to suppression as well as TPW LOS, and be able to trigger suppression.
    - Multiplayer mode - requires setting parameter in userconfig file
    - Requires tpwcas on both server and all players system (may include HC as well).
    - Bullet detection framework active on both server and client pc's, to allow suppression of player and AI local to each system.
    - Embedded TPW LOS will check Line of Sight for all AI and players
	- Auto detection for Headless Client mode: in combination with tpwcas_mode 2 server mode this mode will activate both player and AI triggered suppression for any AI local to HC
* tpwcas_mode 3: Supposed to be used for AI suppression by player shot bullets only. TPW LOS is only active for players who are in Line Of Sight to enemy AI.
    - Multiplayer mode - default MP setting, does not require setting parameter in userconfig file
    - Recommended setting for MP coop versus enemy AI.
    - No client needed (if available at client tpwcas will be automatically deactivated on that client).
    - There will be no player suppression (i.E. no camshake and no visual blur)
    - Any friendly AI local to player (= member of players group) will not be subject to suppression, nor will trigger AI suppression
    - Friendly AI local to server (= not member of players group) will be subject to player friendly fire suppression, but will not trigger AI suppression
    - Embedded TPW LOS will check only if enemy AI has Line of Sight to any player (so not for AI versus AI)
	- Auto detection for Headless Client mode: in combination with tpwcas_mode 3 server mode this mode will activate player triggered suppression for any AI local to HC
* tpwcas_mode 0: Disable tpwcas mod
    - if TPWCAS is set to 0 (disabled) in userconfig, mission makers can overrule by placing a 'TPWCAS module' on the map to enable TPWCAS mode 2 or 3 for specific mission
    - if TPWCAS is set to enabled in userconfig, mission makers can overrule by placing a 'TPWCAS module' on the map to disable TPWCAS mode (set to 0) for specific mission

Caveats:
--------
* The system uses setunitpos to change unit stance. The stance changes are subordinate to those issued by a player to a squad. A squad given "stand" orders will not duck when bullets start flying. Nor will a fleeing unit. Nor will a unit ordered into cover. Nor may units taken over by various FSMs.
* TPWCAS is not bulletproof (pun intended), and may not operate perfectly under conditions of very heavy fire by multiple units or, if the framerate is too low.
* TPWCAS ignores rounds fired from pistols and low calibre SMGs, and subsonic ammunition. You won't be able to suppress the enemy by waving your pistol around. 
* TPWCAS implements changes to accuracy, courage etc under fire. The system should play nicely with ACE, ASR_AI, COSLX and other AI behaviour mods, but please report any clashes. 
* As far as the authors can tell, TPWCAS causes minimal drops to framerate even on low spec machines, with 50 or so AI taking pot shots at each other. Your mileage may vary depending on computer specs and number of AI. We take no responsibility if your computer explodes. 
* Debug balls are registered by the game engine as civilians (!), and may cause some unwarranted effects. Use text debugging if this occurs.
* TPWCAS is in its infancy and probably won't work the way everyone wants it to. We welcome any feedback and suggestions.


Thanks:
-------
* Variable, Jedra and 2nd Ranger for initial ideas and suggestions.
* Orcinus, Kremator and CameronMcDonald for valuable input, suggestions and encouragement.
* Froggluv and Pellejones for performance testing.
* Robalo for helping to make his incredible ASR_AI skills addon and TPWCAS work nicely together, and for additional code ideas and help. 
* Falcon_565 for demonstrating the power of cba_fnc_addPerFrameHandler.
* Foxhound for ongoing support of mod makers.
* BIS for an amazing piece of software which even allows scope for mods like this.


Changelog:
----------
* 1.00 20120623 
	- initial release

* 1.01 20120625 
	- Mode 3: Plays better with ASR AI skills. 
	- Units set to "combat" behaviour when suppressed. 
	- All modes: per frame speed optimisations.    

* 1.02 20120627 
	- Total rewrite and optimisation. 
	- Improved performance with more units. 
	- Fine tuning of skill and stance parameters under suppression. 
	- Player suppression effects (optional). 
	- Some MP optimisation (but still WIP). 
	- Units can be suppressed by vehicle fire.

* 1.04 20120630 
	- Further optimisation of bullet detection. 
	- Removed "combat mode" under suppression, since the engine and any AI mods will handle this more effectively. 
	- Significantly improved debug mode, debug balls disappear when injured/dead. 
	- Suppression not applied to injured units. 
	- Unsuppressed prone units will not crouch if fired at. 

===

* 2.00beta 20120702 
	- Total rewrite of the bullet detection code (bDetect) by fabrizio_T. 
	- Added filtering so that suppression calculations are only performed for uninjured combatants less than 1000m from the player. 
	- Removed stance-only suppression mode. 
	- bDetect 0.5.

* 2.01beta 20120703 
	- Added ability to configure stance only changes under suppression. 
	- Minor changes to accommodate changes to bdetect variables. 
	- bDetect 0.63.

* 2.02beta 20120703 
	- Minimum skill value under suppression is now configurable. 
	- Reveal amount is configurable. 
	- bDetect 0.64.

* 2.03beta 20120704 
	- Removed errors in debugging code which lead to FPS drops.
	- bDetect 0.65.

* 2.04beta 20120705 
	- Fixed config errors.
	- Fixed serious regressions with skills handling, which was leading to 0 skills, not recovering. 
	- Fixed debug errors causing debug balls to remain over dead units. 
	- Reveal function properly configurable. 
	- ASR AI skills properly recognised again.
	- Shooter reveal to suppressed units can be toggled. 
	- Removed some redundant checks now handled by bDetect.
	- Maximum bullet distance is now configurable.  
	- bDetect 0.66. 

* 2.05beta 20120706 
	- Code cleanup and optimisation.
	- Private variable declarations for each function.
	- Simplified skills modification, will not head to 0 as quickly.
	- Units are more easily suppressed if there are friendly casualties within 20m.
	- Simplified ASR AI skill recognition.
	- bDetect startup hint will not be shown if TPWCAS startup hint is not shown.
	- bDetect 0.67 (modified to allow units to suppress when shooting uphill).

* 2.06beta 20120708
	- Added ability to configure whether units will flee when morale/courage drops too low.
	- Improved visual debugging code
	- Code has been modularised, each function is compiled from its own sqf.
	- Courage does not drop so rapidly under fire (should lead to less premature fleeing).
	- bDetect 0.67.

* 2.07beta 20120710
	- Added floating text based debugging.
	- bDetect start hint now correctly not displayed if TPWCAS hint is not displayed.
	- Courage is only decreased if there are nearby friendly casualties.
	- bDetect 0.67.	
	
===

* 3.00beta 20120714
	- Bullet detect, supression and debugging framework now works in SP, MP and Dedicated (Ollem and Fabrizio).
	- Significant code overhaul (!) and cleanup.
	- Text debugging scales with distance.
	- bDetect 0.72 (SP/MP/Dedi).

* 3.01beta 20120716
	- Additional pistol and subsonic magazines added
	- Fixed colour error with debugging map markers.
	- MP and dedicated server debug ball colour handling improved.
	- Units with stances set to crouch/prone by other AI mods will not be forced to "auto"" position when unsuppressed.
	- Fixed already prone units crouching under suppression, when using ACE (thanks Robalo).
	- Reveal shooter is disabled if using ASR_AI.
	- Highly skilled units will suffer lower courage reduction under fire.
	- bDetect logging off by default, may be toggled on. 
	- bDetect 0.72


* 3.01 20120717
	- Fixed debugging locality issue
	
* 3.02 20120805
	- Fixed bDetect MP desync issue
	- bDetect 0.73

* 3.03 20120807
	- Correct bDetect call in script version
	- Correct wait for bDetect initialisation
	- Cleanup of config variables in addon version
	- Changes to stance modification code to make it CBA independent
	- bDetect 0.73
	
* 3.04 20120810
	- Fixed player shake under sporadic enemy fire
	- Added some randomisation so that units aren't suppressed by exactly the number of bullets specified in the shot threshold
	- bDetect vehicle fixes
	- bDetect 0.74

===

* 4.1 20121221
	- New: Merger of TPWC_AI_SUPPRESS and TPWCAS_DSC version
	- New: Same mod can be used for SinglePlayer, Dedicated Server, and Client-Server setup
		- Auto detection of SinglePlayer setup (tpwcas = 1)
		- Auto detection of MultiPlayer Dedicated Server setup (tpwcas = 3)
		- Auto disable of client if Server started in Dedicated Server mode (server tpwcas = 3/client tpwcas = 5)
		- Manual config option to configure client/server setup (tpwcas = 2)
		- Manual config option to disable TPWCAS (tpwcas = 5)
		- Experimental config mode specifically for 'Headless Clients' (tpwcas = 4)
	- Update: Performance improvements and code optimisations
	- Update: Bullet detection frequency (==server load) will always automatically reduce if server or SP FPS drops
	- Fixed: all files names to lowercase for Linux Server compliance
	- Fixed: tpwcas will work after respawn 
	- Fixed: Vehicle EventHandlers for vehicles will not be duplicated in case of locality change
	- New: basic take cover functionality: can be disabled/enabled in config file
	- New: config parameter to set radius to search for cover (recommended to keep low number)
	- New: Embedded TPW LOS (Line Of Sight - slightly modified version): can be disabled/enabled in config file
	- New: Embedded TPW LOS will automatically pause when (server) FPS is below (configurable) threshold value
	- New: Embedded TPW LOS config option for maximum 'knowsabout' value: if higher spotter-target combi will be ignored while already aware of presence
	- New: Civilians will run in random directions when bullets are close to them
	- New: Handgrenades and AT/RPG will cause suppression too
	- New: TPWCAS Logic Modules (F7 in editor) to allow Missionmakers to overrule (server) config file parameter settings to:
		- Disable TPWCAS (if enabled in userconfig file)
		- Enable TPWCAS (if disabled in userconfig file)
		- Disable TPWCAS embedded TPW LOS (if enabled in userconfig file)
		- Enable TPWCAS embedded TPW LOS (if disabled in userconfig file)
		- Disable TPWCAS embedded Find Cover (if enabled in userconfig file)
		- Enable TPWCAS embedded Find Cover (if disabled in userconfig file)

* 4.5 20130217
	- New: automatic detection and support of HeadLess client (thx to Glowbal for auto detection code - hc mode 'tpwcas_mode = 4' will be deprecated*)
	- New: 'find cover' function has been made FPS aware too: below configurable server FPS threshold (default 19 FPS) find cover function will be skipped to save CPU for more important tasks
	- Update: updated bullet detection framework based on Fabrizio_T's latest bDetect v0.76 framework.
	- Update: tpwcas_mode = 5 (forced disable of tpwcas) will become 'tpwcas_mode = 0' ('tpwcas_mode = 5' will be deprecated*)
	- Update: embedded 'tpwlos' will be disabled by default and can be switched on by changing setting in userconfig file
	- Fixed: all hint commands will be optional and by request have been replaced by hintsilent
	- Fixed: other really minor changes
