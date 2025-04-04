this.pov_enemy_mutation_ghoul <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_ghoul";
		this.m.Name = "[color=#034207] Ghoulish Visage [/color]";
		this.m.Description = "This enemy has some properties of a Nahrezer! They become more swift and have a terrifying presence, but they are also easier to injure, and their fast attacks do not pack the same punch.";
		this.m.Icon = "skills/pov_ghoul_mutant.png";
		this.m.IconMini = "pov_mini_ghoul_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They become more swift and have a terrifying presence, but they are also easier to injure, and their fast attacks do not pack the same punch.";
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] initiative."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.PositiveValue + "]-8[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] melee damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Injury threshold reduced by [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color]."
			}

		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.InitiativeMult *= 1.2;
		_properties.Threat += 8;
		// Debuffs
		_properties.ThresholdToReceiveInjuryMult *= 0.75;
		_properties.RangedSkillMult *= 0.90;
		_properties.MeleeDamageMult *= 0.95;
	}

});
