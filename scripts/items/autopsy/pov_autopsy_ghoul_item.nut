this.pov_autopsy_ghoul_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_ghoul_item";
		this.m.Name = "Nachzehrer Autopsy";
		this.m.Description = "Removing horns, pulling teeth and extracting organs; a skilled brother may attempt to extract useful items from this nachzehrer corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_ghoul.png";
		this.m.Value = 300;
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
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] nachzehrer teeth.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] nachzehrer horn.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] nachzehrer brain.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] nachzehrer growth pearls.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] nachzehrer mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]8%[/color] chance."
		});

		return result;

	}





});