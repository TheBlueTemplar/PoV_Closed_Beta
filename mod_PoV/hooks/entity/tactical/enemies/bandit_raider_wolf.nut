::TLW.HooksMod.hook("scripts/entity/tactical/enemies/bandit_raider_wolf", function ( q ) {

	q.onInit = @(__original) function()
	{
		__original()

		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}

		if (::TLW.EnableEnemyMutation)
		{
			local roll = this.Math.rand(1.0, 100.0)
			local mutationChance = 0.0 	// Mutation Appearance Chance Handled by switch below
			local secondMutationChance = 0.0 // Second Mutation Appearance Chance Handled below
			local possibleMutations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16]		// Create a list of all possible mutations

			// Chances Calculations
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy: mutationChance = 5; break
				case this.Const.Difficulty.Normal: mutationChance = 7; break
				case this.Const.Difficulty.Hard: mutationChance = 10; break
				case this.Const.Difficulty.Legendary: mutationChance = 20; break
			}

			if (this.actor.m.IsMiniboss == true)
			{
				secondMutationChance = mutationChance * 4
			}else
			{
				secondMutationChance = mutationChance * 2
			}

			// Roll a Mutation Number
			local mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]
			//::TLW.Mod.Debug.printLog("Rolling for mutation: " + roll + " vs " + mutationChance);
			//mutations = 16 // Testing and Debug only
			if (roll <= mutationChance)
			{
				//::TLW.Mod.Debug.printLog("Rolled mutation number: " + mutations);
				switch (mutations)
				{
				    case 1: ::TLW.EnemyMutations.add_mutation_enemy_unhold(this.actor, false); break;
				    case 2: ::TLW.EnemyMutations.add_mutation_enemy_vampire(this.actor, false); break;
				    case 3: ::TLW.EnemyMutations.add_mutation_enemy_spider(this.actor, false); break;
				    case 4: ::TLW.EnemyMutations.add_mutation_enemy_orc(this.actor, false); break;
				    case 5: ::TLW.EnemyMutations.add_mutation_enemy_lindwurm(this.actor, false); break;
				    case 6: ::TLW.EnemyMutations.add_mutation_enemy_sandgolem(this.actor, false); break;
				    case 7: ::TLW.EnemyMutations.add_mutation_enemy_ghost(this.actor, false); break;
				    case 8: ::TLW.EnemyMutations.add_mutation_enemy_serpent(this.actor, false); break;
				    case 9: ::TLW.EnemyMutations.add_mutation_enemy_ghoul(this.actor, false); break;
				    case 10: ::TLW.EnemyMutations.add_mutation_enemy_basilisk(this.actor, false); break;
				    case 11: ::TLW.EnemyMutations.add_mutation_enemy_direwolf(this.actor, false); break;
				    //case 12: ::TLW.EnemyMutations.add_mutation_enemy_goblin(this.actor, false); break;
				    case 13: ::TLW.EnemyMutations.add_mutation_enemy_schrat(this.actor, false); break;
				    case 14: ::TLW.EnemyMutations.add_mutation_enemy_skeleton(this.actor, false); break;
				    case 15: ::TLW.EnemyMutations.add_mutation_enemy_alp(this.actor, false); break;
				    case 16: ::TLW.EnemyMutations.add_mutation_enemy_hexe(this.actor, false); break;
				    default: ::TLW.Mod.Debug.printLog("Unknown mutation type: " + mutations); break;
				}

				// Second Mutation
				if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
				{
					local secondRoll = this.Math.rand(1.0, 100.0)
					if (secondRoll <= secondMutationChance)
					{
					    // Remove the first chosen mutation from the list to avoid duplication
					    possibleMutations.remove(possibleMutations.find(mutations))
					    // Pick a second mutation from the remaining 7 options
					    local champMutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]

					    // Apply the second mutation
					    switch (champMutations)
					    {
					        case 1: ::TLW.EnemyMutations.add_mutation_enemy_unhold(this.actor, false); break;
						    case 2: ::TLW.EnemyMutations.add_mutation_enemy_vampire(this.actor, false); break;
						    case 3: ::TLW.EnemyMutations.add_mutation_enemy_spider(this.actor, false); break;
						    case 4: ::TLW.EnemyMutations.add_mutation_enemy_orc(this.actor, false); break;
						    case 5: ::TLW.EnemyMutations.add_mutation_enemy_lindwurm(this.actor, false); break;
						    case 6: ::TLW.EnemyMutations.add_mutation_enemy_sandgolem(this.actor, false); break;
						    case 7: ::TLW.EnemyMutations.add_mutation_enemy_ghost(this.actor, false); break;
						    case 8: ::TLW.EnemyMutations.add_mutation_enemy_serpent(this.actor, false); break;
						    case 9: ::TLW.EnemyMutations.add_mutation_enemy_ghoul(this.actor, false); break;
						    case 10: ::TLW.EnemyMutations.add_mutation_enemy_basilisk(this.actor, false); break;
						    case 11: ::TLW.EnemyMutations.add_mutation_enemy_direwolf(this.actor, false); break;
						    case 12: ::TLW.EnemyMutations.add_mutation_enemy_goblin(this.actor, false); break;
						    case 13: ::TLW.EnemyMutations.add_mutation_enemy_schrat(this.actor, false); break;
						    case 14: ::TLW.EnemyMutations.add_mutation_enemy_skeleton(this.actor, false); break;
						    case 15: ::TLW.EnemyMutations.add_mutation_enemy_alp(this.actor, false); break;
						    case 16: ::TLW.EnemyMutations.add_mutation_enemy_hexe(this.actor, false); break;
						    default: ::TLW.Mod.Debug.printLog("Unknown or invalid mutation type: " + champMutations); break;
					    }
					}
				}
			}
		}
	}

});