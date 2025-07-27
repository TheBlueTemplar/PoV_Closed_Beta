this.pov_strain_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_strain_mutagen";
		this.m.Name = "Wiederganger Mutagen";
		this.m.Description = "This vile mutagen originates from the corrupted essence of weidergangers, infecting the vatt'ghern with a twisted blend of resilience and despair.\n\n The mutation strengthens the body, accelerating experience gain and drastically increasing the threshold for sustaining injuries, while also giving the user a very valuable and foul aura of rot, harming nearby enemies. \n\n Yet, such unnatural vigor comes at a heavy cost. Aside from an innate weakness to fire, the infected suffer relentless and haunting visions, eroding their resolve and leaving them vulnerable to fear and doubt. A double-edged gift indeed.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_strain.png";
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
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_strain_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Strain);
		}



	}

});
