::TLW.HooksMod.hook("scripts/skills/injury/injury", function ( q ) {

	q.onAdded = @(__original) function()
	{
		if (this.Tactical.isActive())
		{
			if (this.getContainer().hasSkill("effects.adrenaline") == false)
			{
				this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/pov_pain_effect"));
			}
		}
	}
});	

// May not work wth modern hooks, as legends does this hookin shit with old hooks!