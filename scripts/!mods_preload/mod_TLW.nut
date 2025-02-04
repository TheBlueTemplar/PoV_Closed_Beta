::TLW <- {
	ID = "mod_TLW",
	Name = "The Last Witchers",
	Version = "1.0.0",
}

::TLW.HooksMod <- ::Hooks.register(::TLW.ID, ::TLW.Version, ::TLW.Name);
::TLW.HooksMod.require("mod_msu", "mod_modern_hooks", "mod_legends");

::TLW.HooksMod.queue(">mod_msu", ">mod_legends", function() {
	::TLW.Mod <- ::MSU.Class.Mod(::TLW.ID, ::TLW.Version, ::TLW.Name);

	::includeFiles(::IO.enumerateFiles(TLW.ID + "/hooks"));
	::includeFiles(::IO.enumerateFiles(TLW.ID + "/settings"));

	local page = ::TLW.Mod.ModSettings.addPage("Debug");

	::TLW.LogID <- "Log";
	local log = page.addBooleanSetting(::TLW.LogID, false, "Enable Logging");
	log.addCallback(function ( _newValue )
	{
		::TLW.Mod.Debug.setFlag(::MSU.System.Debug.DefaultFlag, _newValue);
	});
});