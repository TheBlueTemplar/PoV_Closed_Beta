::TLW.HooksMod.hook("scripts/skills/injury/injury", function ( q ) {

	q.onAdded = @(__original) function()
	{
		__original();
		
		if (this.Tactical.isActive())
		{
			if (this.getContainer().hasSkill("effects.adrenaline") == false)
			{
				local actor = this.getContainer().getActor();
				if (::MSU.isKindOf(this, "orc_berserker") || actor.getSkills().hasSkill("effects.pov_orc_mutagen") || actor.getSkills().hasSkill("effects.pov_enemy_mutation_orc"))
				{
					actor.getSkills().add(this.new("scripts/skills/effects/pov_orc_pain_effect"));
				}
				else if (actor.getFlags().has("undead"))
				{
					actor.getSkills().add(this.new("scripts/skills/effects/pov_undead_pain_effect"));
				} 
				else 
				{
					actor.getSkills().add(this.new("scripts/skills/effects/pov_pain_effect"));
				}
			}
		}
	}
});	

// May not work wth modern hooks, as legends does this hookin shit with old hooks!