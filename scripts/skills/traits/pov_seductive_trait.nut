this.pov_seductive_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Amount = 0.01
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_seductive";
		this.m.Name = "Irresistible Allure";
		this.m.Icon = "ui/traits/pov_seductive.png";
		this.m.Description = "This individual’s natural charm has been amplified by unknown magical forces, making them irresistibly captivating. \n\n On a completely unrelated note, they also seem to command a higher pay than anyone expected...";
		this.m.Excluded = [
			"trait.paranoid",
			"trait.cocky",
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
				icon = "ui/icons/asset_money.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1%[/color] barter skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Daily wage increased by [color=" + this.Const.UI.Color.NegativeValue + "]+10%[/color]"
			}
		];
	}
	
	function getModifier()
	{
		return this.m.Amount;
	}

	function onUpdate( _properties )
	{
		// Debuffs
		_properties.DailyWageMult *= 1.10;
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}	

});

