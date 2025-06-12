// New System
::TLW.MutagenDrop <-
{
	getMutagenDrop = function (_actor, _mutagen)
	{
		local chance = _mutagen.BaseDropChance;
		// this means a modifier of 300%, 200%, 150% and 75%
		// Practically, the chance for a mutant to appear AND drop a mutagen is 0.3% across all diffs
		local difficultyModifier = [3, 2, 1.5, 0.75][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;
		if (::TLW.ChaosMode)
		{
			// Chaos mode further cuts the mutagen drop chance by half, might reduce it more!
			chance *= 0.5;
		}
		//chance = 100; //For Testing Only
		return [chance, _mutagen.Script];
	}
}

::TLW.Chaos <- 
{
	// Potttttt
	add_mutation_all = function(_actor, _hard)	// _hard argument is just to pass it to other functions
	{
		local roll = this.Math.rand(1.0, 100.0)
		local mutationChance = 5.0 	// Mutation Appearance Chance Handled by switch below
		local possibleMutations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] // Create a list of all possible mutations
		local mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]	//mutation number(index) roll
		
		// Mutation Chance modification based on game's combat diff
		switch (this.World.Assets.getCombatDifficulty())
		{
			case this.Const.Difficulty.Easy: mutationChance = 2.0; break
			case this.Const.Difficulty.Normal: mutationChance = 3.0; break
			case this.Const.Difficulty.Hard: mutationChance = 5.0; break
			case this.Const.Difficulty.Legendary: mutationChance = 8.0; break
		}

		//loop that checks the array(possibleMutations) length, rolls a mutation number(index) and removes rolled mutation from the array
		//log calls in this loop will absolutely shit the log(lol) obviously
		do //prob could be done way easier with good ol incremental loop, but i remembered those after writing all this shit so eh, it works
		{
			//::TLW.Mod.Debug.printLog("Rolling for mutation: " + roll + " vs " + mutationChance)
			if (roll <= mutationChance)
			{
				//::TLW.Mod.Debug.printLog("Rolled mutation number: " + mutations);
				//prob could include just one type of mutations(wildlife or humanoid), but it works either way since i added fallbacks before adding flags and effects(there should be no duplicates in any scenario)
				switch (mutations)
				{
					case 1: ::TLW.EnemyMutations.add_mutation_enemy_unhold(_actor, false); break;
				    case 2: ::TLW.EnemyMutations.add_mutation_enemy_vampire(_actor, false); break;
				    case 3: ::TLW.EnemyMutations.add_mutation_enemy_spider(_actor, false); break;
				    case 4: ::TLW.EnemyMutations.add_mutation_enemy_orc(_actor, false); break;
				    case 5: ::TLW.EnemyMutations.add_mutation_enemy_lindwurm(_actor, false); break;
				    case 6: ::TLW.EnemyMutations.add_mutation_enemy_sandgolem(_actor, false); break;
				    case 7: ::TLW.EnemyMutations.add_mutation_enemy_ghost(_actor, false); break;
				    case 8: ::TLW.EnemyMutations.add_mutation_enemy_serpent(_actor, false); break;
				    case 9: ::TLW.EnemyMutations.add_mutation_enemy_ghoul(_actor, false); break;
				    case 10: ::TLW.EnemyMutations.add_mutation_enemy_basilisk(_actor, false); break;
				    case 11: ::TLW.EnemyMutations.add_mutation_enemy_direwolf(_actor, false); break;
				    case 12: ::TLW.EnemyMutations.add_mutation_enemy_goblin(_actor, false); break;
				    case 13: ::TLW.EnemyMutations.add_mutation_enemy_schrat(_actor, false); break;
				    case 14: ::TLW.EnemyMutations.add_mutation_enemy_skeleton(_actor, false); break;
				    case 15: ::TLW.EnemyMutations.add_mutation_enemy_alp(_actor, false); break;
				    case 16: ::TLW.EnemyMutations.add_mutation_enemy_hexe(_actor, false); break;
				    default: ::TLW.Mod.Debug.printLog("Unknown mutation type: " + mutations); break;
				}
			}
			possibleMutations.remove(possibleMutations.find(mutations))	//removing rolled mutation from the array
			//::TLW.Mod.Debug.printLog("Removing rolled mutation (" + mutations + ") from the array, resulting length: " + possibleMutations.len())
			if(possibleMutations.len() != 0)	//this check fixes hitting nonexistent index when the possibleMutations array eventually becomes empty
				mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)] //mutation number(index) roll(well, reroll)
			roll = this.Math.rand(1.0, 100.0)	//roll reroll(lol)
		} while (possibleMutations.len() != 0)
	}
}

::TLW.MutantEffect <-
{
	add_mutant_effect = function(_actor)
	{
		// Adds sprite for the mutation effect (glow)
		if (_actor.hasSprite("pov_back_socket"))
		{
			local mutant_glow_sprite = _actor.getSprite("pov_back_socket");
			mutant_glow_sprite.setBrush("pov_mutant_glow"); //credit to ROTU mod for base art
			mutant_glow_sprite.Color = this.createColor("#0" + this.Math.rand(0,9) + this.Math.rand(59,99) + this.Math.rand(0,5) + "a"); // make the 96 part random! (70 - 99?)
			mutant_glow_sprite.Saturation = 0.8;
			mutant_glow_sprite.Scale = 0.9;
			//mutant_glow_sprite.varySaturation(0.1);
			//mutant_glow_sprite.varyColor(0.05, 0.05, 0.05);
			mutant_glow_sprite.Visible = true;
		}
		// Adds sprite for the mutation effect (bust)
		if (_actor.hasSprite("miniboss"))
		{
			local mutant_bust_sprite = _actor.getSprite("miniboss");
			mutant_bust_sprite.setBrush("pov_mutant_bust"); 
			mutant_bust_sprite.Saturation = 0.8;
			mutant_bust_sprite.Visible = true;
		}
	}
}

::TLW.EnemyMutations <-
{
	// ALL MUTATIONS REFERENCE
	/*
	::TLW.EnemyMutation.add_mutation_enemy_unhold(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_vampire(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_spider(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_orc(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_lindwurm(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_sandgolem(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_ghost(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_serpent(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_ghoul(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_basilisk(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_direwolf(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_goblin(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_schrat(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_skeleton(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_alp(this.actor, false);
	::TLW.EnemyMutation.add_mutation_enemy_hexe(this.actor, false);
	*/

	add_mutation_enemy_serpent = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;} //Fallback-Fix for enemies getting mutation when rising from dead

		// Flag for one having a specific mutation (Part of the old system, not used now)
		if (!_actor.getFlags().has("pov_mutant_serpent"))
			_actor.getFlags().add("pov_mutant_serpent")
		// Mutant flag, battle mechanics interactions
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		// Here, in some cases also the Undead flag is added, for the same reason
		if (_hard) 
		{
			// Placeholder, may be used may not be used, we shall see
		}else
		{
			// Enemy mutation added with fallback
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_serpent"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_serpent"))
		}

		// Add the Mutation effect Sprite
		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_unhold = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_unhold"))
			_actor.getFlags().add("pov_mutant_unhold")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_unhold"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_unhold"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_vampire = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_vampire"))
			_actor.getFlags().add("pov_mutant_vampire")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (!_actor.getFlags().has("undead"))
			_actor.getFlags().add("undead")

		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_vampire"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_vampire"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_spider = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_spider"))
			_actor.getFlags().add("pov_mutant_spider")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_spider"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_spider"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_orc = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_orc"))
			_actor.getFlags().add("pov_mutant_orc")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_orc"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_orc"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_lindwurm = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_lindwurm"))
			_actor.getFlags().add("pov_mutant_lindwurm")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")

		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_lindwurm"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_lindwurm"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_sandgolem = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_sandgolem"))
			_actor.getFlags().add("pov_mutant_sandgolem")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_sandgolem"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_sandgolem"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_ghost = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_ghost"))
			_actor.getFlags().add("pov_mutant_ghost")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (!_actor.getFlags().has("undead"))
			_actor.getFlags().add("undead")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_ghost"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_ghost"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_ghoul = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_ghoul"))
			_actor.getFlags().add("pov_mutant_ghoul")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_ghoul"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_ghoul"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_basilisk = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_basilisk"))
			_actor.getFlags().add("pov_mutant_basilisk")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_basilisk"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_basilisk"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_direwolf = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_direwolf"))
			_actor.getFlags().add("pov_mutant_direwolf")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_direwolf"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_direwolf"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_goblin = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_goblin"))
			_actor.getFlags().add("pov_mutant_goblin")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_goblin"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_goblin"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_schrat = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_schrat"))
			_actor.getFlags().add("pov_mutant_schrat")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_schrat"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_schrat"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_skeleton = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_skeleton"))
			_actor.getFlags().add("pov_mutant_skeleton")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_skeleton"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_skeleton"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_alp = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}

		if (!_actor.getFlags().has("pov_mutant_alp"))
			_actor.getFlags().add("pov_mutant_alp")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_alp"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_alp"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_hexe = function(_actor, _hard)
	{
		if (_actor.isResurrected()){return;}
		
		if (!_actor.getFlags().has("pov_mutant_hexe"))
			_actor.getFlags().add("pov_mutant_hexe")
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_hexe"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_hexe"))
		}

		::TLW.MutantEffect.add_mutant_effect(_actor);
	}
	
	// ENEMY SPECIFIC MUTATIONS (wtf was this for xd)
}