this.pov_corpse_sandgolem_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_sandgolem";
		this.m.Name = "Ifrit Remains";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This pile of sand and pebbles is what remains of the ifrit after it was destroyed in battle.  There are traces of a substance similar to what can sometimes be found upon destruction of a geist, however this seems to slowly dissipate with time.\n\nA close examination might reveal it hides some valuable materials inside.";
		this.m.Icon = "consumables/pov_corpse_ifrit.png";
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
				image = "consumables/pov_enemy_ifrit.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The Ifrit are the legendary living rocks of the southern desert.  They can rise up out of the sand and combine at will to form larger constructs.  They can also split apart again, hurling themselves at their prey.\n\nIfrit can grow to an enormous size, however they behave more like a swarm of smaller entities, rather than a single large one."
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

