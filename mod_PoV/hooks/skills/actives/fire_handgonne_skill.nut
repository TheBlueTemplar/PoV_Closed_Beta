// IS THERE ANYTHING HERE THATS HOOKED AND NOT COMMENTED OUT?? FFS FML SMH

/*::TLW.HooksMod.hook("scripts/skills/actives/fire_handgonne_skill", function ( q ) {

	q.getAmmo = @(__original) function()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
        {
            return 0;
        }

        ::TLW.Mod.Debug.printLog("Checking if actor has Fhlesh Ammo");

		if (item.getName() == "Rotten Flesh Powder Bag")
		{
			::TLW.Mod.Debug.printLog("Replacing Handgonne Sound with Flesh...");
			this.m.SoundOnFire = [
				"sounds/combat/pov_fire_gonne_flesh_01.wav",
				"sounds/combat/pov_fire_gonne_flesh_02.wav",
				"sounds/combat/pov_fire_gonne_flesh_03.wav",
				"sounds/combat/pov_fire_gonne_flesh_04.wav"
			];
		}

		__original();
	}
});	*/