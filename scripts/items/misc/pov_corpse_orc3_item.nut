this.pov_corpse_orc3_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_orc3";
		this.m.Name = "Orc Elder Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This brutish corpse is still in fairly good condition.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_orc3.png";
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
				image = "consumables/pov_enemy_orc3.png",
		});


		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = " The orc elder is a giant even among other orcs.  Unlike humans, who get frail with advanced age, orcs just continue to get larger and stronger.  However, due to their agressive nature, very few live long enough to reach this size, as they are just as likely to kill each other and be killed in battle.\n\nOrcs of this size have eithr earned the title of warlord or behemoth."
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

