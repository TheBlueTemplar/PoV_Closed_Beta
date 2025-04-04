::TLW.HooksMod.hook("scripts/entity/world/settlement", function ( q )
{
	q.updateRoster = @(__original) function(_force = false)
	{
        local bros = this.World.getPlayerRoster().getAll();
        foreach(bro in bros)
			{
				if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
				{
					if ("RosterSizeAdditionalMin" in this.World.Assets.m)
					{
						this.World.Assets.m.RosterSizeAdditionalMin += 1;
						::TLW.Mod.Debug.printLog("Fucking RosterSizeAdditionalMin: " + this.World.Assets.m.RosterSizeAdditionalMin);
					}
					if ("RosterSizeAdditionalMax" in this.World.Assets.m)
					{
						this.World.Assets.m.RosterSizeAdditionalMax  += 3;
						::TLW.Mod.Debug.printLog("Fucking RosterSizeAdditionalMax: " + this.World.Assets.m.RosterSizeAdditionalMax);
					}
				}
			}

		::TLW.Mod.Debug.printLog("Calling OG function, should unfuck after that.");
		__original(_force);

		foreach(bro in bros)	//doing reset cos i dont know when these values are set\\reset
		{
			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
			{
				if ("RosterSizeAdditionalMin" in this.World.Assets.m)
				{
					this.World.Assets.m.RosterSizeAdditionalMin -= 1;
					::TLW.Mod.Debug.printLog("Unfucking RosterSizeAdditionalMin: " + this.World.Assets.m.RosterSizeAdditionalMin);
				}
				if ("RosterSizeAdditionalMax" in this.World.Assets.m)
				{
					this.World.Assets.m.RosterSizeAdditionalMax  -= 3;
					::TLW.Mod.Debug.printLog("Unfucking RosterSizeAdditionalMax: " + this.World.Assets.m.RosterSizeAdditionalMax);
				}
			}
		}
	}
})

//holy shit, this was some drunk adventure right here