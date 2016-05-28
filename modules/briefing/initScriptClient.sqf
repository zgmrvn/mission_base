// si le module est activé
if ((getNumber (missionConfigFile >> "Briefing" >> "enabled")) == 1) then {
	{
		player createDiaryRecord [
			"Diary", [
				getText (missionConfigFile >> "Briefing" >> "Diaries" >> _x >> "title"),
				getText (missionConfigFile >> "Briefing" >> "Diaries" >> _x >> "content")
			]
		];
	} forEach ((missionConfigFile >> "Briefing" >> "Diaries") call BIS_fnc_getCfgSubClasses);
};