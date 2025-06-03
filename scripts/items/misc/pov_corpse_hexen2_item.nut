this.pov_corpse_hexen2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_hexen2";
		this.m.Name = "Coven Leader Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The coven leader is obiously not human. Every aspect of their appearance is demonic.  A skilled medicus may be able to extract useful materials from this corpse.";
		this.m.Icon = "consumables/pov_corpse_hexe2.png";
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
				image = "consumables/pov_enemy_hexe2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The coven leader is an ancient and powerful hexen.  While they meet infrequently and are solitary creatures, all hexen will follow a coven leaders commands without question.\n\nThey are much more adept in all forms of magic than other hexen, having proven themselves over many centuries."
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

