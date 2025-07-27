this.pov_autopsy_vampire_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_vampire_item";
		this.m.Name = "Necrosavant Autopsy";
		this.m.Description = "Carefully gather dust, attempt to isolate organic fragments; a skilled brother may attempt to extract useful items from this necrosavant corpse.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_vampire.png";
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
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] vampire dust.\n[color=" + this.Const.UI.Color.PositiveValue + "]35%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/scroll_01.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] ancient scroll.\n[color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] vampire mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance."
		});

		return result;

	}





});