/*
	framework de mission du CORP
	http://www.corp-arma.fr
*/

removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

_this forceAddUniform "U_B_CTRG_Soldier_2_F";
_this addItemToUniform "30Rnd_556x45_Stanag_green";
_this addItemToUniform "16Rnd_9x21_Mag";
_this addVest "V_TacVest_oli";
_this addHeadgear "H_Helmet_Skate";

_this addWeapon "arifle_SPAR_01_blk_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Aco";
_this addWeapon "hgun_P07_khk_F";
_this addHandgunItem "muzzle_snds_L";
