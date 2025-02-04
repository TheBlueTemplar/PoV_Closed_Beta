this.direwolf_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.direwolf_mutagen";
		this.m.Name = "Beast Mutagen";
		this.m.Description = "This mutagen, obtained from the corpse of a Beast, allows whomever drinks it to gain some of their powers.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_direwolf.png";
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
		
		
		
		
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.direwolf_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/direwolf_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});