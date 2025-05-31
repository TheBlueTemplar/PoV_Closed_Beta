this.pov_beautiful_potion_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_beautiful_potion";
		this.m.Name = "Handsome Potion";
		this.m.Description = "Makes you a beauty, that's cool!";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_beautiful.png";
		this.m.Value = 300;
		this.m.IsPrecious = false;
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
			type = "text",
			text = "\"Mutates the body\", making you a beauty, and sick."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/combat/pov_burp.wav", this.Const.Sound.Volume.Inventory);

		_actor.getSkills().add(this.new("scripts/skills/injury/pov_sickness2_injury"));
		
		return true;
	}

});

