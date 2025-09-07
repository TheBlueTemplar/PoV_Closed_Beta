// New System
::TLW.MutagenDrop <-
{
	getMutagenDrop = function (_actor, _mutagen)
	{
		local chance = _mutagen.BaseDropChance;
		// Practically, the chance for a mutant to appear AND drop a mutagen is ~0.3% across all diffs
		// this means a modifier of 300%, 200%, 150% and 75%
		local difficultyModifier = [3, 2, 1.5, 0.75][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;
		if (::TLW.ChaosMode)
		{
			// Chaos mode further cuts the mutagen drop chance by 60%, might reduce it more!
			chance *= 0.4;
		}
		//chance = 100; //For Testing Only
		::TLW.Mod.Debug.printLog("Rolling for Mutagen Drop || Chance: " + chance);
		return [chance, _mutagen.Script];
	}
}

// Enemy Mutation Chances Const
::TLW.EnemyMutChance <- 
{
	SLow = 5,
	VLow = 7,
	Low = 8,
	Medium = 9,
	Default = 10,
	High = 12,
	VHigh = 15,
	SHigh = 20,
	Test50 = 50,
	Test100 = 100
}

// Enemy Mutations Integration and other functions at the end of this file!
// Enemy Mutatuin System	
::TLW.MutateEntity <- 
{
	// New Enemy Mutation System ('Dynamic')
	// _mutations first has to be a defined array before passed here as an arg
	mutate_entity = function(_actor, _chance, _mutations, _hard)
	{
		local possibleMutations = _mutations;	// List of all possible mutations
		// Some debug and fallbacks
		if (possibleMutations == null || possibleMutations.len() <= 0)
		{
    	::TLW.Mod.Debug.printLog("Possible Error: Mutation array is empty. Skipping mutation.");
    	return;
		}
		
		// Mutation Chances Calculations Based on CombatDiff (from ez to legenddary)
		// Fallback (might not even work)
		if (_chance == null) {_chance = ::TLW.EnemyMutChance.Default;}
		// Example for most cases with base chance 10. Actual numbers would be: 5,7,10,20
		local mutationChance = [_chance*0.5, _chance*0.75, _chance, _chance*2][::World.Assets.getCombatDifficulty()];
		
		// Mutation Chance further increased by passed days (optional)
		if (::TLW.EnemyMutationScaling)
		{
			local day = this.World.getTime().Days;
			if (day != null)
			{
				// These are defined in mod_PoV_scaling_defs.nut
				if (day >= ::TLW.Scaling.D.Day) {mutationChance *= ::TLW.Scaling.D.Mult;}
				else if (day >= ::TLW.Scaling.C.Day) {mutationChance *= ::TLW.Scaling.C.Mult;}
				else if (day >= ::TLW.Scaling.B.Day) {mutationChance *= ::TLW.Scaling.B.Mult;}
				else if (day >= ::TLW.Scaling.A.Day) {mutationChance *= ::TLW.Scaling.A.Mult;}
			}
		}

		// Second Mutation Chances Calculation
		local secondMutationChance = mutationChance * 2;
		if (_actor.m.IsMiniboss == true) {secondMutationChance = mutationChance * 3;}

		// Roll a Mutation Number
		local roll = this.Math.rand(1.0, 100.0)
		local mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]
		::TLW.Mod.Debug.printLog("Rolling for mutation: " + roll + " vs " + mutationChance);

		if (roll <= mutationChance)
		{
			// Apply Mutation
			::TLW.Mod.Debug.printLog("Rolled mutation number: " + mutations);
			::TLW.EnemyMut.MutationFactory[mutations](_actor, _hard);

			// Second Mutation
			// Only Possible in non-easy diffs
			if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
			{
				local secondRoll = this.Math.rand(1.0, 100.0)
				::TLW.Mod.Debug.printLog("Rolling for second mutation: " + secondRoll + " vs " + secondMutationChance);
				if (secondRoll <= secondMutationChance)
				{
				    // Remove the mutation previosuly added from the array, to avoid duplication
				    possibleMutations.remove(possibleMutations.find(mutations))
				    // Fallback for second mut
				    if (possibleMutations.len() !=0)
				    {	
				    	// Pick a second mutation from the remaining options
				    	local secondMutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]
					    // Apply the second mutation
					    ::TLW.Mod.Debug.printLog("Rolled second mutation number: " + secondMutations);
					    ::TLW.EnemyMut.MutationFactory[secondMutations](_actor, _hard);
				    }
				}
			}
		}
	}
}

::TLW.Chaos <- 
{
	// Full credits to pot here (well, and Chopeks, and myself at that point xd)
	add_mutation_all = function(_actor, _hard)	// _hard argument is just to pass it to other functions
	{
		local roll;
		// Mutation Chance modification based on game's combat diff
		local mutationChance = [2.0, 3.0, 5.0, 7.0][::World.Assets.getCombatDifficulty()];
		//mutationChance = 25.0; // Debug
		
		// Create a list of all possible mutations (defined below)
		local possibleMutations = ::TLW.EnemyMut.All;

		// Incremental loop, rolls for each of the possible mutations once
		for (local i = 0; i < possibleMutations.len(); i++)
		{
			roll = this.Math.rand(1.0, 100.0);
			if (roll <= mutationChance)
			{
				local mutation = possibleMutations[i];
				::TLW.EnemyMut.MutationFactory[mutation](_actor, _hard);
				::TLW.Mod.Debug.printLog("Mutated with Roll: " + roll + " / " + mutationChance + " Rolled mutation number: " + mutation);
			}
		}
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
	::TLW.EnemyMutations.add_mutation_enemy_unhold(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_vampire(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_spider(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_orc(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_lindwurm(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_sandgolem(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_ghost(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_serpent(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_ghoul(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_basilisk(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_direwolf(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_goblin(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_schrat(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_skeleton(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_alp(this.actor, false);
	::TLW.EnemyMutations.add_mutation_enemy_hexe(this.actor, false);
	*/

	// Enemy Mutation General Function
	// Arguments: Entity type in files (serpent,ghoul etc.), title in battle, additional tag
	// actor and hard are  handled below
	add_mutation_enemy = function(_name, _title, _tag, _actor, _hard)
	{
		//Summoned entities currently CAN have mutations (no issue with me)
		if (_actor.isResurrected()){return;} //Fallback-Fix for enemies getting mutation when rising from dead

		// Mutant name change!
		if (!_actor.getFlags().has("mutant"))
		{
			local prevName = _actor.m.Name;
			_actor.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]"+_title+"[/color] " + prevName;
		}
		// Flag for one having a specific mutation (Part of the old system, not used now)
		if (!_actor.getFlags().has("pov_mutant_"+_name+""))
			_actor.getFlags().add("pov_mutant_"+_name+"")
		// Mutant flag, battle mechanics interactions
		if (!_actor.getFlags().has("mutant"))
			_actor.getFlags().add("mutant")
		// Additional Flag, used in cases like "undead", can also be empty
		if (_tag)
		{
			if (!_actor.getFlags().has(_tag))
			_actor.getFlags().add(_tag)
		}
		// Mutation addition
		if (_hard) 
		{
			// Placeholder, may be used may not be used, we shall see
		}else
		{
			// Enemy mutation added with fallback
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_"+_name+""))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_"+_name+""))
		}
		// Add the Mutation effect Sprite
		::TLW.MutantEffect.add_mutant_effect(_actor);
	}

	add_mutation_enemy_serpent = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("serpent", "Agile", null, _actor, _hard);
	}

	add_mutation_enemy_unhold = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("unhold", "Hulking", null, _actor, _hard);
	}

	add_mutation_enemy_vampire = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("vampire", "Vampiric", "undead", _actor, _hard);
	}

	add_mutation_enemy_spider = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("spider", "Poisonous", null, _actor, _hard);
	}

	add_mutation_enemy_orc = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("orc", "Savage", null, _actor, _hard);
	}

	add_mutation_enemy_lindwurm = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("lindwurm", "Wurmblood", null, _actor, _hard);
	}

	add_mutation_enemy_sandgolem = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("sandgolem", "Rockskin", null, _actor, _hard);
	}

	add_mutation_enemy_ghost = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("ghost", "Ghastly", "undead", _actor, _hard);
	}

	add_mutation_enemy_ghoul = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("ghoul", "Ghoulish", null, _actor, _hard);
	}

	add_mutation_enemy_basilisk = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("basilisk", "Focused", null, _actor, _hard);
	}

	add_mutation_enemy_direwolf = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("direwolf", "Beastly", null, _actor, _hard);
	}

	add_mutation_enemy_goblin = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("goblin", "Cunning", null, _actor, _hard);
	}

	add_mutation_enemy_schrat = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("schrat", "Barkhide", null, _actor, _hard);
	}

	add_mutation_enemy_skeleton = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("skeleton", "Revenant", "undead", _actor, _hard);
	}

	add_mutation_enemy_alp = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("alp", "Shifting", null, _actor, _hard);
	}

	add_mutation_enemy_hexe = function(_actor, _hard)
	{
		::TLW.EnemyMutations.add_mutation_enemy("hexe", "Cursebearer", null, _actor, _hard);
	}
	// ENEMY SPECIFIC MUTATIONS (wtf was this for xd)
}

// Function that Handles Enemy Mutation System
::TLW.EnemyMut <- {
  All = [],
  MutationFactory = [],

  // Add new mutation function
  add = function(_factory) 
  {
    local index = ::TLW.EnemyMut.All.len()+1;
    ::TLW.EnemyMut.All.push(index);
    while(index >= ::TLW.EnemyMut.MutationFactory.len())
    {
      ::TLW.EnemyMut.MutationFactory.push(function(_actor, _hard){});
    }
    ::TLW.EnemyMut.MutationFactory[index] = _factory;
    return index;
  },
  // Helper Function, call the All array and exclude defined stuff
  AllExcept = function (...)
  {
    return ::TLW.EnemyMut.All.filter(function (_idx, _x) { return !(_x in vargv) });
  },
  // Helper Function, call the All array and include only defined stuff
  Only = function (...)
  {
    return ::TLW.EnemyMut.All.filter(function (_idx, _x) { return (_x in vargv) });
  }
}

// Enemy Mutations Definition n Integration
// Added to Above Object via Its Function, take EnemyMutations function as arg
::TLW.EnemyMut.Unhold <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_unhold);
::TLW.EnemyMut.Vampire <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_vampire);
::TLW.EnemyMut.Spider <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_spider);
::TLW.EnemyMut.Orc <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_orc);
::TLW.EnemyMut.Lindwurm <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_lindwurm);
::TLW.EnemyMut.Sandgolem <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_sandgolem);
::TLW.EnemyMut.Ghost <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_ghost);
::TLW.EnemyMut.Serpent <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_serpent);
::TLW.EnemyMut.Ghoul <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_ghoul);
::TLW.EnemyMut.Basilisk <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_basilisk);
::TLW.EnemyMut.Direwolf <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_direwolf);
::TLW.EnemyMut.Goblin <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_goblin);
::TLW.EnemyMut.Schrat <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_schrat);
::TLW.EnemyMut.Skeleton <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_skeleton);
::TLW.EnemyMut.Alp <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_alp);
::TLW.EnemyMut.Hexe <- ::TLW.EnemyMut.add(::TLW.EnemyMutations.add_mutation_enemy_hexe);

// Enemy Mutation Arrays Are Created From The Above Values
// in Enemy_Mutation_Arrays.nut, in afterhooks (rest in prev file, bottom)

