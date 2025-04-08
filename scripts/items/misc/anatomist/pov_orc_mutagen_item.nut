this.pov_orc_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_orc_mutagen";
		this.m.Name = "Mutagen: Orc";
		this.m.Description = "This brutish mutagen infuses the vatt'ghern with the primal strength and ferocity of the orcish horde. The transformation grants the ability to wield heavy orc weapons without succumbing to fatigue and enables a devastating charge that can stun foes. The user\'s attacks are also more powerful.\n\nHowever, this raw power comes at the expense of finesse—ranged attacks become harder to avoid, and the chaos of battle leaves them increasingly exposed to melee strikes when surrounded. A gift of unrelenting aggression, but one that demands careful positioning to unleash its full potential.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_orc.png";
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_orc_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Orc);
		}
	}

});
