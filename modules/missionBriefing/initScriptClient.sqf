// si le module est activé
if ((getNumber (missionConfigFile >> "MissionBriefing" >> "enabled")) == 1) then {
	{
		player createDiaryRecord [
			"Diary", [
				getText (missionConfigFile >> "MissionBriefing" >> "Diaries" >> _x >> "title"),
				getText (missionConfigFile >> "MissionBriefing" >> "Diaries" >> _x >> "content")
			]
		];
	} forEach ((missionConfigFile >> "MissionBriefing" >> "Diaries") call BIS_fnc_getCfgSubClasses);
};