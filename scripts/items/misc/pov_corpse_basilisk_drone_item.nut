this.pov_corpse_basilisk_drone_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_basilisk_drone";
		this.m.Name = "Basilisk Drone Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_basilisk_drone.png";
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
				image = "consumables/pov_enemy_basilisk_drone.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Basilisk is a cruel joke of nature, a beast that mocks the world with the shape not much different from a chicken but the malice of something far worse.\n\n Its feathers are as hard as lamellar, its eyes gleam with vile cunning, and its jagged beak strikes with the precision of a huntsman’s arrow on the poor pray's head.\n\n While not as big and intimindating as larger basilisk, its lethality should never be underestimated. "
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

