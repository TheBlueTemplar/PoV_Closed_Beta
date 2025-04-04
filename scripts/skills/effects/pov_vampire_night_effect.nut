this.pov_vampire_night_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_vampire_night_effect";
		this.m.Name = "Vampire: Night!";
		this.m.Description = "The Vatt\'ghern\'s vampiric nature strongly improves their combat ability during the dark night.";
		this.m.Icon = "skills/pov_vampire_night.png";
		this.m.IconMini = "pov_mini_vampire_night";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The Vatt\'ghern\'s vampiric nature strongly improves their combat ability during the dark night. All combat stats increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color].";
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
			    text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Vision."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/ranged_skill.png",
			    text = "Ranged Skill increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/ranged_defense.png",
			    text = "Ranged Defense increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_skill.png",
			    text = "Melee Skill increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_defense.png",
			    text = "Melee Defense increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/initiative.png",
			    text = "Initiative increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/bravery.png",
			    text = "Resolve increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/fatigue.png",
			    text = "Maximum fatigue increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]."
			}

		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.RangedSkillMult *= 1.15;
		_properties.RangedDefenseMult *= 1.15;
		_properties.MeleeSkillMult *= 1.15;
		_properties.MeleeDefenseMult *= 1.15;
		_properties.InitiativeMult *= 1.15;
		_properties.BraveryMult *= 1.15;
		_properties.StaminaMult *= 1.15;
	}

});
