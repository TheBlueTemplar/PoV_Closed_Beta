::TLW.HooksMod.hook("scripts/entity/tactical/enemies/ghost", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.Ghost));
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
		/*
		// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Possible Mutations, See Enemy_Mutations.nut, line 22+ for reference
			local muts = [1, 6, 8, 13, 14, 15, 16];
			// Define actor, base mutation chance, array above and say false
			::TLW.MutateEntity.mutate_entity(this.actor,12,muts,false);
		}
		*/
	}

});