this.pov_ghost_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_ghost_mutagen";
		this.m.Name = "Spirit Mutagen";
		this.m.Description = "Infused with the eerie essence of the otherworldly Geists, this mutagen imbues its bearer with a chilling aura of dread and supernatural power. The recipient gains the [color=" + this.Const.UI.Color.PositiveValue + "]Fearsome[/color] perk, overwhelming enemies with terror and breaking their resolve—or, if already Fearsome, their own Resolve is bolstered further, allowing them to remain steadfast even in the face of the gravest horrors.\n\n Their strikes gain spectral precision, penetrating armor with ease, aided by a flat bonus to armor penetration. However, this haunting power comes at a price: direct damage to armor is significantly reduced, forcing the bearer to bypass defenses rather than destroy them outright. An ideal choice for those who wish to instill fear and exploit vulnerability in their foes.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_ghost.png";
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
			rsult.push({
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
		return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Ghost);
	}

});

//Geist does not have a favored enemy perk
//...and I couldn't care less xd