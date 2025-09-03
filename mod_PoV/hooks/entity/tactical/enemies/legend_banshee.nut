::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_banshee", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.LegendBanshee));
	  	}

		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		//this.m.Skills.add(this.new("scripts/skills/effects/pov_serpentine_agility_effect"));
		
		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}

		// No Mutation For Ghosts Currently
		
		// Edits of other mods (hooks)
		if (::TLW.hasMC && ::TLW.McTweaks)
		{
			local badThing = this.actor.getSkills().getSkillByID("actives.ghost_possess");
			if (badThing)
			{
				this.actor.getSkills().remove(badThing);
			}
		}
	}

});