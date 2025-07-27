this.pov_autopsy_vampire2_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_vampire2_item";
		this.m.Name = "Necrosavant Lord Autopsy";
		this.m.Description = "An anatomist or an alchemist might be able to extract some useful material from the remains of this necrosavant.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_vampire2.png";
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
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] vampire dust.\n[color=" + this.Const.UI.Color.PositiveValue + "]55%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/scroll_01.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] ancient scroll.\n[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/pov_mutagen_shard_icon.png",
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] necrosavant mutagen.\n[color=" + this.Const.UI.Color.PositiveValue + "]30%[/color] chance."
		});

		return result;

	}





});