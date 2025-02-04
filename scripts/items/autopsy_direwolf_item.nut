this.autopsy_direwolf_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.autopsy_direwolf_item";
		this.m.Name = "Direwolf Autopsy";
		this.m.Description = "Removing pelt, extract adrenal gland; a skilled brother may attempt to extract useful items from this nachzehrer corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/autopsy_direwolf.png";
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
				image = this.getIconLarge(),
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
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] pelt.\n[color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] adrenal gland.\n[color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] meat."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] sabertooth.\n[color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] beast mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance."
		});
		
		return result;
		
	}

	

	

});