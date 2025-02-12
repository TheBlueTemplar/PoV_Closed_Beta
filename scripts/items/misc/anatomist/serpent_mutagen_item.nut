this.serpent_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.serpent_mutagen";
		this.m.Name = "Mutagen: Serpent";
		this.m.Description = "Suffused with the sly and lethal essence of serpents, this mutagen transforms its bearer into a master of precision and cunning on the battlefield. Each strike is calculated, benefiting from increased accuracy when allies surround the target, turning cooperation into a deadly advantage. The bearer’s agility is unmatched, recovering fatigue at an accelerated rate, enabling relentless combat and nimble repositioning. Additionally, their initiative fuels their defensive prowess, granting them both melee and ranged defense that scales with their speed.\n\nHowever, this serpentine gift is not without its drawbacks. The mutation demands a physical toll, reducing the bearer’s maximum health and increasing the damage they sustain from attacks. Furthermore, when cornered by multiple enemies, the bearer’s defenses falter, making them vulnerable in the midst of chaos. A double-edged boon, perfect for those who value precision and strategy over brute strength.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_serpent.png";
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
		this.Sound.play("sounds/enemies/dlc6/snake_hurt_02.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc6/snake_idle_13.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc6/snake_idle_04.wav", this.Const.Sound.Volume.Inventory);

		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.serpent_mutagen"))
		{
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyAlps, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyAlps].Script));
			_actor.getSkills().add(this.new("scripts/skills/effects/serpent_mutagen_effect"));
			//_actor.getSkills().add(this.new("scripts/skills/effects/serpentine_duellist_effect"));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});

