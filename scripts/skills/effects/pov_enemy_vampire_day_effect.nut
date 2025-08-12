this.pov_enemy_vampire_day_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_vampire_day_effect";
		this.m.Name = "Weakened Vampire (Day)";
		this.m.Description = "The Vatt\'ghern\'s vampiric nature hampers their combat ability during daytime.";
		this.m.Icon = "skills/pov_vampire_day.png";
		this.m.IconMini = "pov_mini_vampire_day";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The Vatt\'ghern\'s vampiric nature hampers their combat ability during daytime. All combat stats reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color].";
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
			    icon = "ui/icons/vision.png",
			    text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color] Vision."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/ranged_skill.png",
			    text = "Ranged Skill reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/ranged_defense.png",
			    text = "Ranged Defense reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_skill.png",
			    text = "Melee Skill reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_defense.png",
			    text = "Melee Defense reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/initiative.png",
			    text = "Initiative reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/bravery.png",
			    text = "Resolve reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/fatigue.png",
			    text = "Stamina reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			}

		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += -1;
		_properties.RangedSkillMult *= 0.94;
		_properties.RangedDefenseMult *= 0.94;
		_properties.MeleeSkillMult *= 0.94;
		_properties.MeleeDefenseMult *= 0.94;
		_properties.InitiativeMult *= 0.94;
		_properties.BraveryMult *= 0.94;
		_properties.StaminaMult *= 0.94;
	}

});
