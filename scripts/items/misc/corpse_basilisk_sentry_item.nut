this.corpse_basilisk_sentry_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_basilisk_sentry";
		this.m.Name = "Basilisk Sentry Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_basilisk_sentry.png";
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
				image = "consumables/enemy_basilisk_sentry.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Sentry Basilisk stands apart from its frantic kin, a hulking terror that moves with grim purpose. Its feathers are like matted iron, and its beak, chipped and scarred from countless kills, strikes not with speed, but with bone-crushing force.\n\nIts venom drips from every strike, seeping into wounds to leave warriors writhing in agony long after the fight.\n\n  And then, there are its eyes—malevolent orbs that flare with an unnatural light, freezing those who meet its gaze in paralyzing dread. This 'glare' stops entire ranks in their tracks, leaving them helpless before its slow, methodical advance."
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

