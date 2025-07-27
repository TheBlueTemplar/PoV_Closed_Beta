::TLW.HooksMod.hook("scripts/entity/tactical/skeleton", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()

		//Coprse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			local corpse;
	        if (::MSU.isKindOf(this, "skeleton_priest") || ::MSU.isKindOf(this, "skeleton_lich")) {
	            corpse = ::TLW.Corpse.SkeletonPriest;
	        } else if (::MSU.isKindOf(this, "skeleton_boss")) {
	            corpse = ::TLW.Corpse.SkeletonBoss;
	        } else {
	            corpse = ::TLW.Corpse.Skeleton;
	        }

	        if (corpse != null) {
	            this.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(this, corpse));
	        } else {
	            ::TLW.Mod.Debug.printLog("No corpse found for " + this.getName());
	        }
	  	}

	  	// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			local chance;
			local chanceSecret = 2;
			switch (this.World.Assets.getCombatDifficulty())
			{
				//case this.Const.Difficulty.Easy: mutationChance = 5; break
				case this.Const.Difficulty.Normal: chance = 7; break
				case this.Const.Difficulty.Hard: chance = 10; break
				case this.Const.Difficulty.Legendary: chance = 15; break
			}
			if (this.Math.rand(1.0, 100.0) <= chance)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/pov_potent_reanimation_effect"));
			}
			else if (this.Math.rand(1.0, 100.0) <= chanceSecret)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/pov_calcium_deficiency_effect"));
			}
		}

		// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
			// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
			if (::MSU.isKindOf(this, "skeleton_priest") || ::MSU.isKindOf(this, "skeleton_lich")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.High,::TLW.EnemyMut.Skeleton,false);
	        } else if (::MSU.isKindOf(this, "skeleton_boss")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.VHigh,::TLW.EnemyMut.Skeleton,false);
	        } else {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.Low,::TLW.EnemyMut.Skeleton,false);
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