/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Some Settings (Not all?)
local page = ::TLW.Mod.ModSettings.addPage("Gameplay");

::TLW.EnableEnemyMutationID <- "EnableEnemyMutation"
local settingEnableEnemyMutation = page.addBooleanSetting(::TLW.EnableEnemyMutationID, true, "Enemy Mutations", "All enemies may have various thematic and appropriate mutations, making them stronger.\n\n The enemies that get a mutation also have a chance to drop relevant mutagens.\n\n Chances scale with combat difficulty\n\n");
::TLW.ChaosID <- "ChaosMode"
local settingChaos = page.addBooleanSetting(::TLW.ChaosID, false, "Chaos Mode", "All enemies can have multiple mutations, selected randomly from all of PoV\'s possible enemy mutations. Not balanced obv... \n\n The \"Enemy Mutations\" setting must also be checked for this mode to properly function.\n\n [b][color=" + this.Const.UI.Color.NegativeValue + "]MAY CHAOS TAKE THE WORLD![/color][/b]\n\n");

//finally, more callbacks...
settingEnableEnemyMutation.addCallback(function(_newValue)
{
	::TLW.EnableEnemyMutation = _newValue
})
settingChaos.addCallback(function(_newValue)
{
	::TLW.ChaosMode = _newValue
})


local page = ::TLW.Mod.ModSettings.addPage("Debug");

::TLW.LogID <- "Log";
local log = page.addBooleanSetting(::TLW.LogID, false, "Enable Logging", "Enable this for testing, dev, or when you want to re-create an error to send a good log. No reason to have it otherwise.\n\n");
log.addCallback(function ( _newValue )
{
	::TLW.Mod.Debug.setFlag(::MSU.System.Debug.DefaultFlag, _newValue);
});