/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

// Important objects for compatibility purposes (see how to call a few lines below)
::TLW.hasSSU <- ::mods_getRegisteredMod("mod_sellswords") != null;
::TLW.hasROTU <- ::mods_getRegisteredMod("mod_ROTUC") != null;
::TLW.hasMC <- ::mods_getRegisteredMod("mod_nggh_magic_concept") != null;

// Load SSU shit, if exists
if (::TLW.hasSSU)
{
	::includeFiles(::IO.enumerateFiles(TLW.ID + "/hooks_SSU"));
}
// Load ROTU shit, if exists
if (::TLW.hasROTU)
{
	::includeFiles(::IO.enumerateFiles(TLW.ID + "/hooks_ROTU"));
}
// Load MC shit, if exists
if (::TLW.hasMC)
{
	::includeFiles(::IO.enumerateFiles(TLW.ID + "/hooks_MC"));
}

// Load all files in Config Folder
::includeFiles(::IO.enumerateFiles(TLW.ID + "/config"));
// load register folder
::includeFiles(::IO.enumerateFiles(TLW.ID + "/register"));
// Load all files in Settings Folder
::includeFiles(::IO.enumerateFiles(TLW.ID + "/settings"));
// Load all files in Hooks Folder
::includeFiles(::IO.enumerateFiles(TLW.ID + "/hooks"));