this.pov_autopsy_flesh_golem_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_autopsy_flesh_golem";
		this.m.Name = "Flesh Golem Autopsy";
		this.m.Description = "Attempt to extract useful items from the flesh golem\'s remains.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_autopsy_flesh_golem.png";
		this.m.Value = 380;
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
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] Grafted Flesh.\n[color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] Ivory Spine Shard.\n[color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] chance."
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/pov_extra_special.png",
			text = "Acquire [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] Rot Essence.\n[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] chance."
		});

		return result;

	}





});