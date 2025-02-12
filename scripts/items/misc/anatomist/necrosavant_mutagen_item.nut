this.necrosavant_mutagen_item <- this.inherit("scripts/items/misc/anatomist/anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.anatomist2_potion_item.create();
		this.m.ID = "misc.necrosavant_mutagen";
		this.m.Name = "Potion of the Nightstalker";
		this.m.Description = "This mutagen pulses with the dark vitality of a necrosavant, binding the bearer to the eternal embrace of night. Under the cover of darkness, they transform into a relentless predator, their strength, speed, and reflexes sharpened by the shadows. Injuries become fleeting as the bearer draws vitality from the blood of their enemies, healing themselves with every strike against those who bleed. The night no longer holds any mysteries or hindrances, becoming their ultimate domain.\n\nHowever, this power is a double-edged sword. The bright light of day weakens them, dulling their senses and sapping their combat prowess, as if the sun itself conspired to drain their vitality. A gift of dark potency, this mutagen is ideal for those who thrive in the obscurity of night, but its curse ensures they must tread carefully under the unforgiving gaze of daylight.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_vampire.png";
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
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing sickness"
		});
		return result;
	}

	function onUse( _actor, _item = null )
	{
		
		this.Sound.play("sounds/combat/drink_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_landing_01.wav", this.Const.Sound.Volume.Inventory);
		this.Sound.play("sounds/enemies/vampire_life_drain_03.wav", this.Const.Sound.Volume.Inventory);
		
		if (_actor.getSkills().hasSkill("trait.witcher") && !_actor.getSkills().hasSkill("effects.necrosavant_mutagen"))
		{
			_actor.getSkills().add(this.new("scripts/skills/effects/necrosavant_mutagen_effect"));
			//_actor.getBackground().addPerk(::Const.Perks.PerkDefs.LegendFavouredEnemyVampire, 3, false);
			//_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyVampire].Script));
			return this.anatomist2_potion_item.onUse(_actor, _item);
		}
		
		
		
	}

});

