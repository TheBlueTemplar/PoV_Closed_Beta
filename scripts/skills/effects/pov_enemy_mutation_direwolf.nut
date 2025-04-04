this.pov_enemy_mutation_direwolf <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_direwolf";
		this.m.Name = "[color=#034207] Beastly Endurance [/color]";
		this.m.Description = "This enemy has some properties of a Direwolf! They show vastly increased stamina in battle, as well as increased night vision, but are more hindered by armor.";
		this.m.Icon = "skills/pov_direwolf_mutant.png";
		this.m.IconMini = "pov_mini_direwolf_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They show vastly increased stamina in battle, as well as increased night vision, but are more hindered by armor.";
	}

	function getPenalty()
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}

		local armorFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Body);
		local helmetFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Head);
		local totalPen = armorFatPen + helmetFatPen;
		local penalty = totalPen * 0.30;
		return penalty;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Movement costs [color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] less Fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Skills cost [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] less fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_time_of_day.png",
				text = "Nighttime penalties are [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color]."
			},
			/*{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to bleeding effects."
			},*/
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The fatigue and initiative penalty from wearing armor is increased by [color=" + this.Const.UI.Color.NegativeValue + "]30%[/color]."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.MovementFatigueCostMult *= 0.6;
		_properties.FatigueEffectMult *= 0.85;
		//_properties.IsImmuneToBleeding = true; // Too Op On Light Enemies
		if (this.getContainer().hasSkill("special.night") && _properties.IsAffectedByNight)
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
		}
		// Debuffs
		_properties.Stamina += this.getPenalty();
		_properties.Initiative += this.getPenalty();
	}

});
