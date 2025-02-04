this.autopsy_orc3_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.autopsy_orc3_item";
		this.m.Name = "Orc Elder Autopsy";
		this.m.Description = "This orc elder is even larger and more developed than an adult orc.  An anatomist or surgeon has a better chance to extract a mutagen from it.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/autopsy_orc3.png";
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
			text = " Acquire orc mutagen [color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		
		return result;
		
	}

	

	

});