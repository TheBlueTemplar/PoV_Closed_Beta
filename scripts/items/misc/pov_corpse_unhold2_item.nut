this.pov_corpse_unhold2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_unhold2";
		this.m.Name = "Frost Unhold Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/pov_enemy_unhold.png";
		this.m.Icon = "consumables/pov_corpse_unhold2.png";
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
				image = "consumables/pov_enemy_unhold2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The unhold is a very large, and very stong creature. While their intelligence is lacking, they are very agressive and territorial. \n\nUnholds are known to be able to crush entire battlelines by charging and throwing people around like they are nothing, but their most notorious trait is the ability to rapidly regenerate from any wound. \n\n This species is native to the north, and is much hardier than its souther counterparts. Rumors say that the barbarians of the north have even tamed some of these creatures..."
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

