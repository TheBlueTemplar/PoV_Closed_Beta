this.strain_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.strain_mutagen";
		this.m.Name = "Wiederganger Mutagen";
		this.m.Description = "This vile mutagen originates from the corrupted essence of weidergangers, infecting the vatt'ghern with a twisted blend of resilience and despair.\n\n The mutation strengthens the body, accelerating experience gain, preventing fatigue from enemy blows, and drastically increasing the threshold for sustaining injuries. \n\n Yet, such unnatural vigor comes at a heavy cost. The infected suffer relentless and haunting visions, eroding their resolve and leaving them vulnerable to fear and doubt. A double-edged gift indeed.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_strain.png";
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
		this.Sound.play("sounds/humans/0/human_flee_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/zombie_bite_04.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.strain_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/strain_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyZombie, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyZombie].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});
