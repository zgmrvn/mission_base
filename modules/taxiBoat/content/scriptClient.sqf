/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

_boat	= _this select 0;
_place	= _this select 1;

cutText ["", "BLACK OUT", 2];
2 fadeSound 0;
sleep 2;


player moveInCargo [_boat, _place];

sleep 3;
cutText ["", "BLACK IN", 3];
3 fadeSound 1;
