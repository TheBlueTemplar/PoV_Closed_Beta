this.necrosavant_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.necrosavant_mutagen";
		this.m.Name = "Potion of the Nightstalker";
		this.m.Description = "This mutagen, obtained from the corpse of a Necrosavant, allows whomever drinks it to gain some of their powers.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_vampire.png";
		this.m.Value = 3250;
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
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
		});
		return result;
	}

	function onUse( _actor, _item = null )
	{
		
		
		
		
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.necrosavant_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyVampire, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyVampire].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});

