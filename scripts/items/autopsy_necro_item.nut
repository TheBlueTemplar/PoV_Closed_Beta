this.autopsy_necro_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.autopsy_necro_item";
		this.m.Name = "Necromancer Autopsy";
		this.m.Description = "The flesh is riddled with worms you glimpse a larger red worm among them, but an overwhelming feeling of dread causes you to look away.  Perhaps you can extract it in one piece for further study.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/autopsy_necro.png";
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
			icon = "ui/icons/mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] large red worm.\n[color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		
		return result;
		
	}

	

	

});