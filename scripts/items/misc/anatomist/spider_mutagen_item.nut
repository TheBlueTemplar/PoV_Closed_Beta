this.spider_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.spider_mutagen";
		this.m.Name = "Spider Mutagen";
		this.m.Description = "This mutagen reshapes the body into a venomous predator, making every strike drip with toxic potency. The user becomes immune to poison, their altered physiology thriving where others would falter. Every attack delivers a dose of venom, sapping the strength and reflexes of their foes, leaving them sluggish and vulnerable.\n\nAgainst already poisoned enemies, their strikes land with enhanced lethality, rewarding patience and persistence in combat. However, their reliance on venom comes at a cost—against untainted foes, their blows lack the same raw power, forcing them to either adapt or ensure their prey is always envenomed.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_spider.png";
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
		this.Sound.play("sounds/enemies/dlc2/giant_spider_hurt_06.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/giant_spider_death_04.wav", this.Const.Sound.Volume.Inventory);

		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.spider_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/spider_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemySpider, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySpider].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}

	}

});

