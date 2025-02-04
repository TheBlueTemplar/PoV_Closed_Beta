this.corpse_spider2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_spider2";
		this.m.Name = "Redback Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  None of its vital organs have been destroyed.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_spider2.png";
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
				image = "consumables/enemy_spider2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "This redback webkecht is a rare variant that is extremely dealy.  Normally reclusive, they will immediatly attack if encountered.\n\nEven the largest of creatures know to flee when they see the red markings.  There venom is certain death for any who are exposed."
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

	function isAmountShown()
	{
		return false;
	}

	

});

