this.pov_corpse_necro_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_necro";
		this.m.Name = "Necromancer Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "Upon close examination, it is revealed that this human is actually infliced with the same plague as the wiederganger.  Other than the pale, waxy skin, it is in relatively good condition, and appears like it can last unnaturally long without rotting.\n\nOn the inside, this corpse is almost completely filled with worms.  There appears to be a larger red worm among them. A skilled medicus may be able to extract it.";
		this.m.Icon = "consumables/pov_corpse_necro.png";
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
				image = "consumables/pov_enemy_necro.png",
		});

		result.push({
			id = 11,
			type = "text",
			text = "This necromancer appears human, but he is not anymore.  Likely they fell victim to one of their own bizzare experiments and wicked magic.\n\nIt is mostly undecayed and possesses an extreme intelligence, able to control and strengthen the lesser wiederganger around it and endlessly reanimate them after they have fallen. \n\n Other weidergangers are naturally drawn to it, trying to shield it from any threat, and curiously, the source of the weiderganger curse seems much more dominant in them."
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

