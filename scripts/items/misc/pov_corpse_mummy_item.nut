this.pov_corpse_mummy_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_mummy";
		this.m.Name = "Enbalmed Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The head of this embalmed appears to be partially intact.  The rest of the body crumbled to dust.\n\nWhile there is no danger of this corpse decomposing, the residual energies left by the curse that animated it will soon dissipate.  Someone knowledgable in arcane arts (potion brewing) might be able to figure out how this curse worked.";
		this.m.Icon = "consumables/pov_corpse_mummy.png";
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
				image = "consumables/pov_enemy_mummy.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The enbalmed skeletons wrapped in dessicated flesh and ancient cloth in some kind of a bizzare ceremonial process.  There is no fluid left in the body, so it is likely animated by the same curse as the skeleton legions, though in this case, this bizzare magic seems to be more potent in them, retaining more of their past combat skill.\n\n Interestingly, they seem to be far more deadly and efficient against those who slay lots of their kind, making their curse deadly for everyone involved \n\nAs it fell to the ground, most of the body disintigrated into dust."
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

