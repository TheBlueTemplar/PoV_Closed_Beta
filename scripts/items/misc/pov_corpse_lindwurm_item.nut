this.pov_corpse_lindwurm_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_lindwurm";
		this.m.Name = "Lindwurm Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "Bones, blood and skin.  Every part of the lindwurm is very valuable.  It is also exceptionally rare as few of these beasts are ever defeated.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_lindwurm.png";
		this.m.Value = 50;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 10;
		this.m.IsUndesirable = true;
		this.m.IsAllowedInBag = false;
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
				id = 3,
				type = "image",
				image = "consumables/pov_enemy_lindwurm.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The lindwurm is a colossal dragon.  Wingless, but much larger, it has been recorded at lengths up to 50 meters.  Its scales are as hard as steel and its fangs are as long as greatswords.  If you manage to hurt it, its blood is a highly corosive acid.\n\nThe wurm can attack with both its jaws as well as its tail, a massive spiked club, that can kill a man in one blow."
		});

		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Will decompose in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});


		return result;

	}

	function isAmountShown()
	{
		return false;
	}



});

