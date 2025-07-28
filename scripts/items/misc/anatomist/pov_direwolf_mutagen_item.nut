this.pov_direwolf_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_direwolf_mutagen";
		this.m.Name = "Beast Mutagen";
		this.m.Description = "The Beast Mutagen embodies the primal essence of wild predators, enhancing agility and resilience at the cost of discipline and heavy protection. Those infused with this mutagen experience greatly reduced fatigue when moving or using skills, allowing them to fight with unrelenting ferocity.\n\n Their predatory instincts shine in the dark, as they suffer only minor hindrances from nighttime combat. Additionally, the mutagen fortifies their bodies, rendering them immune to bleeding wounds.\n\n However, this primal power comes with a drawback: the cumbersome weight of armor becomes even more exhausting, forcing the user to rely on speed and instinct rather than heavy defenses. A perfect choice for those who embrace their inner beast.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_direwolf.png";
		this.m.Value = 400;
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
			text = "Mutates the body, causing severe sickness"
		});

		result.push({
			id = 65,
			type = "text",
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_direwolf_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Direwolf);
		}

	}

});