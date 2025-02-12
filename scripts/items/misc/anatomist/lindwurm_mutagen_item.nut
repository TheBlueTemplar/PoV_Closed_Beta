this.lindwurm_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.lindwurm_mutagen";
		this.m.Name = "Lindwurm Mutagen";
		this.m.Description = "Infused with the volatile essence of the Lindwurm, this mutagen transforms its bearer into a devastating force on the battlefield. Their blood burns with potent acid, searing the armor of attackers who dare strike them. Immune to acid themselves, they become relentless armor-breakers, tearing through defenses with enhanced effectiveness.\n\n However, the mutation comes with significant drawbacks: their wounds heal more slowly, melee defense is reduced, and their increased wages reflect the high cost of maintaining such a destructive force. A formidable choice for those who prioritize overwhelming offense over endurance.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_lindwurm.png";
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

		

		
		result.push({
			id = 65,
			type = "hint",
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
		this.Sound.play("sounds/enemies/lindwurm_idle_02.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/lindwurm_hurt_01.wav", this.Const.Sound.Volume.Inventory);

	if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.lindwurm_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/lindwurm_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
	}

});

