this.goblin_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.goblin_mutagen_item";
		this.m.Name = "Goblin Mutagen";
		this.m.Description = "This mutagen reshapes the body into a wiry, quick-footed form, enhancing agility and sharpshooting prowess while sapping resilience. Movement becomes swift and efficient, making complex maneuvers feel effortless, while ranged attacks strike with uncanny precision, often slipping through gaps in an enemy’s guard. Even careful, methodical shots require less time to execute, making them deadlier in skilled hands.\n\nHowever, the body grows frail, struggling to withstand direct blows, and the mind becomes more prone to panic under pressure. Heavier armor feels especially cumbersome, draining stamina far faster than usual, forcing reliance on speed, positioning, and ambush tactics to survive.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_goblin.png";
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

		
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
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
		this.Sound.play("sounds/enemies/goblin_idle_08.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/goblin_flee_01.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.goblin_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/goblin_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
	}

});

