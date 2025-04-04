this.pov_corpse_unhold4_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_unhold4";
		this.m.Name = "Rock Unhold Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "Although indistinguishable from a pile of ordinary rocks, this unhold corpse is still in fairly good condition.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/enemy_unhold.png";
		this.m.Icon = "consumables/pov_corpse_unhold4.png";
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
				image = "consumables/pov_enemy_unhold4.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The rock unhold is by far the toughest of all the unholds.  They prefer to live in rocky, mountain regions.  Their skin is often the color and texture of the areas they inhabit, which can make them very difficult to spot.\n\nTheir ability regenerate from any wound is even better than other unhold varieties."
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

