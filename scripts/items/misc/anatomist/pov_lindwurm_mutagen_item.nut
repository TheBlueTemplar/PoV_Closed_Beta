this.pov_lindwurm_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_lindwurm_mutagen";
		this.m.Name = "Lindwurm Mutagen";
		this.m.Description = "Infused with the volatile essence of the Lindwurm, this mutagen transforms its bearer into a devastating force on the battlefield. Their blood burns with potent acid, searing the armor of attackers who dare strike them, and giving them the option to coat their own weapons with it. Immune to acid themselves, they become relentless armor-breakers, tearing through defenses with enhanced effectiveness.\n\n However, the mutation comes with significant drawbacks: their wounds heal more slowly, their defense in melee is reduced, and their increased faith in their abilities leads to constant demand of higher pay. A truly devastating mutation, if applied properly and with care.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_lindwurm.png";
		this.m.Value = 600;
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
		return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Lindwurm);
	}

});

