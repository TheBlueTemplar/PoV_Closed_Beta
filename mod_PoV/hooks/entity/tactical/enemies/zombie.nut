::TLW.HooksMod.hook("scripts/entity/tactical/enemies/zombie", function ( q )
{

	q.onInit = @(__original) function()
	{
		__original()

		// Corpse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			local corpse;
	        if (::MSU.isKindOf(this, "zombie_knight")) {
	            corpse = ::TLW.Corpse.ZombieKnight;
	        } else{
	            corpse = ::TLW.Corpse.Zombie;
	        }

	        if (corpse != null) {
	            this.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(this, corpse));
	        } else {
	            ::TLW.Mod.Debug.printLog("No corpse found for " + this.getName());
	        }

	  	}

	  	// Racial
	  	this.m.Skills.add(this.new("scripts/skills/racial/pov_zombie_racial"));
	  	
	  	// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			local chance;
			local chanceSecret = 2;
			local prevName = this.m.Name;
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
				this.m.Name = "Potent " + prevName;
			}
			else if (this.Math.rand(1.0, 100.0) <= chanceSecret)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/pov_calcium_deficiency_effect"));
				this.m.Name = "Deficient " + prevName;
			}
		}

		// Enemy Mutation System
		if (::TLW.EnableEnemyMutation)
		{
			// Second arg (int) reference in Enemy_Mutations.nut, lines 22+
			// Third arg (array) reference in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)
			 if (::MSU.isKindOf(this, "zombie_knight")) {
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.High,::TLW.EnemyMut.ZombieGroup,false);
	        } else{
	            ::TLW.MutateEntity.mutate_entity(this.actor,::TLW.EnemyMutChance.VLow,::TLW.EnemyMut.ZombieGroup,false);
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