/*::TLW.HooksMod.hook("scripts/skills/actives/rally_the_troops", function ( q ) {

	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);

		local actor = this.getContainer().getActor();
		local percHP = actor.getHitpointsPct();
		if (!actor.getSkills().hasSkill("effects.legend_second_wind"))	//same idea as rally_the_troops -- integrating our mod into other mods so we get more opportunities for various interactions and emergent gameplay
		{
			if (percHP < 0.5)
			{
				if (this.m.Container.hasSkill("effects.pov_curse_master"))
				{
				this.m.Container.removeByID("effects.pov_curse_master");
				}
				if (this.m.Container.hasSkill("effects.pov_curse_slave"))
				{
				this.m.Container.removeByID("effects.pov_curse_slave");
				}
			}
		}
	}
});*/	//commented out for now as we dont use this effects

//should work too, probably