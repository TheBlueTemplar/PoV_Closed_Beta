this.pov_corpse_skeleton_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.pov_corpse_skeleton";
		this.m.Name = "Skeleton Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "After removing the armor from this skeleton corpse, you find nothing but bones.  There is no flesh, muscle or tendon.  It was obviously animated by some evil magic.\n\nThere are skill some residual energies remaining in the bones of this skeleton.  Someone skilled may be able to extract something from it.";
		this.m.Icon = "consumables/pov_corpse_skeleton1.png";
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
				image = "consumables/pov_enemy_skeleton.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The skeleton legions roam the deserts of the south.  Even with the decayed state of their bodies and equipment they are a formidable force.  In life, their empire might have conquered the world.\n\nIn battle, they do not fatigue, require no food and suffer no loss of morale."
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

