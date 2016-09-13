// si le module est activé
if ((getNumber (missionConfigFile >> "MissionBriefing" >> "enabled")) == 1) then {
	_diaries = (missionConfigFile >> "MissionBriefing" >> "Diaries") call BIS_fnc_getCfgSubClasses;

	for [{_i = (count _diaries) - 1}, {_i >= 0}, {_i = _i - 1}] do {
		player createDiaryRecord [
			"Diary", [
				getText (missionConfigFile >> "MissionBriefing" >> "Diaries" >> (_diaries select _i) >> "title"),
				getText (missionConfigFile >> "MissionBriefing" >> "Diaries" >> (_diaries select _i) >> "content")
			]
		];
	};
};