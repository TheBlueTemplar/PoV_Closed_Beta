this.pov_corpse_serpent_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_serpent";
		this.m.Name = "Serpent Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  Merchants will pay a lot for intact skin and scales.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_serpent.png";
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
				image = "consumables/pov_enemy_serpent.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The giant serpent is easily in excess of 20 feet in length.  It lives in the sandy deserts of the south, but will rarely venture north in search of food.  They can move very quickly and can pull their victims in and trap them in their coils.\n\nThis very dangerous foe has hardend scales and its fangs drip with a potent venom"
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

