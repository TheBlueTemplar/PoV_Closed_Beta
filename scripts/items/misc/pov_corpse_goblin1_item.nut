this.pov_corpse_goblin1_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_goblin1";
		this.m.Name = "Goblin Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  However, goblin organs hold little value.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_goblin1.png";
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
				image = "consumables/pov_enemy_goblin1.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "Goblins are small humanoids that are very agressive and have a primitive, tribal culture.  In comparisson to a human, they are very agile and have superior eyesight.  They excel at ranged combat and prefer ambush tactics.\n\nLegends say that, long ago,the goblins were a highly advanced and peaceful race."
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

