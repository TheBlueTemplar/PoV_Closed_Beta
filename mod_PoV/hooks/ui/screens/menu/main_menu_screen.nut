/*::mods_hookNewObject("ui/screens/menu/main_menu_screen", function(o){
	
    local pov_onScreenShown = o.onScreenShown;
    o.onScreenShown = function ()
    {
        this.m.JSHandle.asyncCall("updatePOVBackgroundImage", ::TLW.ModSettings.getSetting("EnableMainMenuArt").getValue());
        return pov_onScreenShown();
	}
});*/