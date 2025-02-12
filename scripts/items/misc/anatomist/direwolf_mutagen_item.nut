this.direwolf_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.direwolf_mutagen";
		this.m.Name = "Beast Mutagen";
		this.m.Description = "The Beast Mutagen embodies the primal essence of wild predators, enhancing agility and resilience at the cost of discipline and heavy protection. Those infused with this mutagen experience greatly reduced fatigue when moving or using skills, allowing them to fight with unrelenting ferocity.\n\n Their predatory instincts shine in the dark, as they suffer only minor hindrances from nighttime combat. Additionally, the mutagen fortifies their bodies, rendering them immune to bleeding wounds.\n\n However, this primal power comes with a drawback: the cumbersome weight of armor becomes even more exhausting, forcing the user to rely on speed and instinct rather than heavy defenses. A perfect choice for those who embrace their inner beast.";
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
		this.Sound.play("sounds/combat/drink_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/werewolf_hurt_02.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/werewolf_idle_14.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.direwolf_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/direwolf_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});