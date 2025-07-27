/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Gameplay Settings 
local page = ::TLW.Mod.ModSettings.addPage("Gameplay");
page.addTitle("title", "Gameplay Settings");
page.addTitle("title2", "Recommended to keep Default Values");
page.addDivider("divider");
::TLW.EnableEnemyMutationID <- "EnableEnemyMutation"
local settingEnableEnemyMutation = page.addBooleanSetting(::TLW.EnableEnemyMutationID, true, "Enemy Mutations", "[color=#0b40b3]Recommended to keep this on, this is a core mechanic of PoV.[/color] \n\n All enemies may get various thematic and appropriate mutations, making them stronger and creating interesting adaptive gameplay.\n\n The enemies that get a mutation also have a very low chance to drop relevant mutagens.\n\n Also enables some events, items and traits related to mutated enemies. All chances scale with combat difficulty and enemy strength");
::TLW.ChaosID <- "ChaosMode"
local settingChaos = page.addBooleanSetting(::TLW.ChaosID, false, "Chaos Mode", "All enemies can have multiple mutations, selected randomly from all of PoV\'s possible effects. Mutagen drop rates will be lowered. \n\n PoV is not balanced around this mode, it is only meant as a fun \"Challenge\" mode. Off by default. \n\n The \"Enemy Mutations\" setting must also be checked for this mode to function.\n\n [b][color=" + this.Const.UI.Color.NegativeValue + "]MAY CHAOS TAKE THE WORLD![/color][/b]");

//Callbacks
settingEnableEnemyMutation.addCallback(function(_newValue)
{
	::TLW.EnableEnemyMutation = _newValue
})
settingChaos.addCallback(function(_newValue)
{
	::TLW.ChaosMode = _newValue
})

// Misc Settings  
local page = ::TLW.Mod.ModSettings.addPage("Misc");
page.addTitle("title", "Misc Settings");
page.addDivider("divider");
::TLW.EnableMainMenuArtID <- "EnableMainMenuArt"
local settingEnableMainMenuArt = page.addBooleanSetting(::TLW.EnableMainMenuArtID, true, "PoV Main Menu Art", "Toggle the display of PoV's main menu art. \n\n Disable this if you want another mod's or Vanilla art.");

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
local log = page.addBooleanSetting(::TLW.LogID, false, "Enable Logging", "Enable this for testing, dev, or when you want to re-create an error to send a good log. \n\n [color=#0b40b3] Recommended to keep this on, when playing Beta versions of PoV.[/color]");
page.addDivider("divider2");
::TLW.MysteryButtonID <- "MysteryButton";
local mysteryButton = page.addBooleanSetting(::TLW.MysteryButtonID, false, "Mystery Option", "[color=#0b40b3]You never know, maybe this will bring you luck? Or...[/color]");

log.addCallback(function ( _newValue )
{
	::TLW.Mod.Debug.setFlag(::MSU.System.Debug.DefaultFlag, _newValue);
});