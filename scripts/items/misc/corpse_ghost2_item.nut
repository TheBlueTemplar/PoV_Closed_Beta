this.corpse_ghost2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_shost2";
		this.m.Name = "Cold Ectoplasm";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This vial of slime is all that remains of the winselmutter.  The vial is so cold to the touch that ice crystals form on the outside of it.  Over time it will eventually dissipate.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_ghost2.png";
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
				image = "consumables/enemy_ghost2.png",
		});

		
		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The winselmutter is a supernatural entity, usually of a woman to was betrayed and murdered.  Similar to a geist, they return to haunt this world.\n\nAnyone who faces one will have their resolve tested.  Their scream is so horrific, that it can easily paralyze an opponent with fear."
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

