_caller	= _this select 0;
_object	= _this select 1;

if (X_server) then {
	systemChat "server";
};

if (X_client) then {
	systemChat "client";
};