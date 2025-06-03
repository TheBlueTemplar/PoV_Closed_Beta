this.pov_corpse_zombie2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_zombie2";
		this.m.Name = "Wiederganger Knight Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The flesh of this wiederganger is fused into its armor.  This appears to have slowed the decay of its flesh, but the concentration of worms is much higher.\n\nA skilled medicus may be able to extract useful materials from it.  However, already mostly decayed, it will not last much longer.";
		this.m.Icon = "consumables/pov_corpse_zombie2.png";
		this.m.Value = 50;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 7;
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
				image = "consumables/pov_enemy_zombie2.png",
		});

		result.push({
			id = 11,
			type = "text",
			text = "The wiederganger knight has some limited control of its actions, although something else seems to be controlling it.  It also retains a large amount of its fighting skill.\n\nThe combination of attacking without regard for its own safety, and deadly weapons, makes this creature very dangerous."
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

