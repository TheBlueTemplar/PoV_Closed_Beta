this.pov_corpse_schrat_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_schrat";
		this.m.Name = "Schrat Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This outer layers of the schrat corpse are very similar to ordinary wood.  On the inside, there are components that similar to organs.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_schrat.png";
		this.m.Value = 50;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 30;
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
				image = "consumables/pov_enemy_schrat.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The schrat is a giant animate tree.  Their appearance is vaugly humanoid with long limbs and their skin has the appearance of tree bark.  They live mainly in forests and can be very agressive towards anyone who intrudes on their forests or harms anything within it.\n\nThe schrat can pummel foes with their limbs and send out roots to attack from a distance."
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

