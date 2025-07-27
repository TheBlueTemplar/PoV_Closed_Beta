this.pov_corpse_lindwurm2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_lindwurm2";
		this.m.Name = "Stollwurm Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "Bones, blood and skin.  Every part of the stollwurm is very valuable.  It is also exceptionally rare as few of these beasts are ever defeated.\n\nA skilled medicus may be able to extract useful materials from it.";
		this.m.Icon = "consumables/pov_corpse_lindwurm2.png";
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
				image = "consumables/pov_enemy_lindwurm2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The legendary stollwurm is a even more powerful variant of the lindwurm dragon.  There are no known accounts of one being defeated, as this gigantic wurm can easily defeat entire armies.\n\nIt is darker in color and has a great afinity for the earth.  If you feel an earthquake, it might be that a stollwurm is near.  It has the ability to pass through the ground as quickly as if were on land."
		});

		result.push({
			id = 67,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Will spoil in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getSpoilInDays() + "[/color] days."
		});


		return result;

	}

	function isAmountShown()
	{
		return false;
	}



});

