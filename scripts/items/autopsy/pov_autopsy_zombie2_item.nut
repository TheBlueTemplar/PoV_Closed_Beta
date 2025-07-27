this.pov_autopsy_zombie2_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_zombie2_item";
		this.m.Name = "Wiederganger Knight Autopsy";
		this.m.Description = "The autopsy is more a process of prying apart the fused armor.  On the inside you find mostly puss and worms.  During this gruesome process you have an uneasy feeling that you are being watched.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_zombie2.png";
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
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] large red worm.\n[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] chance."
		});

		return result;

	}





});