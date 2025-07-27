this.pov_autopsy_demonhound_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_demonhound_item";
		this.m.Name = "Hellhound Autopsy";
		this.m.Description = "There are residual energies residing within these bones.; a skilled brother may attempt to extract useful items from this hollenhund corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_demonhound.png";
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
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] bones.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] spirit mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] chance."
		});
		
		return result;
		
	}

	

	

});