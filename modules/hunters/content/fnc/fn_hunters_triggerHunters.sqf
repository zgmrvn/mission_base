/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

if !(_this isEqualType "") exitWith {"Chaîne attendue" call BIS_fnc_error; scriptNull};
if !(isClass (missionConfigFile >> "Hunters" >> "Hunters" >> _this)) exitWith {hint format ["Le groupe de chasse ""%1"" n'éxiste pas, vérifiez votre config", _this]; scriptNull};

private _lastPos		= getArray (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "start");
private _side			= getText (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "hunterSide");
private _condition		= getText (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "condition");
private _hunterGroups	= getArray (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "hunterGroups");
private _pause			= getNumber (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "pause");

// si la variable qui contient les groupes de chasse n'éxiste pas, on la crée
if (isNil {CRP_var_hunters_hunters}) then {
	CRP_var_hunters_hunters = [];
};

// dans le cas ou ce groupe de chasse a déjà été déclenché, on quitte la fonction
if !(isNil {[CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs}) exitWith {};

// sinon on crée une entrée dans le tableau
[CRP_var_hunters_hunters, _this, []] call BIS_fnc_setToPairs;

// on détermine le side
_side = toUpper _side;
_side = switch (_side) do {
	case "WEST": {west};
	case "INDEP": {independent};
	default {east};
};

// boucle de vérification de l'état du groupe
while {call compile _condition} do {
	// mise à jour du tableau des groupes qui composent une chasse
	// on supprime les groupes dont tous les membres sont morts
	// et on compte également le nombre d'IA vivantes dans la chasse
	_count = 0;

	for [{private _i = (count ([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs)) - 1}, {_i >= 0}, {_i = _i - 1}] do {
		_alive = {alive _x} count units (([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) select _i);

		// si tous les membres du groupe morts, on retire le groupe du tableau
		if (_alive == 0) then {
			([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) deleteAt _i;
		};

		_count = _count + _alive;
	};

	// on actualise la position de la chasse pour les futures groupes créés
	if (count ([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) > 0) then {
		//_lastPos = (units (([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) select 0)) call BIS_fnc_selectRandom;
		_units = units (([CRP_var_hunters_hunters, "Group1"] call BIS_fnc_getFromPairs) select 0);

		{
			if (alive _x) exitWith {
				_lastPos = ASLToATL getPosASL _x;
			}
		} forEach _units;

		systemChat str _lastPos;
	};

	// si moins de 2 unités dans la chasse on créé un nouveau groupe
	if (_count <= 2) then {
		// selection d'un des types de groupes autorisés
		_group = _hunterGroups call BIS_fnc_selectRandom;

		// on détermine si la donnée est une config de groupe ou un tableau de classenames d'unités
		_customGroup = !((_group select 0) in ["West", "East", "Indep"]);

		// si on est dans le cas d'une config de groupe et pas un groupe custom
		// concaténation des différentes parties qui composent le chemin de la config
		// sinon, le tableau _group sera directement passé à la fonction de création du groupe
		if (!_customGroup) then {
			_path = configFile >> "CfgGroups";
			{
				_path = _path >> _x;
			} forEach _group;

			_group = _path;
		};

		// dans le cas d'un groupe custom, mélange du tableau des classnames
		if (_customGroup) then {
			_group = _group call CRP_fnc_realShuffle;
		};

		// création du groupe
		_hunters = [
			_lastPos findEmptyPosition [150, 300],
			_side,
			_group
		] call BIS_fnc_spawnGroup;

		deleteWaypoint [_hunters, 0];

		// on ajoute le nouveau groupe au tableau global
		([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) pushBack _hunters;

		// on révèle les joueurs au groupe
		{
			_hunters reveal _x;
		} forEach allPlayers;
	};

	// pause entre chaque vérification de l'état des groupes
	sleep _pause;
};
