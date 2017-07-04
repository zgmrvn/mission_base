/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

// si le module est activé
if ((getNumber (missionConfigFile >> "MissionBriefing" >> "enabled")) == 1) then {
	private _diaries = (missionConfigFile >> "MissionBriefing" >> "Diaries") call BIS_fnc_getCfgSubClasses;

	for [{private _i = (count _diaries) - 1}, {_i >= 0}, {_i = _i - 1}] do {
		private _paragraphs	= getArray (missionConfigFile >> "MissionBriefing" >> "Diaries" >> (_diaries select _i) >> "paragraphs");
		private _content	= "";

		// concaténation des paragraphes
		{
			private _separator = ["<br/><br/>", ""] select (_forEachIndex == 0);

			_content = [_content, _x] joinString _separator;
		} forEach _paragraphs;

		// création de l'entée
		player createDiaryRecord [
			"Diary", [
				getText (missionConfigFile >> "MissionBriefing" >> "Diaries" >> (_diaries select _i) >> "title"),
				_content
			]
		];
	};
};
