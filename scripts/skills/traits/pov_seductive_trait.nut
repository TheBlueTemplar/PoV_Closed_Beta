this.pov_seductive_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Amount = 0.008
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_seductive";
		this.m.Name = "Seductive";
		this.m.Icon = "ui/traits/trait_seductive.png";
		this.m.Description = "Although many things can be taken at the point of a sword, some things will always be more potent than cold steel; the flash of an eyelash, the locking of a gaze...";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+0.8%[/color] barter skill"
			},
		];
	}
	
	function getModifier()
	{
		return this.m.Amount;
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

