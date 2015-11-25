showCinemaBorder true;

sleep 0.5;
playMusic "intro";
_camera = "camera" camCreate [19369.90,22742.01,9.10];
_camera cameraEffect ["internal","BACK"];

_camera camPrepareTarget [-28541.43,-60511.41,-27366.24];
_camera camPreparePos [19549.16,22798.73,21.86];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 1;
waitUntil {camCommitted _camera};

0 cutText ["", "BLACK OUT",0];
sleep 1;
0 cutText ["", "BLACK IN",1];

player cameraEffect ["terminate","back"];
camDestroy _camera;