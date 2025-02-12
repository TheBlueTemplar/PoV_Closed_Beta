this.ghoul_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.ghoul_mutagen";
		this.m.Name = "Nachzehrer Mutagen";
		this.m.Description = "This vile mutagen carries the essence of a ghoul\'s feral hunger and twisted vitality. Once consumed, it sharpens the user\'s reflexes to an unnatural degree, granting them incredible speed and an unsettling presence that saps the courage of nearby foes.\n\nHowever, the mutation also exacts a grim toll: precision with ranged weapons is lost entirely, melee strikes become weaker, and the body grows disturbingly fragile, unable to endure punishment as it once could. Those who embrace the ghoul\'s curse become swift predators, but their newfound agility comes at a steep price.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_ghoul.png";
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
		
		this.Sound.play("sounds/combat/drink_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_grows_02.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/ghoul_hurt_04.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.nachzehrer_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/nachzehrer_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});

