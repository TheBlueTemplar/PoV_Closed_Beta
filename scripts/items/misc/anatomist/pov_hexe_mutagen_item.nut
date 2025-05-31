this.pov_hexe_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_hexe_mutagen";
		this.m.Name = "Hexe Mutagen";
		this.m.Description = "This mutagen weaves an aura of unnatural charm and influence, subtly bending fate and fortune to the user’s favor. Their words carry a strange weight, making deals and bargains more favorable, while prospective recruits seem drawn to their presence, their hiring costs mysteriously lowered.\n\n A sinister luck follows them into battle, warping probability itself—foes may find their strikes inexplicably missing, as if some unseen force denies them a clean hit.\n\n However, this power comes at a price. The same eerie presence that twists fate also provokes unease, drawing enemy attention more than it should. Worse still, unseen forces stir around them, leading to unpredictable misfortunes that can manifest at the most inopportune moments.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_hexe.png";
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
			text = "Mutates the body, causing sickness."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Must have Witcher Mutation and not already used this mutagen."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Can have a maximum of [color=" + this.Const.UI.Color.NegativeValue + "]one[/color] brothers with this mutation in your party."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{

		local brothers = this.World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{
			if(bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
			{
				this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
				return;
			}
		}

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_hexe_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Hexe);
		}



	}

});

