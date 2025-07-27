/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Credits

// "TLW" left in honor of the OG mod, and our inspiration
// Abyss, JM and wonderful ideas for being absolute bros and getting me into modding 
// Chopeks, Pot, Excalibird and all the other devs and guests
// All of the lovely playtesters, and the contributors to PoV!
// Legends and the broader modding community for all their tools, documentation and support

// Included Mods

// Silver Weapons is included and tweaked in PoV, credits to excalibird
// Pain from injury is included and rewritten in PoV, creadits to Darxo

::TLW <- {
	ID = "mod_PoV",
	Name = "Path of the Vatt\'ghern", //PoV
	Version = "0.3.0",
	EnableEnemyMutation = true,	//default settings
	ChaosMode = false,
	EnableMainMenuArt = true
}

::TLW.HooksMod <- ::Hooks.register(::TLW.ID, ::TLW.Version, ::TLW.Name);
::TLW.HooksMod.require("mod_msu >= 1.7.2", "mod_modern_hooks >= 0.4.0", "mod_legends >= 19.1.23");
::TLW.HooksMod.conflictWith("mod_silver_weapons", "mod_PFI", "mod_TLW", "mod_more_bandits", "mod_background_perks", "mod_rpgr_parameters", "mod_LA", "Chirutiru_balance", "mod_Chirutiru_enemies", "zChirutiru_equipment", "mod_immortal_warriors", "mod_partiesDropNameds", "mod_weapons_updated", "mod_weapons", "mod_reforged", "mod_RevampedXPSystem", "mod_rpgr_raids", "mod_beast_loot"); 

// To fix SSU shit
::TLW.Haxxor <- {};
::TLW.HooksMod.queue(">mod_legends", "<mod_sellswords", function() 
{
    ::TLW.Haxxor.updatePerkGroupTooltips <- ::Const.Perks.updatePerkGroupTooltips; // store pointer to legends function
    ::Const.Perks.updatePerkGroupTooltips = function () {}; // bad ssu, do nothing ya bastard
});

::TLW.HooksMod.queue(">mod_legends", ">mod_AC", ">mod_nggh_magic_concept", ">mod_sellswords", ">mod_ROTUC", function() 
{
	// Register with MSU so people know to update (Beta Branch)
	::TLW.Mod <- ::MSU.Class.Mod(::TLW.ID, ::TLW.Version, ::TLW.Name);
	::TLW.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/TheBlueTemplar/PoV_Closed_Beta");
	::TLW.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::Const.Perks.updatePerkGroupTooltips = ::TLW.Haxxor.updatePerkGroupTooltips; // restore, all good (SSU)

	// load mod files 
    ::include("mod_PoV/load.nut");
    // load mod settings 
    ::include("mod_PoV/settingsLoad.nut");
});

::TLW.HooksMod.queue(">mod_legends", ">mod_AC", ">mod_nggh_magic_concept", ">mod_sellswords", ">mod_ROTUC", function() {
    // Load all files in afterHooks Folder
	::includeFiles(::IO.enumerateFiles(TLW.ID + "/afterHooks"));
}, ::Hooks.QueueBucket.AfterHooks);




