this.corpse_orc_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_orc";
		this.m.Name = "Orc Young Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_orc.png";
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
				image = "consumables/enemy_orc.png",
		});

		
		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "Orc young are already as bulky and muscled as the strongest of humans and possess increasible endurance and ferocity.  Groups of orc young can often be found raiding villages.  As a rite of initiation, young orcs are sent out to either kill or be killed.\n\nFighting a group of orcs is similar to fighting a herd of charging bulls.  A preferred tactic is to slam into opponents at full speed to stun them."
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

