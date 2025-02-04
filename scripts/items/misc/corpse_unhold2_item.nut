this.corpse_unhold2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_unhold2";
		this.m.Name = "Frost Unhold Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.IconLarge = "consumables/enemy_unhold.png";
		this.m.Icon = "consumables/corpse_unhold2.png";
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
				image = "consumables/enemy_unhold2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The frost unhold is a very large, and very stong creature.  This variety prefers to live in the snowy mountains of the North.  They are below average intelligence and very territorial.  The are often found alone, but on occation can be found in small groups.\n\nThe most notible trait of an unhold is its ability to rapidly regenerate from any wound inflicted upon it."
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

