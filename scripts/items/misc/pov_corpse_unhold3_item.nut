this.pov_corpse_unhold3_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_unhold3";
		this.m.Name = "Swamp Unhold Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/enemy_unhold3.png";
		this.m.Icon = "consumables/pov_corpse_unhold3.png";
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
				image = "consumables/pov_enemy_unhold3.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The swamp unhold is the most predatory of unholds.  They prefer to live in warm, swampy regions.  Like all unholds they adapt quickly to their  environments.  In this case, their skin is a dark green, often with moss and vines taking root on their back. Any who get too close also get overwhelmed with an unbearable rotting stench \n\nThey are entirely carnivorous and have long sharp teeth which they use to consume anything that wanders into their domain. Notably, they are much wilder than other unhold species."
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

