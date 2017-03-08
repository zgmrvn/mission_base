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
private _spawnDistance	= getNumber (missionConfigFile >> "Hunters" >> "Hunters" >> _this >> "spawnDistance");
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
	private _count = 0;

	for [{private _i = (count ([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs)) - 1}, {_i >= 0}, {_i = _i - 1}] do {
		private _alive = {alive _x} count units (([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) select _i);

		// si tous les membres du groupe morts, on retire le groupe du tableau
		if (_alive == 0) then {
			([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) deleteAt _i;
		};

		_count = _count + _alive;
	};

	// on actualise la position de la chasse pour les futures groupes créés
	if (count ([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) > 0) then {
		private _units = units (([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) select 0);

		{
			if (alive _x) exitWith {
				_lastPos = ASLToATL getPosASL _x;
			}
		} forEach _units;
	};

	// si moins de 2 unités dans la chasse on créé un nouveau groupe
	if (_count <= 2) then {
		// selection d'un des types de groupes autorisés
		private _group = selectRandom _hunterGroups;

		// on détermine si la donnée est une config de groupe ou un tableau de classenames d'unités
		private _customGroup = !((_group select 0) in ["West", "East", "Indep"]);

		// si on est dans le cas d'une config de groupe et pas un groupe custom
		// concaténation des différentes parties qui composent le chemin de la config
		// sinon, le tableau _group sera directement passé à la fonction de création du groupe
		if (!_customGroup) then {
			private _path = configFile >> "CfgGroups";
			{
				_path = _path >> _x;
			} forEach _group;

			_group = _path;
		};

		// dans le cas d'un groupe custom, mélange du tableau des classnames
		if (_customGroup) then {
			_group = _group call CRP_fnc_realShuffle;
		};

		// récupération des joueurs sur zone
		_players = [_lastPos, 1000, [west, east, independent]] call CRP_fnc_nearestPlayers;

		// calcul du barycentre des joueurs récupérés
		private _barycenter = [0, 0, 0];

		{
			_barycenter = _barycenter vectorAdd (getPosASL _x);
		} forEach _players;

		_barycenter = _barycenter vectorMultiply (1 / (count _players));

		// préparation de la position de spawn du futur groupe
		// todo : si à l'issue du processus de recherche qui suit, aucune position valide n'a été trouvé pour _futurPos
		// todo : la position de l'itération précédente sera utilisé (_lastPos) et il se peut qu'entre temps, des joueurs aient atteint cette position
		// todo : même si ce cas est peu probable, prévoir une alternative ou tout simplement augmenter le nombre max d'itérations de la boucle while qui suit
		private _futurPos = _lastPos; // par défaut, la future position vaut l'ancienne

		// on recherche une position qui remplit le critère de distance de spawn minimum par rapport aux joueurs
		// pour trouver cette position, on autorise 16 itérations aucours desquelles
		// on incrémente la distance de recherche toutes les 3 itérations si aucune position n'a été trouvée
		// la boucle est quitté prématurément quand une position est trouvée
		private _i = 1;
		private _m = 1.5;

		while {_i <= 16} do {
			// on cherche une position éloignée du barycentre _m* la distance de spawn souhaitée
			private _tempPos = [_barycenter, _spawnDistance * _m, random 360] call BIS_fnc_relPos;
			_players = [_tempPos, _spawnDistance, [west, east, independent]] call CRP_fnc_nearestPlayers;

			// si dans un rayon de 1* la distance de spawn shouaitée, aucun joueur n'a été trouvé
			// on quitte la boucle et on définit la position de spawn du prochain groupe de chasse
			if (count _players == 0) exitWith {
				_futurPos = _tempPos;
			};

			// sinon, toutes les 3 itération infrutueuses, on ajoute 0.5* la distance de spawn à la distance de recherche
			if ((_i mod 3) == 0) then {
				_m = _m + 0.5;
			};

			_i = _i + 1;
		};

		// création du groupe
		private _hunters = [
			_futurPos,
			_side,
			_group
		] call BIS_fnc_spawnGroup;

		deleteWaypoint [_hunters, 0];

		// on ajoute le nouveau groupe au tableau global
		([CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs) pushBack _hunters;

		_hunters setSpeedMode "FULL";
		_hunters setCombatMode "RED";
		_hunters setBehaviour "AWARE";

		// ajout d'un point de passage sur les joueurs
		// sans ça, l'ia ne bouge pas si elle spawn trop loins des joueurs
		private _wp = _hunters addWaypoint [_barycenter, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointCompletionRadius 20;

		// en plus, on révèle les joueurs au groupe
		{
			_hunters reveal _x;
		} forEach allPlayers;
	};

	// à chaque itération on re-révèle les joueurs aux chasseurs
	private _hunters = [CRP_var_hunters_hunters, _this] call BIS_fnc_getFromPairs;

	{
		private _player = _x;

		{
			_x reveal _player;
		} forEach _hunters;
	} forEach allPlayers;

	// pause entre chaque vérification de l'état des groupes
	sleep _pause;
};
