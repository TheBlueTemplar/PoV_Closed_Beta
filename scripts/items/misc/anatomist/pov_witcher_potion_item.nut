this.pov_witcher_potion_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_witcher_potion";
		this.m.Name = "Trial Of The Grasses";
		this.m.Description = "The Trial Of The Grasses is the pinnacle of what research on human anatomy has yielded. The few who know of its existence claim that to consume it and survive, is to ascend to a higher state of being, something beyond a mere human. But the process, is truly horrifying \n\n The poor fellow who consumes this potion will be put under the ultimate test, at risk of their own life. [color=" + this.Const.UI.Color.NegativeValue + "]Only the most healthy and battle hardened people are guaranteed to survive[/color]. Even after surviving, they will be extremely sick for many days \n\n [color=" + this.Const.UI.Color.NegativeValue + "]This process is also going to negatively impact the entire party's mood[/color], affected individually by each brother's bravery and resolve.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_vattghern.png";
		this.m.Value = 3000;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

				result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing severe sickness"
		});

		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		if (!_actor.getSkills().hasSkill("trait.pov_witcher"))
		{
			// Check if bro has Anatomist Mutations (or SSU Sequences) THE DIE IF THEY DO MUEHEH (or just dont use the item)
			if (_actor.getFlags().getAsInt("ActiveMutations") >= 1)
			{
				if(this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					_actor.getItems().transferToStash(this.World.Assets.getStash());
					_actor.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_actor, "The Trial of the Grasses reacted horribly with their current mutations.");
					this.World.getPlayerRoster().remove(_actor);
					return true;
				}else{
					this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
					return false;
				}
			}

			// Check for brother's level, if not high enough, KILL HIM
			// Example: Base Chance 120 means that there is 0% final chance on bro lvl 12
			local deathChanceBase = 0;
			// Base Death Chance Modified By Game Diff
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy: deathChanceBase = 70; break
				case this.Const.Difficulty.Normal: deathChanceBase = 100; break
				case this.Const.Difficulty.Hard: deathChanceBase = 120; break
				case this.Const.Difficulty.Legendary: deathChanceBase = 120; break
			}
			local deathChanceFinal = 0;
			local deathChanceLevelReduction = _actor.getLevel()*10;
			local deathChanceHealthModifier = 0;
			local brothers = this.World.getPlayerRoster().getAll();

			local perks = _actor.getSkills();

			local negatives = ["trait.athletic","trait.iron_lungs","trait.lucky","trait.strong","trait.tough"]
			foreach (trait in negatives)
			{
			  if (perks.hasSkill(trait))
			    deathChanceHealthModifier -=20;
			}

			local positives = ["trait.ailing","trait.asthmatic","trait.bleeder","trait.fat","trait.fragile","trait.old"]
			foreach (trait in positives)
			{
			  if (perks.hasSkill(trait))
			    deathChanceHealthModifier +=20;
			}

			deathChanceFinal = deathChanceBase - deathChanceLevelReduction + deathChanceHealthModifier;
			if(deathChanceFinal < 0 || _actor.getSkills().hasSkill("trait.survivor"))
			{
				// Fallback
				deathChanceFinal = 0;
				if(_actor.getSkills().hasSkill("trait.survivor"))
				{
				_actor.improveMood(1, "I can survive ANYTHING");
				}
			}

			if (this.Math.rand(1, 100) <= deathChanceFinal)
			{
				_actor.getItems().transferToStash(this.World.Assets.getStash());
				_actor.getSkills().onDeath(this.Const.FatalityType.None);
				::Legends.addFallen(_actor, "Succumbed to the Trial of the Grasses.");
				this.World.getPlayerRoster().remove(_actor);

				// THERE IS A DEBUGGING THING BELOW 
				// (no more lmao, I used this worsen mood to debug XDD what a noob)
				foreach( bro in brothers )
				{
					bro.worsenMood(3, "Lost a Brother to the Horrifying Trial of the Grasses");
				}

				this.Sound.play("sounds/combat/poison_applied_02.wav", this.Const.Sound.Volume.Inventory);
				this.Sound.play("sounds/combat/acid_flask_impact_01.wav", this.Const.Sound.Volume.Inventory);
				this.Sound.play("sounds/humans/0/human_death_0" + this.Math.rand(1, 5) + ".wav", this.Const.Sound.Volume.Inventory);
				return true;
			}

			// Fetch party members and worsen their mood, this depends on traits
			foreach( bro in brothers )
			{
				if(bro.getBackground().getID() == "background.anatomist")
				{
					bro.improveMood(1, "Witnessesed a great mutation!");
				}
				else if(bro.getCurrentProperties().getBravery() > 70 || bro.getSkills().hasSkill("trait.brave") || bro.getSkills().hasSkill("trait.fearless") || bro.getSkills().hasSkill("trait.pov_witcher"))
				{
					bro.worsenMood(1, "Unsettled By The Trial Of The Grasses");
				}else if(bro.getCurrentProperties().getBravery() < 35 || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.dastard") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.pov_fear_mutants"))
				{
					bro.worsenMood(3, "Traumatised By The Trial Of The Grasses");
				}else
				{
					bro.worsenMood(2, "Horrified By The Trial Of The Grasses");
				}
			}

			//If bro did not die, they gain the Vatt'ghern trait!
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Vattghern);
			//return this.pov_anatomist2_potion_item.onUse(_actor, _item);
		} else {
			this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
			return false;
		}
	}
});


