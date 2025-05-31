this.pov_witcher_potion_item_preview <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_witcher_potion_preview";
		this.m.Name = "Trial Of The Grasses";
		this.m.Description = "The Trial Of The Grasses is the pinnacle of what research on human anatomy has yielded. The few who know of its existence claim that to consume it and survive, is to ascend to a higher state of being, something beyond a mere human. But the process, is truly horrifying \n\n The poor fellow who consumes this potion will be put under the ultimate test, at risk of their own life. [color=" + this.Const.UI.Color.NegativeValue + "]Only the most healthy and battle hardened people are guaranteed to survive[/color]. Even after surviving, they will be extremely sick for many days \n\n [color=" + this.Const.UI.Color.NegativeValue + "]This process is also going to negatively impact the entire party's mood[/color], affected individually by each brother's bravery and resolve.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_vattghern_preview.png";
		this.m.Value = 3000;
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

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
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Heavily Mutates the body, causing severe sickness"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		// THIS IS ONLY FOR PREVIEW IN THE CRAFTING MENU!
	}
});


