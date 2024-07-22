targetMod = "";			//name of mod you want uniforms from. Leave blank to get all uniforms in arma and any loaded mods.
								//possible mod names for use are but not limited to "Exile" = Exile Mod, "CUP" = CUP Mods,
								//"rhs" = all the RHS mods. 

AllUniforms = false;			//In arma different factions are not able to wear other faction uniforms. So independent cannot wear opfor
								//uniforms. If you run a mod that makes these uniforms universal than you can set this to true and get all
								//factions uniforms. If not than setting this to false only gives uniforms that can be worn by exile players.

faceWareStartPrice = 50;		//Price you want your facewear to start at regardless of the calculations put into the code.
helmetStartPrice = 75;			//Price you want your helmets to start at regardless of the calculations put into the code.
uniformStartPrice = 100;		//Price you want your uniforms to start at regardless of the calculations put into the code.
vestStartPrice	= 200;			//Price you want your vests to start at regardless of the calculations put into the code.
backPackStartPrice	= 300;		//Price you want your backpacks to start at regardless of the calculations put into the code.

equipmentPriceAjuster = 2;		//this is a multiplier that goes into the calculations of different stats to get final price.
								//change to what ever you want and run it to see the difference in results.
		
manualMode = false;		//Set to true if have a list of class names and want to price only certain uniforms.

//List your class names here if you set the above manualMode to true.
manualModeList =	[
						"Exile_Glasses_Diving_AAF",
						"Exile_Glasses_Diving_CSAT",
						"Exile_Glasses_Diving_NATO",
						"Exile_Cap_Exile",
						"Exile_Headgear_SafetyHelmet",
						"Exile_Headgear_SantaHat",
						"Exile_Uniform_BambiOverall",
						"Exile_Uniform_ExileCustoms",
						"Exile_Uniform_Wetsuit_NATO",
						"Exile_Uniform_Wetsuit_CSAT",
						"Exile_Uniform_Wetsuit_AAF",
						"Exile_Uniform_Woodland",
						"Exile_Vest_Rebreather_NATO",
						"Exile_Vest_Rebreather_AAF",
						"Exile_Vest_Rebreather_CSAT",
						"Exile_Vest_Snow"
					];