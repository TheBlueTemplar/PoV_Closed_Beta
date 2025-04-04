// New System
::TLW.MutatePlayer <-
{
	mutatePlayer = function (_actor, _mutagen)
	{
		// Ignores Mutation Limit in some mutation cases
		if(_mutagen.Name != "Donkey" && _mutagen.Name != "Vattghern")
		{
			// Checks For Mutation Limit ( Currently its 1 + 1 per 6 Levels)
			local mutationCount = _actor.getFlags().getAsInt("pov_ActiveMutations");
			local mutationLimit = 1 + this.Math.floor(_actor.getLevel()/7);

			// List of mutations that do not affect mutation count w/fallback
			if (_actor.getSkills().hasSkill("trait.pov_witcher")) {mutationCount -= 1;}
			if (_actor.getSkills().hasSkill("effects.pov_donkey_mutagen")) {mutationCount -= 1;}
			if (mutationCount < 0){mutationCount = 0;}

			if (mutationCount >= mutationLimit)
			{
				// Should play a sound and not use the item
				this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
				return false;
			}
		}

		// On Successful Requirements...

		// Add Mutation Effect
		// There is no fallback for the effect here, its before this function is called!
		_actor.getSkills().add(this.new(_mutagen.Script));

		// Add Conditional, Additional Effects
		if (_mutagen.Name == "Ghost")
		{
			if (_actor.getSkills().getSkillByID("perk.fearsome") == null)
			{
				_actor.getBackground().addPerk(this.Const.Perks.PerkDefs.Fearsome, 0, false);
				_actor.getSkills().add(this.new("scripts/skills/perks/perk_fearsome"));
			}else{
				//_actor.getSkills().add(this.new("scripts/skills/effects/gheist_resolve_bonus_effect"));
				_actor.getBaseProperties().Bravery += 10;
			}
		}

		// Play relevant Sounds
		if (_mutagen.len() != null)
		{
			for (local i = 0; i < (_mutagen.len() - 1); i++)
			{
				// Fallback, REQUIRED (For Some Reason)
				if (_mutagen.Sounds[i] != null)
				{
					this.Sound.play(_mutagen.Sounds[i], this.Const.Sound.Volume.Inventory);
				}
			}
		}

		// Add Mutation Sickness

		if (_actor.getSkills().hasSkill("injury.pov_sickness2"))
		{
			_actor.getSkills().getSkillByID("injury.pov_sickness2").addHealingTime(this.Math.rand(1, 3));
		}
		else
		{
			_actor.getSkills().add(this.new("scripts/skills/injury/pov_sickness2_injury"));
		}

		_actor.getSkills().getSkillByID("injury.pov_sickness2").addHealingTime(7 - _actor.getFlags().getAsInt("pov_ActiveMutations"));;
		local time = 0.0;

		// Idk wth that does

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		// Set a chance for team mood drop - Exclude the Vattghern Mutation

		// Set actor flags
		_actor.getFlags().increment("pov_ActiveMutations")
		_actor.getFlags().set("PotionLastUsed", time);
		_actor.getFlags().increment("PotionsUsed", 1);

		// Finishes the mutation, item is consumed
		return true;
	}
}

