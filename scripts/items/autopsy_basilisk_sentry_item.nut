this.autopsy_basilisk_sentry_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.autopsy_basilisk_sentry_item";
		this.m.Name = "Basilisk Sentry Autopsy";
		this.m.Description = "Attempt to extract useful items from this basilisk sentry corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/autopsy_basilisk_sentry.png";
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
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] basilisk eye.\n[color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] basilisk feathers.\n[color=" + this.Const.UI.Color.PositiveValue + "]60%[/color] chance."
		});
		
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] basilisk talon.\n[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] basilisk mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] chance."
		});
		
		return result;
		
	}

	

	

});