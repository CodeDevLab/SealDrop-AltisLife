/*
	File: fn_syncData.sqf
	Author: Bryan "Tonic" Boardwine"
	
	Description:
	Used for player manual sync to the server.
*/
_fnc_scriptName = "Player Synchronization";
private["_exit"];
if(isNil "life_session_time") then {life_session_time = false;};
if(life_session_time) exitWith {hintSilent localize "STR_Session_SyncdAlready";};

switch (typeName life_fnc_MP_packet) do
{
	case "ARRAY":
	{
		if(count life_fnc_MP_packet == 0) exitWith
		{
			_exit = true;
		};
	};
	
	default {_exit = true;};
};

if(!isNil "_exit") exitWith {hintSilent localize "STR_Session_SyncCheater";};

[] call SOCK_fnc_updateRequest;
hintSilent localize "STR_Session_SyncData";
[] spawn
{
	life_session_time = true;
	uiSleep (5 * 60);
	life_session_time = false;
};
	