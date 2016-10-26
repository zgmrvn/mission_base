/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

_boat		= vehicle (_this select 0);
_coast		= _this select 1;
_distance	= _this select 2;

_initVel = velocity _boat;
_initMag = vectorMagnitude _initVel;

// tant que le bateau va a plus de 5 Km
// on réduit progressivement sa vélocité
while {speed _boat > 5} do {
	_actualVel = (vectorNormalized velocity _boat) vectorMultiply _initMag;
	_vel = _actualVel vectorMultiply ((_boat distance _coast) / _distance);
	_boat setVelocity _vel;

	sleep 0.33;
};
