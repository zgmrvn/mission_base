/*
	framework de mission du CORP
	http://www.corp-arma.fr

	NOM :			realShuffle
	AUTEUR :		zgmrvn
	DESCRIPTION :	effectue un shuffle sur le tableau, la fonction de BIS a tendance à retourner la même suite

	EXAMPLE :
		[0, 1, 2, 4, 5] call CRP_fnc_realShuffle; // [5, 2, 1, 4, 3]
*/

private _shuffled = [];
private _count = count _this;

for "_i" from 0 to _count do {
	_item = floor (random _count);
	_shuffled pushBack (_this select _item);
	_count = _count - 1;
};

_shuffled
