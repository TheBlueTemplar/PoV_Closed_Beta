this.pov_spider_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_spider_mutagen";
		this.m.Name = "Spider Mutagen";
		this.m.Description = "This mutagen reshapes the body into a venomous predator, making every strike drip with toxic potency. The user becomes immune to poison, their altered physiology thriving where others would falter. Every attack delivers a dose of venom, sapping the strength and reflexes of their foes, leaving them sluggish and vulnerable.\n\nAgainst already poisoned enemies, their strikes land with enhanced lethality, rewarding patience and persistence in combat. However, their reliance on venom comes at a cost—against untainted foes, their blows lack the same raw power, forcing them to either adapt or ensure their prey is always envenomed.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_spider.png";
		this.m.Value = 400;
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

		if (_actor.getSkills().hasSkill("trait.pov_witcher") && !_actor.getSkills().hasSkill("effects.pov_spider_mutagen"))
		{
			return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Spider);
		}

	}

});

