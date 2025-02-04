this.corpse_mummy_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_mummy";
		this.m.Name = "Enbalmed Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The head of this embalmed appears to be partially intact.  The rest of the body crumbled to dust.\n\nWhile there is no danger of this corpse decomposing, the residual energies left by the curse that animated it will soon dissipate.  Someone knowledgable in arcane arts might be able to figure out how this curse worked.";
		this.m.Icon = "consumables/corpse_mummy.png";
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
				image = "consumables/enemy_mummy.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The enbalmed are little more than skeletons wrapped in dessicated flesh and ancient cloth.  There is no fluid left in the body, so it is likely animated by the same curse as the skeleton legions.\n\nAs it fell to the ground, most of the body disintigrated into dust."
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

