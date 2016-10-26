/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

private ["_buildings", "_color", "_bbr", "_p1", "_p2", "_maxWidth", "_maxLength", "_marker"];

_buildings = nearestObjects [player, ["Building"], 250];

{
	_color = if (isClass (missionConfigFile >> "BuildingsOccupation" >> "Buildings" >> typeOf _x)) then {"ColorGreen"} else {"ColorRed"};

	_bbr = boundingBoxReal _x;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));

	_marker = createMarkerLocal [format ["BuildingsOccupation%1", _forEachIndex], getposASL _x];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerDirLocal (getDir _x);
	_marker setMarkerSizeLocal [_maxWidth * 0.5, _maxLength * 0.5];
	_marker setMarkerColorLocal _color;

} forEach _buildings;
