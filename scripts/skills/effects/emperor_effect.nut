this.emperor_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.emperor";
		this.m.Name = "Emperor";
		this.m.Icon = "skills/skele.png";
		this.m.IconMini = "";
		this.m.Overlay = "skele";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "unlocks special crafting";
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
				icon = "ui/icons/special.png",
				text = "Reduces the Fatigue cost actions by[color=" + this.Const.UI.Color.PositiveValue + "] 30%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "This character consumes [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less food."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "This character has plus [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] to bravery."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character takes [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks."
			}
		];
		return ret;
	}

	

	

	function isHidden()
	{
		return true;
	}

	

});

