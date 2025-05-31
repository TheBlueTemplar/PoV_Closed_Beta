this.pov_basilisk_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_basilisk_mutagen";
		this.m.Name = "Mutagen: Basilisk";
		this.m.Description = "This mutagen, obtained from the corpse of a basilisk, allows whomever drinks it to gain some of its powers.\n\n This mutation improves the Vatt\'ghern\'s ability to strike an opponent\'s head, and inflict more damage to it. \n\n The Vatt\'ghern also gets a stamina regeneration effect when striking a headshot, and also gains the Glare skill, a medium range attack, which [color=" + this.Const.UI.Color.NegativeValue + "]Paralyzes[/color] an enemy. \n\n This mutation also has some side effects, with signs showing an increaded demand of stamina for any action, due to the increased focus of the Vatt\'ghern, while also reducing the damage output on an enemy\'s body";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_basilisk.png";
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_basilisk_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Basilisk);
		}



	}

});

