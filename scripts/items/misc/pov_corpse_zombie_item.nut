this.pov_corpse_zombie_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_zombie";
		this.m.Name = "Wiederganger Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "It is rare to find a wiederganger corpse in a useable condition.  Many fall to pieces or are mosly piles of rotten flesh filled with worms.\n\nSomeone skilled may be able to extract useful materials from it.  However, already mostly decayed, it will not last much longer.";
		this.m.Icon = "consumables/pov_corpse_zombie.png";
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
				image = "consumables/pov_enemy_zombie.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The wiederganger was once a human.  It is unknown if its current condition was the result of some horrible disease, curse, or magical animation.  They seem to lack any kind of intelligence or free will.\n\nThey will attack endlessly and wounds that would kill a living human seem to not bother them.  Even more disturbing, they will continue to rise even after being killed."
		});
		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Will fully decompose in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});


		return result;

	}

	function isAmountShown()
	{
		return false;
	}



});

