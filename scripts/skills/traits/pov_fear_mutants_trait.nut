this.pov_fear_mutants_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_fear_mutants";
		this.m.Name = "Fear of Mutants";
		this.m.Icon = "ui/traits/pov_fear_mutants.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what mutants are capable of, making this character less reliable when facing them on the battlefield.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.legend_aggressive",
			"trait.legend_ambitious",
			"trait.legend_natural",
			"trait.legend_pragmatic",
			"trait.legend_hate_mutants"
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Resolve when in battle against mutants."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] Melee Skill when in battle with against mutants."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] Ranged Skill when in battle with against mutants."
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingMutants = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (enemy.getFlags().has("mutant"))
			{
				fightingMutants = true;
				break;
			}
		}

		if (fightingMutants)
		{
			_properties.Bravery -= 10;
			_properties.MeleeSkillMult *= 0.94;
			_properties.RangedSkillMult *= 0.94;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});
