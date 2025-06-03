this.pov_corpse_vampire_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_vampire";
		this.m.Name = "Necrosavant Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The moment this necrosavant was slain, it burst into flames and fell to the ground in a heap of ash and bone.  There are slight traces of organic matter still intact.\n\nSomeone skilled in alchemy may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_vampire.png";
		this.m.Value = 50;
		this.m.Amount = 50.0;
		this.m.GoodForDays = 20;
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
				image = "consumables/pov_enemy_vampire.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The necrosavant is an entity that preys upon the living, drinking their blood, to sustain themselves.  As long as they can feed, they are essentially immortal.\n\nTheir appearance can vary, passing as human when fully fed, to a dessicated corpse when starved."
		});
		
		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Energies will dissipate in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});
		
		
		return result;
		
	}

	function isAmountShown()
	{
		return false;
	}

	

});

