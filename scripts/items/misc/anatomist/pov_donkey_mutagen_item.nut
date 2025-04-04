this.pov_donkey_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	// "Touch The Alps, they like it!"
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_donkey_mutagen";
		this.m.Name = "Mutagen: Donkey";
		this.m.Description = "What...even is this...?";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_donkey.png";
		this.m.Value = 750;
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
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Must have Witcher Mutation and not already used this mutagen."
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
		this.Sound.play("sounds/misc/donkey_hurt_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/misc/donkey_idle_01.wav", this.Const.Sound.Volume.Inventory);

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_donkey_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Donkey);
		}



	}

});

