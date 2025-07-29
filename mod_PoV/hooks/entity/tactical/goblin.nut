::TLW.HooksMod.hook("scripts/entity/tactical/goblin", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()

		// Corpse Drop
		if (!::MSU.isKindOf(this, "player")) 
		{
			//cool kids use switchcases
			local corpse;
	        if (::MSU.isKindOf(this, "goblin_shaman")) {
	            corpse = ::TLW.Corpse.GoblinShaman;
	        } else if (::MSU.isKindOf(this, "goblin_leader")) {
	            corpse = ::TLW.Corpse.GoblinLeader;
	        } else {
	            corpse = ::TLW.Corpse.Goblin;
	        }

	        if (corpse != null) {
	            this.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(this, corpse));
	        } else {
	            ::TLW.Mod.Debug.printLog("No corpse found for " + this.getName());
	        }
	  	}

	  	// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
			// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
			
			if (::MSU.isKindOf(this, "goblin_shaman")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.Goblin,false);
	        } else if (::MSU.isKindOf(this, "goblin_leader")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.Goblin,false);
	        } else {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.VLow,::TLW.EnemyMut.Goblin,false);
	        }
		}

		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}

	}

});