this.pov_autopsy_zombie_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_zombie_item";
		this.m.Name = "Wiederganger Autopsy";
		this.m.Description = "Disecting a wiederganger is a disgusting process.  The smell is unbearable and it is unlikely you will find anything useful.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_zombie.png";
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
			text = " Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] large red worm.\n[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance."
		});

		return result;

	}





});