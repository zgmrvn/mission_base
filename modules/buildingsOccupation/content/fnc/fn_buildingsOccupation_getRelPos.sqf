/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/


private ["_building", "_pos", "_dir"];
_building = (nearestObjects [player, ["Building"], 50]) select 0;
_pos = _building worldToModel (ASLToAGL (getPosASL player));

_dir = (getDir player) - (getDir _building);

_br = "
";

if (_dir < 0) then {
	_dir = _dir + 360;
};

if (isNil {CRP_buildingsOccupation_positions}) then {
	CRP_buildingsOccupation_positions = "";
};

CRP_buildingsOccupation_positions = CRP_buildingsOccupation_positions + (format ["{{%1,%2,%3},%4},%5", _pos select 0, _pos select 1, _pos select 2, floor _dir, _br]);

copyToClipboard CRP_buildingsOccupation_positions;
