this.corpse_alp2_item <- this.inherit("scripts/items/supplies/food_item", {
	m = {},
	function create()
	{
		this.food_item.create();
		this.m.ID = "supplies.corpse_alp2";
		this.m.Name = "Demon Alp Corpse";
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Description = "This corpse is still in fairly good condition.  Alchemists will pay a lot of gold for intact alp organs.\n\nSomeone skilled may be able to extract useful materials from it.";
		this.m.Icon = "consumables/corpse_alp2.png";
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
				image = "consumables/enemy_alp2.png",
		});

		result.push({
			id = 11,
			type = "text",
			//icon = "ui/icons/special.png",
			text = "The demon alp is the king of nightmares. It is much stronger than a normal alp and has large horns grownig out of every part of its body.\n\nIt only appears in this world at night and feeds on the fear of its victims."
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

