this.pov_sandgolem_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_sandgolem_mutagen";
		this.m.Name = "Ifrit Mutagen";
		this.m.Description = "This potent mutagen rewrites the vatt'ghern's physiology, transforming their flesh into a hardened, stone-like texture that provides extraordinary resilience. With natural armor shielding them from harm and a remarkable reduction in incoming damage, they become a living fortress on the battlefield.\n\n However, such unyielding strength comes at a steep cost—their movements grow sluggish, their reflexes dulled, and their stamina drained more quickly. Fatigue recovery slows, and every action becomes more taxing. It is a gift of unparalleled durability, but one that demands the vatt'ghern to carefully weigh power against agility and endurance.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_ifrit.png";
		this.m.Value = 500;
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
		return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Sandgolem);
	}

});


