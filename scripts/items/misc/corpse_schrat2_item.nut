this.corpse_schrat2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_schrat2";
		this.m.Name = "Greenwood Schrat Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This outer layers of the schrat corpse are very similar to ordinary wood.  On the inside, there are components that similar to organs.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_schrat2.png";
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
				image = "consumables/enemy_schrat2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The greenwood schrat is the living heart of the forest.  They are nearly immortal and can only be killed by extreme trauma.  Usually very calm and peaceful, they have been growing increasingly agressive in recent years to anyone entering their forests.\n\nAny damage done to them will result in immediate growth smaller clones from the removed wood chips and sap."
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

