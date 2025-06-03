this.pov_corpse_demonhound_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_demonhound";
		this.m.Name = "Hollenhund Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The magic fire that burned on this demon hound has been extinguished.  It now appears to be the bones of a regular hound.\n\nThere are skill some residual energies remaining in the bones of these bones.  A skilled medicus may be able to extract something from it.";
		this.m.Icon = "consumables/pov_corpse_demonhound.png";
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
				image = "consumables/pov_enemy_demonhound.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The hellhound are the guardians of the underworld.  They can be found in the presence of other undead creatures\n\nThey are similar to geist in that they can teleport away when injured."
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

