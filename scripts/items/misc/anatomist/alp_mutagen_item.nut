this.alp_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	// "Touch The Alps, they like it!"
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.alp_mutagen";
		this.m.Name = "Mutagen: Alp";
		this.m.Description = "This mutagen awakens a supernatural awareness, granting the user an eerie clarity in darkness. Night holds no secrets from their gaze, and their altered eyes pierce through the gloom with unnatural precision.\n\nThey develop a mysterious Third Eye, enhancing their perception beyond mortal limits, allowing them to detect threats others would overlook. Their body, too, adapts to the realm of nightmares, resisting the suffocating grasp of toxic mists and foul vapors.\n\nHowever, this transformation comes at a cost—learning slows, as if trapped in a waking dream, and the body's endurance wanes, making it harder to shake off exhaustion.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_alp.png";
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
		this.Sound.play("sounds/enemies/dlc2/alp_idle_03.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.alp_mutagen"))
		{
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyAlps, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyAlps].Script));
			_actor.getSkills().add(this.new("scripts/skills/effects/alp_mutagen_effect"));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});

