this.pov_autopsy_orc1_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_orc1_item";
		this.m.Name = "Orc Young Autopsy";
		this.m.Description = "There is suprisingly little value in the organs of this young orc.  However, an anatomist or surgeon can still attempt to extract something useful from it.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_orc1.png";
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
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = " Acquire orc mutagen [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance."
		});

		return result;

	}





});