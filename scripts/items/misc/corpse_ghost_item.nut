this.corpse_ghost_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_shost";
		this.m.Name = "Ectoplasm";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This vial of slime is all that remains of the geist.  The vial is cold to the touch and vibrates with a low energy.  Over time it will eventually dissipate.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_ghost.png";
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
				image = "consumables/enemy_ghost.png",
		});

		
		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = " The geist is a supernatural entity that does not fully exist in this world.  This allows it to pass through solid objects and attacks against it have little to make contact with.\n\nIt is drawn to the undead and can often be found in battles against them."
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

