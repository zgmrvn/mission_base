private _array = _this;
private _shuffled = [];
private _count = (count _array) - 1;

for "_i" from 0 to _count do {
	_shuffled pushBack (_array select (floor (random _count)));
	_array deleteAt _count;
	_count = _count - 1;
};

_shuffled