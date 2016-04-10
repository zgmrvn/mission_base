private _array = _this;
private _shuffled = [];
private _count = (count _array) - 1;

for "_i" from 0 to _count do {
	_item = floor (random _count);
	_shuffled pushBack (_array select _item);
	_array deleteAt _item;
	_count = _count - 1;
};

_shuffled