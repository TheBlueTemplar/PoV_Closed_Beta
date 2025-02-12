this.schrat_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.schrat_mutagen";
		this.m.Name = "Elemental Mutagen";
		this.m.Description = "This mutagen reshapes the body into a form of unyielding resilience, reinforcing the flesh with a hardened, bark-like exterior. The skin stiffens into a natural armor, dulling the force of incoming blows and granting an almost immovable stance—no push, pull, or force can shift them against their will.\n\n When bearing a shield, this fortitude is further amplified, making them an unbreakable wall against attacks. However, the weight of their altered frame burdens their movements, sapping their stamina with each step.\n\nWorse still, the very mutation that grants them durability leaves them tragically susceptible to fire, as their transformed flesh ignites with terrifying ease. Without a shield to balance their reinforced body, they become noticeably sluggish, their defenses faltering when exposed to direct strikes.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_schrat.png";
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
		this.Sound.play("sounds/enemies/dlc2/schrat_regrowth_02.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/dlc2/schrat_idle_09.wav", this.Const.Sound.Volume.Inventory);
		
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.schrat_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/schrat_mutagen_effect"));
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySchrat].Script));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemySchrat, 3, false);
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});


	