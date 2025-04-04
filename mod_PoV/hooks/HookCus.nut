// OLD FILE, UNUSED CURRENTLY, WILL BE "LEGACY" SOON
/*::TLW.HookCus <- {

	getCorpseItemPath = function(_corpse) //separating this into (probably)many other functions, cos im not a formal coder and idk how to make this do what i want it to do without making it overly convoluted or refactoring the whole thing, and i already did that twice, so fuck that
	{
		//i remember doing it that way cos it was supposed to "intercept" other function and change it, and still be able to function in circumstances that the OG was used in, so this is too convoluted for its current purpose, could probaly make it with 3-4 lines and way easier, and without other helper function, but fuck it, this implementation is cool AND it works, refactor this shit urself if u dont like it
		local ItemPath = ::TLW.ItemPath.Corpse;
		foreach(key, value in ItemPath)
		{
			if (value == _corpse) //compares the value of current iteration over the table to the parameter that doCorpseDrop function takes(corpse item path)
			{
				local path = ::TLW.Drops.Corpse[key].Chance // forms the desired setting ID by taking the key(those are set accordingly in the defs and item_paths) that corresponds to the checked value
				//::TLW.Mod.Debug.printLog("Found the right key-value pair: " + key + " - " + value)
				//::TLW.Mod.Debug.printLog("Returned setting: " + path)
				return path;
			}
			//this.logInfo("Iterating ItemPath, key-value pair is: " + key + " - " + value) //prints this shit all over the log, not cool, printLog with some flag is better
			//::TLW.Mod.Debug.printLog("Iterating ItemPath, key-value pair is: " + key + " - " + value);
		}
		return null;
	}

	doCorpseDrop = function (_killer, _tile, _corpse)
	{
		// First check in the if below is SUS
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local chance = ::TLW.HookCus.getCorpseItemPath(_corpse);
			//local chance = 100; // FOR TESTING
			local rand = 0;
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy:
					rand = this.Math.rand(1.0, 85.0); // +15% base chance
					break
				case this.Const.Difficulty.Normal:
					rand = this.Math.rand(1.0, 100.0); // base chance
					break
				case this.Const.Difficulty.Hard:
					rand = this.Math.rand(1.0, 111.0); // -10% base chance
					break
				case this.Const.Difficulty.Legendary:
					rand = this.Math.rand(1.0, 125.0); // -20% base chance
					break
			}
			//::TLW.Mod.Debug.printLog("Rolling for corpse: " + rand + " vs " + chance);
			if (rand <= chance)
			{
				local loot = this.new(_corpse);
				loot.drop(_tile);
			}
		}
	}

	getMutagenItemPath = function(_mutagen) //takes local mutagen path(that is set with doWildlifeMutagenDrop function in onDeath function of every enemy), compares it to mutagen path table and forms(and then returns) the mutagen path to a setting(chance), prob can make it with just _corpse argument that would take a local corpse variable, but that will not work on humanoids, so it would not hurt to implement it the same way as for humanoids(which is not implemented as of yet, lol)
	{
		local ItemPath = ::TLW.ItemPath.Mutagen;
		foreach(key, value in ItemPath)
		{
			if (value == _mutagen)
			{
				local path = ::TLW.Drops.Mutagen[key].Chance
				::TLW.Mod.Debug.printLog("Found the right key-value pair: " + key + " - " + value)
				::TLW.Mod.Debug.printLog("Returned setting: " + path)
				return path;
			}
			//this.logInfo("Iterating ItemPath, key-value pair is: " + key + " - " + value) //prints this shit all over the log, not cool, printLog with some flag is better
			::TLW.Mod.Debug.printLog("Iterating ItemPath, key-value pair is: " + key + " - " + value);
		}
		return null;

	}

	doMutagenDrop = function(_killer, _tile, _mutagen) //wip
	{
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			// Get this from settings - Alternatively, set it in the line below
			//local chance = ::TLW.HookCus.getMutagenItemPath(_mutagen);
			local chance = 100; // STABLE CHANCE, FOR DEBUG

			local rand = 0;
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy:
					rand = this.Math.rand(1.0, 50.0); // +100% base chance, 4
					break
				case this.Const.Difficulty.Normal:
					rand = this.Math.rand(1.0, 100.0); // base chance, 2
					break
				case this.Const.Difficulty.Hard:
					rand = this.Math.rand(1.0, 166.0); // -40% base chance, 1.2
					break
				case this.Const.Difficulty.Legendary:
					rand = this.Math.rand(1.0, 500.0); // -80% base chance, 0.4
					break
			}
			::TLW.Mod.Debug.printLog("Rolling for mutagen: " + rand + " vs " + chance);
			if (rand <= chance)
			{
				local loot = this.new(_mutagen);
				loot.drop(_tile);
			}
		}
	}
}

/*	all mutations reference
		::TLW.WildlifeMutation.add_mutation_wildlife_unhold(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_vampire(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_spider(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_orc(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_lindwurm(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_sandgolem(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_ghost(this.actor, false);
		::TLW.WildlifeMutation.add_mutation_wildlife_serpent(this.actor, false);

		::TLW.HumanoidMutation.add_mutation_humanoid_unhold(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_vampire(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_spider(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_orc(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_lindwurm(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_sandgolem(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_ghost(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_serpent(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_ghoul(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_basilisk(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_direwolf(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_goblin(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_schrat(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_skeleton(this.actor, false)
		::TLW.HumanoidMutation.add_mutation_humanoid_alp(this.actor, false)
		
*/

//okay so Emo made like half the shit thats in this script, so kudos to Emo for making his shit opensource and allowing us to (ab)use his code

::TLW.WildlifeMutation <- {

	doWildlifeMutagenDrop = function (_killer, _tile, _actor)	//wip
	{
		local actorFlags = _actor.getFlags();
		local mutagen = null;

		//new implementation, it should roll for the mutagen drop per every flag, not just the first case hit
		local validFlags = {
			Ghost = "pov_wildlife_ghost"	//key should be the same as the key in item paths table
			SandGolem = "pov_wildlife_sandgolem"
			Lindwurm = "pov_wildlife_lindwurm"
			Orc = "pov_wildlife_orc"
			Serpent = "pov_wildlife_serpent"
			Spider = "pov_wildlife_spider"
			Unhold = "pov_wildlife_unhold"
			Vampire = "pov_wildlife_vampire"
		}

		foreach (flagKey, flagValue in validFlags)
		{
			if (actorFlags.has(flagValue))
			{
				::TLW.Mod.Debug.printLog("Found the right key-value pair: " + flagKey + " - " + flagValue)
				mutagen = ::TLW.ItemPath.Mutagen[flagKey]
				::TLW.Mod.Debug.printLog("Calling doMutagenDrop, set mutagen path: " + mutagen)
				::TLW.HookCus.doMutagenDrop(_killer, _tile, mutagen)
			}
			::TLW.Mod.Debug.printLog("Iterating actor flags, key-value pair is: " + flagKey + " - " + flagValue);
		}
	}

	//wip, functions for adding effects to actors and setting flags for drop functions
	// USE THIS FUNCTION AS REFERENCE TO UNDERSTAND SIMILAR ONES, NOT GONNA PASTE MY COMMENTS ON ALL OF EM
	add_mutation_wildlife_serpent = function(_actor, _hard)
	{
		//sets flags for doWildlifeMutagenDrop function
		if (!_actor.getFlags().has("pov_humanoid_serpent") && !_actor.getFlags().has("pov_wildlife_serpent")) //fallback, checking for flags before adding them, ideally should be in every similar case
			_actor.getFlags().add("pov_wildlife_serpent")
		//::TLW.Mod.Debug.printLog("Set pov_wildlife_serpent actor flag: " + _actor.getFlags().has("pov_wildlife_serpent"));

		// ADD AN EFFECT HERE
		// ADD EFFECT AFTER CHECKING FOR _hard. THIS CAN BE USED LATER
		if (_hard) //wip, next tier mutations
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_serpent")) //fallback
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_serpent"))
		}
	}

	add_mutation_wildlife_unhold = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_unhold") && !_actor.getFlags().has("pov_wildlife_unhold"))
			_actor.getFlags().add("pov_wildlife_unhold")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_unhold"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_unhold"))
		}
	}

	add_mutation_wildlife_vampire = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_vampire") && !_actor.getFlags().has("pov_wildlife_vampire"))
			_actor.getFlags().add("pov_wildlife_vampire")
		// ADDING UNDEAD FLAG, MAYBE I CAN ADD THIS AT THE EFFECT WITH onAdded, IDK
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
			//::TLW.Mod.Debug.printLog("actor flag check: " + _actor.getFlags().has("undead"))
		}

		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_vampire"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_vampire"))
		}
	}

	add_mutation_wildlife_spider = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_spider") && !_actor.getFlags().has("pov_wildlife_spider"))
			_actor.getFlags().add("pov_wildlife_spider")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_spider"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_spider"))
		}
	}

	add_mutation_wildlife_orc = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_orc") && !_actor.getFlags().has("pov_wildlife_orc"))
			_actor.getFlags().add("pov_wildlife_orc")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_orc"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_orc"))
		}
	}

	add_mutation_wildlife_lindwurm = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_lindwurm") && !_actor.getFlags().has("pov_wildlife_lindwurm"))
			_actor.getFlags().add("pov_wildlife_lindwurm")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_lindwurm"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_lindwurm"))
		}
	}

	add_mutation_wildlife_sandgolem = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_sandgolem") && !_actor.getFlags().has("pov_wildlife_sandgolem"))
			_actor.getFlags().add("pov_wildlife_sandgolem")
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_sandgolem"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_sandgolem"))
		}
	}

	add_mutation_wildlife_ghost = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_ghost") && !_actor.getFlags().has("pov_wildlife_ghost"))
			_actor.getFlags().add("pov_wildlife_ghost")
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
			//::TLW.Mod.Debug.printLog("actor flag check: " + _actor.getFlags().has("undead"))
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_ghost"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_ghost"))
		}
	}

}



//prob gonna be the same shit as above, but still tis better to separate cos this is still very basic and idk where it will go
// Good choice pot
::TLW.HumanoidMutation <- {

	doHumanoidMutagenDrop = function (_killer, _tile, _actor)	//wip
	{
		local actorFlags = _actor.getFlags();
		local mutagen = null;

		//new implementation, it should roll for the mutagen drop per every flag, not just the first case hit
		local validFlags = {
			Ghost = "pov_humanoid_ghost"	//key should be the same as the key in item paths table
			SandGolem = "pov_humanoid_sandgolem"
			Lindwurm = "pov_humanoid_lindwurm"
			Orc = "pov_humanoid_orc"
			Serpent = "pov_humanoid_serpent"
			Spider = "pov_humanoid_spider"
			Unhold = "pov_humanoid_unhold"
			Vampire = "pov_humanoid_vampire"
			Ghoul = "pov_humanoid_ghoul"
			Basilisk = "pov_humanoid_basilisk"
			Direwolf = "pov_humanoid_direwolf"
			Goblin = "pov_humanoid_goblin"
			Schrat = "pov_humanoid_schrat"
			Skeleton = "pov_humanoid_skeleton"
			Alp = "pov_humanoid_alp"
			Hexe = "pov_humanoid_hexe"
		}

		foreach (flagKey, flagValue in validFlags)
		{
			if (actorFlags.has(flagValue))
			{
				::TLW.Mod.Debug.printLog("Found the right key-value pair: " + flagKey + " - " + flagValue)
				mutagen = ::TLW.ItemPath.Mutagen[flagKey]
				::TLW.Mod.Debug.printLog("Calling doMutagenDrop, set mutagen path: " + mutagen)
				::TLW.HookCus.doMutagenDrop(_killer, _tile, mutagen)
			}
			::TLW.Mod.Debug.printLog("Iterating actor flags, key-value pair is: " + flagKey + " - " + flagValue);
		}
	}

	//wip, functions for adding effects to actors and setting flags for drop functions
	// ALL FUNCTIONS HERE MUST GIVE BEAST/UNDEAD FLAG TO HUMANS!
	add_mutation_humanoid_serpent = function(_actor, _hard)
	{
		//sets flags for doWildlifeMutagenDrop function
		if (!_actor.getFlags().has("pov_humanoid_serpent") && !_actor.getFlags().has("pov_wildlife_serpent"))
			_actor.getFlags().add("pov_humanoid_serpent")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard) //wip, next tier mutations
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_serpent"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_serpent"))
		}
	}

	add_mutation_humanoid_unhold = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_unhold") && !_actor.getFlags().has("pov_wildlife_unhold"))
			_actor.getFlags().add("pov_humanoid_unhold")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_unhold"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_unhold"))
		}
	}

	add_mutation_humanoid_vampire = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_vampire") && !_actor.getFlags().has("pov_wildlife_vampire"))
			_actor.getFlags().add("pov_humanoid_vampire")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
			//::TLW.Mod.Debug.printLog("actor flag check: " + _actor.getFlags().has("undead"))
		}

		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_vampire"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_vampire"))
		}
	}

	add_mutation_humanoid_spider = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_spider") && !_actor.getFlags().has("pov_wildlife_spider"))
			_actor.getFlags().add("pov_humanoid_spider")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_spider"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_spider"))
		}
	}

	add_mutation_humanoid_orc = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_orc") && !_actor.getFlags().has("pov_wildlife_orc"))
			_actor.getFlags().add("pov_humanoid_orc")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_orc"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_orc"))
		}
	}

	add_mutation_humanoid_lindwurm = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_lindwurm") && !_actor.getFlags().has("pov_wildlife_lindwurm"))
			_actor.getFlags().add("pov_humanoid_lindwurm")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}

		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_lindwurm"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_lindwurm"))
		}
	}

	add_mutation_humanoid_sandgolem = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_sandgolem") && !_actor.getFlags().has("pov_wildlife_sandgolem"))
			_actor.getFlags().add("pov_humanoid_sandgolem")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_sandgolem"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_sandgolem"))
		}
	}

	add_mutation_humanoid_ghost = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_ghost") && !_actor.getFlags().has("pov_wildlife_ghost"))
			_actor.getFlags().add("pov_humanoid_ghost")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
			//::TLW.Mod.Debug.printLog("actor flag check: " + _actor.getFlags().has("undead"))
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_ghost"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_ghost"))
		}
	}

	add_mutation_humanoid_ghoul = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_ghoul") && !_actor.getFlags().has("pov_wildlife_ghoul"))
			_actor.getFlags().add("pov_humanoid_ghoul")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_ghoul"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_ghoul"))
		}
	}

	add_mutation_humanoid_basilisk = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_basilisk") && !_actor.getFlags().has("pov_wildlife_basilisk"))
			_actor.getFlags().add("pov_humanoid_basilisk")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_basilisk"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_basilisk"))
		}
	}

	add_mutation_humanoid_direwolf = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_direwolf") && !_actor.getFlags().has("pov_wildlife_direwolf"))
			_actor.getFlags().add("pov_humanoid_direwolf")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_direwolf"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_direwolf"))
		}
	}

	add_mutation_humanoid_goblin = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_goblin") && !_actor.getFlags().has("pov_wildlife_goblin"))
			_actor.getFlags().add("pov_humanoid_goblin")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_goblin"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_goblin"))
		}
	}

	add_mutation_humanoid_schrat = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_schrat") && !_actor.getFlags().has("pov_wildlife_schrat"))
			_actor.getFlags().add("pov_humanoid_schrat")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_schrat"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_schrat"))
		}
	}

	add_mutation_humanoid_skeleton = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_skeleton") && !_actor.getFlags().has("pov_wildlife_skeleton"))
			_actor.getFlags().add("pov_humanoid_skeleton")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (!_actor.getFlags().has("undead"))
		{
			_actor.getFlags().add("undead")
			//::TLW.Mod.Debug.printLog("actor flag check: " + _actor.getFlags().has("undead"))
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_skeleton"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_skeleton"))
		}
	}

	add_mutation_humanoid_alp = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_alp") && !_actor.getFlags().has("pov_wildlife_alp"))
			_actor.getFlags().add("pov_humanoid_alp")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_alp"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_alp"))
		}
	}

	add_mutation_humanoid_hexe = function(_actor, _hard)
	{
		if (!_actor.getFlags().has("pov_humanoid_hexe") && !_actor.getFlags().has("pov_wildlife_hexe"))
			_actor.getFlags().add("pov_humanoid_hexe")
		if (!_actor.getFlags().has("mutant"))
		{
			_actor.getFlags().add("mutant")
		}
		if (_hard)
		{
			// ..I am
		}else
		{
			if (!_actor.getSkills().hasSkill("effects.pov_enemy_mutation_hexe"))
				_actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_mutation_hexe"))
		}
	}


}
/*
::TLW.Chaos <- {

	add_mutation_all = function(_actor, _hard)	// _hard argument is just to pass it to other functions
	{
		local roll = this.Math.rand(1.0, 100.0)
		local mutationChance = 100.0 	// Mutation Appearance Chance Handled by switch below
		local possibleMutations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] // Create a list of all possible mutations

		//for testing - you can comment out this switch
		switch (this.World.Assets.getCombatDifficulty())
		{
			case this.Const.Difficulty.Easy: mutationChance = 2.0; break
			case this.Const.Difficulty.Normal: mutationChance = 4.0; break
			case this.Const.Difficulty.Hard: mutationChance = 7.0; break
			case this.Const.Difficulty.Legendary: mutationChance = 14.0; break
		}

		local mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)]	//mutation number(index) roll

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
					case 1: ::TLW.WildlifeMutation.add_mutation_wildlife_unhold(_actor, _hard);	break
					case 2: ::TLW.WildlifeMutation.add_mutation_wildlife_vampire(_actor, _hard); break
					case 3: ::TLW.WildlifeMutation.add_mutation_wildlife_spider(_actor, _hard); break
					case 4: ::TLW.WildlifeMutation.add_mutation_wildlife_orc(_actor, _hard); break
					case 5: ::TLW.WildlifeMutation.add_mutation_wildlife_lindwurm(_actor, _hard); break
					case 6: ::TLW.WildlifeMutation.add_mutation_wildlife_sandgolem(_actor, _hard); break
					case 7: ::TLW.WildlifeMutation.add_mutation_wildlife_ghost(_actor, _hard); break
					case 8: ::TLW.WildlifeMutation.add_mutation_wildlife_serpent(_actor, _hard); break

					case 9: ::TLW.HumanoidMutation.add_mutation_humanoid_unhold(_actor, _hard); break
					case 10: ::TLW.HumanoidMutation.add_mutation_humanoid_vampire(_actor, _hard); break
					case 11: ::TLW.HumanoidMutation.add_mutation_humanoid_spider(_actor, _hard); break
					case 12: ::TLW.HumanoidMutation.add_mutation_humanoid_orc(_actor, _hard); break
					case 13: ::TLW.HumanoidMutation.add_mutation_humanoid_lindwurm(_actor, _hard); break
					case 14: ::TLW.HumanoidMutation.add_mutation_humanoid_sandgolem(_actor, _hard); break
					case 15: ::TLW.HumanoidMutation.add_mutation_humanoid_ghost(_actor, _hard); break
					case 16: ::TLW.HumanoidMutation.add_mutation_humanoid_serpent(_actor, _hard); break
				}
			}
			possibleMutations.remove(possibleMutations.find(mutations))	//removing rolled mutation from the array
			//::TLW.Mod.Debug.printLog("Removing rolled mutation (" + mutations + ") from the array, resulting length: " + possibleMutations.len())
			if(possibleMutations.len() != 0)	//this check fixes hitting nonexistent index when the possibleMutations array eventually becomes empty
				mutations = possibleMutations[this.Math.rand(0, possibleMutations.len() - 1)] //mutation number(index) roll(well, reroll)
			roll = this.Math.rand(1.0, 100.0)	//roll reroll(lol)
		} while (possibleMutations.len() != 0)
	}
}*/