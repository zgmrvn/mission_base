_position	= _this select 0;
_duration	= _this select 1;

_winDir = vectorNormalized wind;
_coefWind = 5;

_source = "#particlesource" createVehicleLocal _position;

_source setParticleCircle [
	/*radius*/ 5,
	/*velocity*/ [1, 1, -0.1]
];

_source setParticleParams [
	/*particleShape*/ ["\A3\data_f\ParticleEffects\Universal\Universal",
	/*particleFSNtieth*/ 16,
	/*particleFSIndex*/ 12,
	/*particleFSFrameCount*/ 16,
	/*particleFSLoop*/ 0],
	/*animationName*/ "",
	/*particleType*/ "Billboard",
	/*timerPeriod*/ 1,
	/*lifeTime*/ 14,
	/*position*/ [0,0,0],
	/*moveVelocity*/ [(_winDir select 0) * _coefWind, (_winDir select 1) * _coefWind, 0.01],
	/*rotationVelocity*/ 1,
	/*weight*/ 2.5,
	/*volume*/ 0.9,
	/*rubbing*/ 0.4,
	/*size*/ [2,3,4,3,2],
	/*color*/ [[0.56,0.45,0.25,0.01],[0.56,0.48,0.25,0.007],[0.56,0.47,0.22,0.005],[0.56,0.47,0.25,0.001]],
	/*animationSpeed*/ [1000],
	/*randomDirectionPeriod*/ 0.1,
	/*randomDirectionIntensity*/ 0.8,
	/*onTimerScript*/ "",
	/*beforeDestroyScript*/ "",
	/* object */ nil
];

_source setParticleRandom [
	/*lifeTime*/ 3,
	/*position*/ [4,4,-0.2],
	/*moveVelocity*/ [0.5,0.5,0],
	/*rotationVelocity*/ 3,
	/*size*/ 0.5,
	/*color*/ [0.1, 0.01, 0, 0.02],
	/*randomDirectionPeriod*/ 0,
	/*randomDirectionIntensity*/ 0
];

_source setDropInterval 0.01;

sleep _duration;

deleteVehicle _source;