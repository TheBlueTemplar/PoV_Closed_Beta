this.pov_corpse_orc2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_orc2";
		this.m.Name = "Orc Adult Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_orc2.png";
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
				image = "consumables/pov_enemy_orc2.png",
		});


		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "An adult orc is larger and stronger than a young orc.  Their darker and thicker skin is covered in scars from engaging in constant battles.  Large tusks protrude from their lower jar.\n\nOrcs that have survived to adulthood fall into either the warrior or berserker caste.  Both are equally deadly."
		});
		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Will spoil in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});


		return result;

	}

	function isAmountShown()
	{
		return false;
	}



});

