#include "config.sqf";

_classNameArray = [];

if(manualMode == false)then
{
	if(targetMod == "")then
	{
		_uniformVestNameArray = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
		_backpackNameArray = (configFile >> "cfgVehicles") call BIS_fnc_getCfgSubClasses;
		_glassesNameArray = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
		
		_classNameArray = _uniformVestNameArray + _backpackNameArray + _glassesNameArray;
	}
	else
	{
		_uniformVestNameArray = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
		_backpackNameArray = (configFile >> "cfgVehicles") call BIS_fnc_getCfgSubClasses;
		_glassesNameArray = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
		
		_uniformArray = _uniformVestNameArray + _backpackNameArray + _glassesNameArray;
		{
			if([targetMod, _x] call BIS_fnc_inString)then
			{
				_classNameArray pushback _x;
			};
		}forEach _uniformArray;
	};
}
else
{
	_uniformVestNameArray = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
	_backpackNameArray = (configFile >> "cfgVehicles") call BIS_fnc_getCfgSubClasses;
	_glassesNameArray = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;

	_uniformArray = _uniformVestNameArray + _backpackNameArray + _glassesNameArray;
	{
		if(_x in _uniformArray)then
		{
			_classNameArray pushBack _x;
		};
	}forEach manualModeList;
};


//_uniformVestNameArray = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_backpackNameArray = (configFile >> "cfgVehicles") call BIS_fnc_getCfgSubClasses;
//_glassesNameArray = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
//
//_classNameArray = _uniformVestNameArray + _backpackNameArray + _glassesNameArray;

_arrayCount = count _ClassNameArray;
_arrayCount = _arrayCount - 1;
_counter = 0;
_characterNumbersArray = [];
_br = toString [13,10];
_respectModifier = 1;
_PriceAdjVar = 0;

_faceWareArray = [];
_faceWareFormat = "";
_helmetArray = [];
_helmetFormat = "";
_uniformArray = [];
_uniformFormat = "";
_vestArray = [];
_vestFormat = "";
_backpackArray = [];
_backpackFormat = "";

_faceWareClasses = [];
_faceWareClFmt = "";
_helmetClasses = [];
_helmetClFmt = "";
_uniformClasses = [];
_uniformClFmt = "";
_vestClasses = [];
_vestClFmt = "";
_backpackClasses = [];
_backpackClFmt = "";

if (EquipmentPriceAjuster <= 0 || EquipmentPriceAjuster == nil) then
{
	EquipmentPriceAjuster = 1;
};

	{
		_strClass = _x;
		_characterNumbers = count str _strClass;
		_characterNumbersArray pushBack _characterNumbers;
	}forEach _classNameArray;
	
	_maxCharacters = selectMax _characterNumbersArray;

for "_i" from 0 to _arrayCount do 
{
	_ClassName = _ClassNameArray select _counter;
	
	if !((["None", _ClassName] call BIS_fnc_inString) || (["base", _ClassName] call BIS_fnc_inString))then
	{
		_itemCheck = [_ClassName] call BIS_fnc_itemType;
		
		if (_itemCheck select 0 == "") then
		{
			_itemCheck = [_ClassName] call BIS_fnc_ObjectType;
		};
				
		_itemClass = _itemCheck select 0;
		_itemType = _itemCheck select 1;
		_description = format ["%1 || Class Name: %2",_itemType,_ClassName];
		_loadName = getText(configFile >> "CfgWeapons" >> _ClassName >> "ItemInfo" >> "containerClass");
		_armor = 0;
		_maximumLoad = 0;
		_mass = 0;
		
		switch (_itemClass) do
		{	
			case "Equipment": 
			{	
				switch (_itemType) do
				{		
					case "Glasses":
					{
						_mass = getNumber(configFile >> "CfgGlasses" >> _className >> "mass");
											
						_respectModifier = ((_mass * (100 / 7)) / 100) * 5;
						_ItemRespect = round (floor _respectModifier)min 6;
						If(_ItemRespect == 0)then
						{
							_ItemRespect = 1;
						};
						
						_ItemPrice =  round(floor(_mass) * equipmentPriceAjuster) + faceWareStartPrice;
	
						_classListformat = format ['"%1",', _ClassName];
						_faceWareClasses pushBack _classListformat;

						_ClassNameCharacters = count _ClassName;
						_addedSpaces = " ";				
						_Spacing = "";
						_spacingAmount = _maxCharacters - _ClassNameCharacters + 20;
						_spaceCounter = 0;
						
							for "_i" from 0 to _spacingAmount do
							{
								_spaceCounter = _spaceCounter + 1;
								_Spacing = _Spacing + _addedSpaces;
							};	
							
						_ClassName =  _ClassName splitstring "";
						_Spacing = _Spacing splitstring "";	
						_ClassName = _ClassName + _Spacing;
						_ClassName = _ClassName joinstring "";										

						_ItemListArray = format ['class %1{quality = %2; price = %3;};',_ClassName,_ItemRespect,_ItemPrice];	
						_faceWareArray pushBack _ItemListArray;
						systemChat format ["ADDED: %1",_ClassName];
					};
				
					case "Headgear":
					{
						"_armor = _armor + getNumber (_x >> 'armor')" configClasses (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "HitpointsProtectionInfo");
						
						_respectModifier = ((_armor * (100 / 15)) / 100) * 5;
						_ItemRespect = round (floor _respectModifier)min 6;		
						If(_ItemRespect == 0)then
						{
							_ItemRespect = 1;
						};

						_ItemPrice =  round(floor(_armor) * equipmentPriceAjuster) + helmetStartPrice;
						
						_classListformat = format ['"%1",', _ClassName];						
						_helmetClasses pushBack _classListformat;

						_ClassNameCharacters = count _ClassName;
						_addedSpaces = " ";				
						_Spacing = "";
						_spacingAmount = _maxCharacters - _ClassNameCharacters + 20;
						_spaceCounter = 0;
						
							for "_i" from 0 to _spacingAmount do
							{
								_spaceCounter = _spaceCounter + 1;
								_Spacing = _Spacing + _addedSpaces;
							};	
							
						_ClassName =  _ClassName splitstring "";
						_Spacing = _Spacing splitstring "";	
						_ClassName = _ClassName + _Spacing;
						_ClassName = _ClassName joinstring "";										

						_ItemListArray = format ['class %1{quality = %2; price = %3;};',_ClassName,_ItemRespect,_ItemPrice];
						_helmetArray pushBack _ItemListArray;
						systemChat format ["ADDED: %1",_ClassName];
					};
					
					case "Uniform":
					{	
						if!((["BasicBody", _ClassName] call BIS_fnc_inString) || (["Soldier_VR", _ClassName] call BIS_fnc_inString) || (["VirtualMan", _ClassName] call BIS_fnc_inString))then
						{
							_maximumLoad = getNumber(configFile >> "CfgVehicles" >> _loadName >> "maximumLoad");
							
							crito forceAddUniform _ClassName;
							_itemInUniform = uniformItems crito;
	
							if(count _itemInUniform <= 0)then
							{
								_respectModifier = ((_maximumLoad * (500 / 375)) / 100) * 5;
								_ItemRespect = round (floor _respectModifier)min 6;		
								If(_ItemRespect == 0)then
								{
									_ItemRespect = 1;
								};
		
								_ItemPrice =  round(floor(_maximumLoad) * equipmentPriceAjuster) + uniformStartPrice;
		
								if(AllUniforms)then
								{
									_classListformat = format ['"%1",', _ClassName];
									_uniformClasses pushBack _classListformat;
								}
								else
								{
									if!((["_B_", _ClassName] call BIS_fnc_inString) || (["_O_", _ClassName] call BIS_fnc_inString) || (["_BG_", _ClassName] call BIS_fnc_inString) || (["_OG_", _ClassName] call BIS_fnc_inString))then
									{
										_classListformat = format ['"%1",', _ClassName];
										_uniformClasses pushBack _classListformat;
									};
								};

								_ClassNameCharacters = count _ClassName;
								_addedSpaces = " ";				
								_Spacing = "";
								_spacingAmount = _maxCharacters - _ClassNameCharacters + 20;
								_spaceCounter = 0;
								
									for "_i" from 0 to _spacingAmount do
									{
										_spaceCounter = _spaceCounter + 1;
										_Spacing = _Spacing + _addedSpaces;
									};	
									
								_ClassName =  _ClassName splitstring "";
								_Spacing = _Spacing splitstring "";	
								_ClassName = _ClassName + _Spacing;
								_ClassName = _ClassName joinstring "";										
		
								_ItemListArray = format ['class %1{quality = %2; price = %3;};',_ClassName,_ItemRespect,_ItemPrice];
								
								if(AllUniforms)then
								{
									_uniformArray pushBack _ItemListArray;
									systemChat format ["ADDED: %1",_ClassName];
								}
								else
								{
									if!((["_B_", _ClassName] call BIS_fnc_inString) || (["_O_", _ClassName] call BIS_fnc_inString) || (["_BG_", _ClassName] call BIS_fnc_inString) || (["_OG_", _ClassName] call BIS_fnc_inString))then
									{
										_uniformArray pushBack _ItemListArray;
										systemChat format ["ADDED: %1",_ClassName];
									};
								};
							};
						};
					};
					
					case "Vest":
					{
						"_armor = _armor + getNumber (_x >> 'armor')" configClasses (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "HitpointsProtectionInfo");
						_maximumLoad = getNumber(configFile >> "CfgVehicles" >> _loadName >> "maximumLoad");

						crito addVest _ClassName;
						_itemInVest = vestItems crito;

						if(count _itemInVest <= 0)then
						{

							_respectModifier = ((_maximumLoad * (160 / 120)) / 100) * 5;
							_ItemRespect = round (floor _respectModifier)min 6;		
							If(_ItemRespect == 0)then
							{
								_ItemRespect = 1;
							};
		
							_ItemPrice =  round(floor(_maximumLoad + _armor) * equipmentPriceAjuster) + vestStartPrice;
		
							_classListformat = format ['"%1",', _ClassName];
							_vestClasses pushBack _classListformat;

							_ClassNameCharacters = count _ClassName;
							_addedSpaces = " ";				
							_Spacing = "";
							_spacingAmount = _maxCharacters - _ClassNameCharacters + 20;
							_spaceCounter = 0;
							
								for "_i" from 0 to _spacingAmount do
								{
									_spaceCounter = _spaceCounter + 1;
									_Spacing = _Spacing + _addedSpaces;
								};	
								
							_ClassName =  _ClassName splitstring "";
							_Spacing = _Spacing splitstring "";	
							_ClassName = _ClassName + _Spacing;
							_ClassName = _ClassName joinstring "";										
		
							_ItemListArray = format ['class %1{quality = %2; price = %3;};',_ClassName,_ItemRespect,_ItemPrice];
							
							_vestArray pushBack _ItemListArray;
							systemChat format ["ADDED: %1",_ClassName];
						};
					};
					
					case "Backpack":
					{
						_mass = getNumber(configFile >> "CfgVehicles" >> _className >> "mass");
						_maximumLoad = getNumber(configFile >> "CfgVehicles" >> _className >> "maximumLoad");
												
						if(_maximumLoad > 0)then
						{
							crito addBackpack _ClassName;
							_itemInBag = backpackItems crito;

							if(count _itemInBag <= 0)then
							{
								_respectModifier = ((_maximumLoad * (360 / 1000)) / 100) * 5;
								_ItemRespect = round (floor _respectModifier)min 6;		
								If(_ItemRespect == 0)then
								{
									_ItemRespect = 1;
								};
			
								_ItemPrice =  round(floor(_maximumLoad - _mass) * equipmentPriceAjuster) + backPackStartPrice;
								if(_ItemPrice <= 0)then
								{
									_ItemPrice =  round(floor(_maximumLoad) * equipmentPriceAjuster) + backPackStartPrice;
								};
								
								_classListformat = format ['"%1",', _ClassName];
								_backpackClasses pushBack _classListformat;

								_ClassNameCharacters = count _ClassName;
								_addedSpaces = " ";				
								_Spacing = "";
								_spacingAmount = _maxCharacters - _ClassNameCharacters + 20;
								_spaceCounter = 0;
								
									for "_i" from 0 to _spacingAmount do
									{
										_spaceCounter = _spaceCounter + 1;
										_Spacing = _Spacing + _addedSpaces;
									};	
									
								_ClassName =  _ClassName splitstring "";
								_Spacing = _Spacing splitstring "";	
								_ClassName = _ClassName + _Spacing;
								_ClassName = _ClassName joinstring "";										
			
								_ItemListArray = format ['class %1{quality = %2; price = %3;};',_ClassName,_ItemRespect,_ItemPrice];
								
								_backpackArray pushBack _ItemListArray;
								systemChat format ["ADDED: %1",_ClassName];
							};
						};
					};	
				};	
			};	
		};
	};
	_counter = _counter + 1;
};

	{
		_faceWareFormat = _faceWareFormat + format['%1%2',_x, endl];
	}forEach _faceWareArray;

	{
		_helmetFormat = _helmetFormat + format['%1%2',_x, endl];
	}forEach _helmetArray;

	{
		_uniformFormat = _uniformFormat + format['%1%2',_x, endl];
	}forEach _uniformArray;

	{
		_vestFormat = _vestFormat + format['%1%2',_x, endl];
	}forEach _vestArray;
	
	{
		_backpackFormat = _backpackFormat + format['%1%2',_x, endl];
	}forEach _backpackArray;

	{
		_faceWareClFmt = _faceWareClFmt + format['%1%2',_x, endl];
	}forEach _faceWareClasses;

	{
		_helmetClFmt = _helmetClFmt + format['%1%2',_x, endl];
	}forEach _helmetClasses;

	{
		_uniformClFmt = _uniformClFmt + format['%1%2',_x, endl];
	}forEach _uniformClasses;

	{
		_vestClFmt = _vestClFmt + format['%1%2',_x, endl];
	}forEach _vestClasses;
	
	{
		_backpackClFmt = _backpackClFmt + format['%1%2',_x, endl];
	}forEach _backpackClasses;

	_finalPriceInfo = composeText ["/////PRICING/////",_br,_br,"//FACEWARE:",_br,_faceWareFormat,_br,_br,"//HEADGEAR:",_br,_helmetFormat,_br,_br,
	"//UNIFORMS:",_br,_uniformFormat,_br,_br,"//VESTS:",_br,_vestFormat,_br,_br,"//BACKPACKS:",_br,_backpackFormat,_br,_br,_br,
	"/////CLASS NAMES/////",_br,_br,"//FACEWARE:",_br,_faceWareClFmt,_br,_br,"//HEADGEAR:",_br,_helmetClFmt,_br,_br,
	"//UNIFORMS:",_br,_uniformClFmt,_br,_br,"//VESTS:",_br,_vestClFmt,_br,_br,"//BACKPACKS:",_br,_backpackClFmt];
	copyToClipboard str _finalPriceInfo;

systemChat str "AUTO PRICING POVIDED BY CRITO";
systemChat str "COMPLETE AND COPIED TO CLIPBOARD READY TO PASTE";





