/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Gameplay Settings 
local page = ::TLW.Mod.ModSettings.addPage("Gameplay");
page.addTitle("title", "Gameplay Settings");
page.addTitle("title2", "Main - Default Values Recommended");
page.addDivider("divider");

::TLW.EnableEnemyMutationID <- "EnableEnemyMutation"
local settingEnableEnemyMutation = page.addBooleanSetting(::TLW.EnableEnemyMutationID, true, "Enemy Mutations", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Recommended to keep this on, as it is a core mechanic of PoV.[/color] \n\n All enemies may get various thematic and appropriate mutations, making them stronger and creating interesting adaptive gameplay.\n\n The enemies that get a mutation also have a very low chance to drop relevant mutagens.\n\n Also enables some events, items and traits related to mutated enemies. All chances scale with combat difficulty and enemy strength");
::TLW.EnemyMutationScalingID <- "EnemyMutationScaling"
local settingEnemyMutationScaling = page.addBooleanSetting(::TLW.EnemyMutationScalingID, true, "Enemy Mutations Scaling", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Scales the Enemy Mutations based on passed ingame days. Recommended to keep on, unless you have other mods making late game more difficult.[/color] \n\n An attempt at keeping the endgame challenging - Enemy Mutations will appear more often on enemies, as the playthrough becomes longer. \n\n The \"Enemy Mutations\" setting must also be checked for this setting to function.");
::TLW.ChaosID <- "ChaosMode"
local settingChaos = page.addBooleanSetting(::TLW.ChaosID, false, "Chaos Mode", "[color=" + this.Const.UI.Color.povTooltipBlue + "]PoV is not balanced around this mode, it is only meant as a fun \"Challenge\". Off by default. [/color] \n\n All enemies can have multiple mutations, selected randomly from all of PoV\'s possible effects. Mutagen drop rates from enemy mutants will be lowered. \n\n The \"Enemy Mutations\" setting must also be checked for this mode to function.\n\n [b][color=" + this.Const.UI.Color.NegativeValue + "]MAY CHAOS TAKE THE WORLD![/color][/b]");


page.addTitle("title3", "Customization - Tweaks");
page.addDivider("divider2");

::TLW.McTweaksID <- "McTweaks"
local settingMcTweaks = page.addBooleanSetting(::TLW.McTweaksID, false, "MC Tweaks", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Optional tweaks to the \"Magic Concept\" mod[/color] \n\n Secondary option, off by default. Enables minor tweaks for better balance between MC and PoV, and removes an annoying enemy ability or two. Look at the PoV server for details.\n\n Will only work with the MC mod installed. Not recommended to turn on and off multiple times during a save.");

//Callbacks
settingEnableEnemyMutation.addCallback(function(_newValue)
{
	::TLW.EnableEnemyMutation = _newValue
})
settingEnemyMutationScaling.addCallback(function(_newValue)
{
    ::TLW.EnemyMutationScaling = _newValue
})
settingChaos.addCallback(function(_newValue)
{
	::TLW.ChaosMode = _newValue
})
settingMcTweaks.addCallback(function(_newValue)
{
    ::TLW.McTweaks = _newValue
})

// Misc Settings  
local page = ::TLW.Mod.ModSettings.addPage("Misc");
page.addTitle("title", "Misc Settings");
page.addDivider("divider");

::TLW.EnableMainMenuArtID <- "EnableMainMenuArt"
local settingEnableMainMenuArt = page.addBooleanSetting(::TLW.EnableMainMenuArtID, true, "PoV Main Menu Art", "[color=" + this.Const.UI.Color.povTooltipBlue + "]Toggle the display of PoV's main menu art.[/color] \n\n Disable this if you want another mod's or Vanilla art. Immediately works, no restart required.");

//Callbacks
settingEnableMainMenuArt.addAfterChangeCallback(function(_oldValue)
{
    if (_oldValue == getValue()) return;
    local main_menu = ::MSU.Utils.getState("main_menu_state").m.MainMenuScreen;
    if (::MSU.isNull(main_menu) || main_menu.m.JSHandle == null) return;
    main_menu.m.JSHandle.asyncCall("updatePOVBackgroundImage", getValue());
})

// Debug Settings 
local page = ::TLW.Mod.ModSettings.addPage("Debug");
page.addTitle("title", "Debug Settings - Advanced");
page.addDivider("divider");

::TLW.LogID <- "Log";
local log = page.addBooleanSetting(::TLW.LogID, false, "Enable Logging", "[color=" + this.Const.UI.Color.povTooltipBlue + "] Recommended to keep this on, when playing Beta versions of PoV.[/color]\n\nCurrently on by default. Enable this for testing, dev, streams or when you want to re-create an error to send a good log. \n\n For modders: Logs may be somewhat flooded");
page.addDivider("divider2");
::TLW.MysteryButtonID <- "MysteryButton";
local mysteryButton = page.addBooleanSetting(::TLW.MysteryButtonID, false, "Mystery Option", "[color=" + this.Const.UI.Color.povTooltipBlue + "]You never know, maybe this will bring you luck? Or...[/color]");

//Callbacks
log.addCallback(function ( _newValue )
{
	::TLW.Mod.Debug.setFlag(::MSU.System.Debug.DefaultFlag, _newValue);
});