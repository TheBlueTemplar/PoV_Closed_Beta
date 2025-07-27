this.pov_undead_alpha_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.pov_undead_alpha_item";
		this.m.Name = "Large Red Worm";
		this.m.Description = "This strange worm was extracted from a wiederganger corpse.  It is too small to be usable on its own. If more can be collected, you may have enough to extract its essence.  When you look at it, you are overcome with a feeling of dread.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_undead_alpha.png";
		this.m.Value = 150;
		this.m.IsUsable = false;
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



		return result;

	}





});