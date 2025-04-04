this.pov_unhold_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_unhold_mutagen";
		this.m.Name = "Unhold Mutagen";
		this.m.Description = "This mutagen, The Unhold Mutation grants the character an incredible vitality, with wounds healing almost instantly in battle due to hyperactive cell growth, and vastly increased hitpoints.\n\nHowever, this rapid regeneration comes at a cost—while the body focuses on recovery, it weakens the character's offensive power, making their attacks progressively weaker as they take more damage.\n\nAdditionally, the mutation significantly increases the character’s appetite, as the accelerated metabolism demands more food than usual. While they don't mind the extra rations, caution is advised, especially when mead is involved!";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_unhold.png";
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_unhold_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Unhold);
		}

	}

});

