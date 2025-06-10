this.pov_nyctophobia_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_nyctophobia";
		this.m.Name = "Nyctophobia";
		this.m.Icon = "ui/traits/pov_nyctophobia.png";
		this.m.Description = "There\'s a reason he won\'t stand the nightwatch. Says the dark remembers him… and one night, it\'ll come collect";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.night_owl",
			"trait.legend_aggressive",
			"trait.legend_ambitious",
			"trait.legend_natural",
			"trait.legend_pragmatic",
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
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Resolve with an additional reduction of [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] when battling at night."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] initiative when battling at night."
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


		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.BraveryMult *= 0.85;
			_properties.Bravery -= 5;
			_properties.InitiativeMult *= 0.85;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});
