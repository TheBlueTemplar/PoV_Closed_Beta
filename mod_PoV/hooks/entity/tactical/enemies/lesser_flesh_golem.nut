::TLW.HooksMod.hook("scripts/entity/tactical/enemies/lesser_flesh_golem", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/pov_flesh_golem_buff_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/pov_unbearable_stench_passive_effect"));
		}

		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.FleshGolem));
	  	}
	
		/// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
			// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
			::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.Tank,false);
		}	 

		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}

	}

});
