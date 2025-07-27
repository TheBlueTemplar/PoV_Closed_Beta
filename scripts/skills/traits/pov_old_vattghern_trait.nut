this.pov_old_vattghern_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_old_vattghern";
		this.m.Name = "Old Vattghern";
		this.m.Icon = "skills/pov_old_vattghern.png";
		this.m.Description = "Despite being old, %name% has retained the majority of his skills and abilities, thanks to his vast experience and mutations.";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Hitpoints"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Max Fatigue"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 5;
		_properties.Hitpoints -= 5;
		_properties.Stamina -= 5;
		_properties.Initiative -= 5;
		//_properties.Vision -= 1;
		//_properties.IsContentWithBeingInReserve = true;
	}

});

