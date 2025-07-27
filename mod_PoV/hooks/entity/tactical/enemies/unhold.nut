//make switchcase here too	//ok i did, thanks past me, you lazy fuck smh
::TLW.HooksMod.hook("scripts/entity/tactical/enemies/unhold", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()

		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			local corpse;
	        if (::MSU.isKindOf(this, "unhold_bog")) {
	            corpse = ::TLW.Corpse.UnholdBog;
	        } else if (::MSU.isKindOf(this, "unhold_frost")) {
	            corpse = ::TLW.Corpse.UnholdFrost;
	        } else {
	            corpse = ::TLW.Corpse.Unhold;
	        }

	        if (corpse != null) {
	            this.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(this, corpse));
	        } else {
	            ::TLW.Mod.Debug.printLog("No corpse found for " + this.getName());
	        }
	  	}

	  	// Racial
	  	 if (::MSU.isKindOf(this, "unhold_bog")){
	            this.m.Skills.add(this.new("scripts/skills/racial/pov_bog_unhold_racial"));
	        } else if (::MSU.isKindOf(this, "unhold_frost")){
	            this.m.Skills.add(this.new("scripts/skills/racial/pov_frost_unhold_racial"));
	        } else {
	            this.m.Skills.add(this.new("scripts/skills/racial/pov_unhold_racial"));
	        }
	  	

		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/pov_unhold_waning_fury_effect"));
			if (::MSU.isKindOf(this, "unhold_bog")) {
				this.m.Skills.add(this.new("scripts/skills/effects/pov_unbearable_stench_passive_effect"));
			}
		}

		// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
			// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
			if (::MSU.isKindOf(this, "unhold_bog")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.Unhold,false);
	        } else if (::MSU.isKindOf(this, "unhold_frost")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Default,::TLW.EnemyMut.Unhold,false);
	        } else {
				::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Medium,::TLW.EnemyMut.Unhold,false);
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