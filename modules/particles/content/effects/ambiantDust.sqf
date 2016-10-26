/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

_position	= _this select 0;
_duration	= _this select 1;


_winDir = vectorNormalized wind;
_coefWind = 4;

_position = [_position, 15 * (vectorMagnitude wind), windDir + 180] call BIS_fnc_relPos;

_source = "#particlesource" createVehicleLocal _position;

_source setParticleCircle [
	/*radius*/ 5,
	/*velocity*/ [1, 1, 0]
];

_source setParticleParams [
	/*particleShape*/ ["\A3\data_f\ParticleEffects\Universal\Universal",
	/*particleFSNtieth*/ 16,
	/*particleFSIndex*/ 12,
	/*particleFSFrameCount*/ 13,
	/*particleFSLoop*/ 0],
	/*animationName*/ "",
	/*particleType*/ "Billboard",
	/*timerPeriod*/ 1,
	/*lifeTime*/ 30,
	/*position*/ [0,0,0],
	/*moveVelocity*/ [(_winDir select 0) * _coefWind, (_winDir select 1) * _coefWind, 0],
	/*rotationVelocity*/ 0,
	/*weight*/ 10,
	/*volume*/ 7.84,
	/*rubbing*/ 0.0001,
	/*size*/ [5,15,10,15,20],
	/*color */ [[.6,.5,.4,0.0],[.6,.5,.4,.04],[.6,.5,.4,.02],[.6,.5,.4,.03],[.6,.5,.4,.02],[.6,.5,.4,.01],[.6,.5,.4,.01],[.6,.5,.4,.01]],
	/*animationSpeed*/ [1000],
	/*randomDirectionPeriod*/ 0,
	/*randomDirectionIntensity*/ 0,
	/*onTimerScript*/ "",
	/*beforeDestroyScript*/ "",
	/* object */ nil
];

_source setParticleRandom [
	/*lifeTime*/ 0,
	/*position*/ [1,1,-0.8],
	/*moveVelocity*/ [0,0,0],
	/*rotationVelocity*/ 3,
	/*size*/ 0.215,
	/*color*/ [0.02, 0, 0.02, 0.106],
	/*randomDirectionPeriod*/ 0,
	/*randomDirectionIntensity*/ 0
];

_source setDropInterval 1;

sleep _duration;

deleteVehicle _source;
