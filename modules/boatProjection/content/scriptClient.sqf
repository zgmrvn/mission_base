_boat	= _this select 0;
_mod	= _this select 1;

cutText ["", "BLACK OUT", 2];
2 fadeSound 0;
sleep 2;

switch (_mod) do {
	case 0: { player moveInDriver _boat; };
	default { player moveInCargo [_boat, _mod]; };
};

sleep 0.5;
cutText ["", "BLACK IN", 2];
2 fadeSound 1;