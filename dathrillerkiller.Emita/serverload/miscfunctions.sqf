
Emita_GetGridRef =
{
	private ["_Pos","_X","_Y","_sY","_sX","_Result"];
	_Pos = _this select 0;
	_X = floor ((getPos _Pos select 0) / 100);
	_Y = floor ((getPos _Pos select 1) / 100);
	_Y = 50 - _Y;
	_sX = str(_X);
	_sY = str(_Y);
	switch (true) do
	{
		case ((_X < 10) && (_Y < 10)):
		{
			_Result = "00"+_sX+"00"+_sY;
		};
		case ((_X < 10) && (_Y > 10)):
		{
			_Result = "00"+_sX+"0"+_sY;
		};
		case ((_Y < 10) && (_X > 10)):
		{
			_Result = "0"+_sX+"00"+_sY;
		};
		default
		{
			_Result = "0"+_sX+"0"+_sY;
		};
	};
	_Result;
};

INV_heal = 

{

if(_this == player)then

	{

	["ALL",[_this,"AinvPknlMstpSlayWrflDnon_medic"],"network_SwitchMove",false,true]call network_MPExec;
	systemChat  format[localize "STRS_inv_items_medikit_benutzung"];	
	sleep 5;
	player setdamage 0; 
	systemChat  format[localize "STRS_inv_items_medikit_fertig"];

	true;

	}else{

	["ALL",[_this,"AinvPknlMstpSlayWrflDnon_medic"],"network_SwitchMove",false,true]call network_MPExec;
	systemChat  "Healing civ...";
	sleep 5;
	_this setdamage 0;
	
	true;

	};

};			

TastenDruck = 
{
	private ["_ctrl", "_zeichennummer", "_ctrlid"];
	_ctrl          = ((_this select 0) select 0);
	_zeichennummer = ((_this select 0) select 1);
	_ctrlid        = (_this select 1);
	if (ISSE_str_const_validInput find _zeichennummer < 0) then
	{
		closedialog 0;
		systemChat  format[localize "STRS_wrong_input", _zeichennummer];
	};
};

ISSE_ArrayNumberNear = 
{
	private ["_c", "_obj", "_arr", "_dis", "_res"];
	_obj = _this select 0;
	_arr = _this select 1;
	_dis = _this select 2;
	_res = 0;
	if (isNull _obj) then 
	{	
		_res = 0;
	}
	else
	{
		for "_c" from 0 to (count _arr - 1) do {
		
			if (not(isNull(_arr select _c))) then
			{
				if ((_obj distance (_arr select _c)) < _dis) then
				{
					_res = _res + 1;
				};
			};
		};
	};
	_res
};

ISSE_CreateMarkerArray =
{	
	private ["_name", "_text", "_color", "_shape", "_pos", "_typ", "_marker", "_size"];
	_pos = [0,0];
	if ((typeName (_this select 0)) == "OBJECT") then
	{
		_pos = [((getPos (_this select 0)) select 0), ((getPos (_this select 0)) select 1)];
	};
	if ((typeName (_this select 0)) == "ARRAY") then
	{
		_pos = [((_this select 0) select 0), ((_this select 0) select 1)];
	};		
	_text  = "";  
	if (count _this > 1) then {_text  = _this select 1};			
	_typ   = "Destroy";      
	if (count _this > 2) then {_typ   = _this select 2};
	_color = "ColorRed";
	if (count _this > 3) then {_color = _this select 3};
	_shape = "ICON";
	if (count _this > 4) then {_shape = _this select 4};
	_size  = [1, 1];
	if (count _this > 5) then {_size  = _this select 5};
	
	if (isNil("GespawnteMarkerCounter")) then {GespawnteMarkerCounter = 0;};
	_name = format["SpawnedMarker_%1", GespawnteMarkerCounter];
	if (count _this > 6) then {_name  = _this select 6};
	_marker = createMarkerLocal [_name, _pos];
	_marker setMarkerShapeLocal _shape;
	_marker setMarkerTypeLocal  _typ;
	_marker setMarkerColorLocal _color;
	_marker setMarkerTextLocal  _text;
	_marker setMarkerSizeLocal  _size;
	GespawnteMarkerCounter = GespawnteMarkerCounter + 1;
	[_name, _marker]
};

ISSE_IsVictim =
{
	private ["_state", "_victimStats"];
	_state  = animationState _this;
	_victimStats = ["amovpercmstpssurwnondnon", "adthppnemstpsraswpstdnon_2", "adthpercmstpslowwrfldnon_4", "amovpercmwlkssurwnondf_forgoten", "civillying01", "civilsitting", "civilsitting01", "civilsitting02", "civilsitting03", "actspercmstpsnonwrfldnon_interrogate02_forgoten"];
	if (_state in _victimStats) then
	{
		true
	}
	else
	{
		false
	};
};


INV_CreateWeapon =
 
{
 
private["_class", "_menge", "_crate"];
_class = _this select 0;
_menge = _this select 1;
_crate = _this select 2;
_crate setDamage 0;
 
_crate setvehicleinit format["
this addweaponCargo [""%1"",%2];
", _class, _menge];
processInitCommands;
 
};

INV_CreateMag =
 
{
 
private["_class", "_menge", "_crate"];
_class = _this select 0;
_menge = _this select 1;
_crate = _this select 2;
 
_crate  setvehicleinit format["
this addmagazineCargo [""%1"",%2];
", _class, _menge];
processInitCommands;
 
};

