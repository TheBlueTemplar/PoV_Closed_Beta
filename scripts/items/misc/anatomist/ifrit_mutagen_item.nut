this.ifrit_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.ifrit_mutagen";
		this.m.Name = "Ifrit Mutagen";
		this.m.Description = "This potent mutagen rewrites the vatt'ghern's physiology, transforming their flesh into a hardened, stone-like texture that provides extraordinary resilience. With natural armor shielding them from harm and a remarkable reduction in incoming damage, they become a living fortress on the battlefield.\n\n However, such unyielding strength comes at a steep cost—their movements grow sluggish, their reflexes dulled, and their stamina drained more quickly. Fatigue recovery slows, and every action becomes more taxing. It is a gift of unparalleled durability, but one that demands the vatt'ghern to carefully weigh power against agility and endurance.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_ifrit.png";
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
		this.Sound.play("sounds/enemies/dlc6/sand_golem_disassemble_03.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc6/sand_golem_disassemble_04.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.ifrit_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/ifrit_mutagen_effect"));
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySchrat].Script));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemySchrat, 3, false);
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});


	