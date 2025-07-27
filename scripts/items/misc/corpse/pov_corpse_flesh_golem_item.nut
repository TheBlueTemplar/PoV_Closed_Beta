this.pov_corpse_flesh_golem_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_flesh_golem";
		this.m.Name = "Grafted Remains";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "The twisted corpse of a Flesh Golem — a grotesque mass of stitched limbs, mismatched torsos, and pulsing sinew. Even in death, the seams strain and twitch, as if the thing resents the idea of staying dead.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_flesh_golem.png";
		this.m.Value = 150;
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
				image = "consumables/pov_enemy_flesh_golem.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Flesh Golem is not born, nor truly reanimated. It is assembled — a grotesque construction of human parts, stolen from graves, battlefields, and butchered prisoners. Limbs are grafted to torsos that were never theirs. Heads are sewn on backwards. Eyes stitched shut. The creators of such monstrosities are believed to be rogue alchemists, exiled necromancers, or deranged anatomists driven beyond reason.\n\nThere are no records of one being made, only of them being found. But if such a thing walks, somewhere, someone has chosen to shape flesh into war."
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

