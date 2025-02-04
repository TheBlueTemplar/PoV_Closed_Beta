this.autopsy_unhold4_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.autopsy_unhold4_item";
		this.m.Name = "Rock Unhold Autopsy";
		this.m.Description = "Almost every part of this huge beast has value, from its skin to its bones; a skilled brother may attempt to extract useful items from this unhold corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/autopsy_unhold4.png";
		this.m.Value = 500;
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
		

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] strange meat."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] rock unhold bones.\n[color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] rock unhold hide.\n[color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] unhold heart.\n[color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] deformed valuables.\n[color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] unhold mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance."
		});
		
		return result;
		
	}

	

	

});