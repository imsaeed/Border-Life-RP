_Loaction = _this select 0;
waitUntil {createDialog "liste_1_button"};
{
	_Array = _x + [_Loaction];
	_Scriptname = (_x select 0);
	_trunk = (_x select 1);
	_upgrades = (_x select 2);
	_name = _Scriptname call inv_getitemname;
	_index = lbAdd [1, format["Name: %1 Trunk: %2 SpeedUpgrade: %3", _name, _trunk,_upgrades]];															
	lbSetData [1, _index,format ['%1',_Array]];	
}count INVVehiclesLand;

ctrlSetText [221, "Retrive Vehicle"];

buttonSetAction [221,"
_Array = call compile (lbData [1, (lbCurSel 1)]); 
_Scriptname = _Array select 0;
_trunk = _Array select 1;
_upgrades = _Array select 2;
_upgrades = if (_upgrades == 0)then{nil}else{_upgrades};
_weaps = _Array select 3;
_mags = _Array select 4;
_plate = _Array select 5;
_warrants = _Array select 6;
_Licences = _Array select 7;
_notes = _Array select 8;
_sirens = _Array select 9;
_Loaction = _Array select 10;

[_Scriptname,_Loaction,player,ar_side,_plate]call shops_createVehicle;
	[_trunk,_upgrades,_weaps,_mags,_warrants,_Licences,_notes,_sirens]spawn
	{
		_weaps = _this select 2;
		_mags = _this select 3;
		INVVehiclesLand set [(lbCurSel 1),-1];
		INVVehiclesLand = INVVehiclesLand - [-1];
		sleep 0.1;
		newvehicle setvariable ['tuning', (_this select 1), true]; 
		newvehicle setvariable ['dtk_storage',(_this select 0), true]; 
		newvehicle setVariable ['cdb_warrants',(_this select 4),true];
		newvehicle setVariable ['cdb_license',(_this select 5),true];
		newvehicle setVariable ['cdb_notes',(_this select 6),true];
		clearWeaponCargo newvehicle;
		clearMagazineCargo newvehicle;
		removeallweapons newvehicle;
		
		{
			newvehicle addWeaponCargo [_x, (_weaps select 1 select _forEachIndex)];
		}forEach (_weaps select 0);
		{
			newvehicle addMagazineCargo [_x, (_mags select 1 select _forEachIndex)];
		}forEach (_mags select 0);
		
		{
					newvehicle removeWeapon _x;
		}forEach (weapons newvehicle);
		
		{
			newvehicle addWeapon _x;
		}forEach (_this select 7);
		
		closeDialog 0;
	};
"];   
