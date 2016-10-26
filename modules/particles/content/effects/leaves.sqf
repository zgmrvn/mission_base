/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

_position	= _this select 0;
_duration	= _this select 1;

_position set [2, 6];

_winDir = vectorNormalized wind;
_coefWind = 1.5;

_source = "#particlesource" createVehicleLocal _position;

_source setParticleCircle [
	/*radius*/ 10,
	/*velocity*/ [0, 0, 0.4]
];

_source setParticleParams [
	/*particleShape*/ ["\A3\Plants_F\_Leafs\leaf_damage_small_green.p3d",
	/*particleFSNtieth*/ 1,
	/*particleFSIndex*/ 0,
	/*particleFSFrameCount*/ 1,
	/*particleFSLoop*/ 0],
	/*animationName*/ "",
	/*particleType*/ "SpaceObject",
	/*timerPeriod*/ 1,
	/*lifeTime*/ 10,
	/*position*/ [0,0,0],
	/*moveVelocity*/ [(_winDir select 0) * _coefWind, (_winDir select 1) * _coefWind, 0.01],
	/*rotationVelocity*/ 1,
	/*weight*/ 1.42,
	/*volume*/ 1,
	/*rubbing*/ 1,
	/*size*/ [1],
	/*color*/[[1,1,1,1]],
	/*animationSpeed*/[1],
	/*randomDirectionPeriod*/ 1,
	/*randomDirectionIntensity*/ 0,
	/*onTimerScript*/ "",
	/*beforeDestroyScript*/ "",
	/* object */ nil
];

_source setParticleRandom [
	/*lifeTime*/ 1,
	/*position*/ [2,2,0.5],
	/*moveVelocity*/ [0.2,0.2,1],
	/*rotationVelocity*/ 2,
	/*size*/ 0,
	/*color*/ [0.05,0.05,0.05,0],
	/*randomDirectionPeriod*/ 0,
	/*randomDirectionIntensity*/ 0
];

_source setDropInterval 0.3;

sleep _duration;

deleteVehicle _source;
