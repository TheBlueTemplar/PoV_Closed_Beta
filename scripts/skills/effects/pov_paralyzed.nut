this.pov_paralyzed <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_paralyzed";
		this.m.Name = "Paralyzed";
		this.m.Description = "This character has been marked by a skilled opponent, ranged attacks are more likely to hit";
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconMini = "mini_mark_target";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been paralyzed, losing  [color=" + this.Const.UI.Color.NegativeValue + "] 40% [/color] initiative and [color=" + this.Const.UI.Color.NegativeValue + "] 5% [/color] of defences, for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onUpdate( _properties )
	{
		/*
		if (this.m.TurnsLeft != 0)
		{
			_properties.InitiativeForTurnOrderAdditional += -2000;
		}
		*/
		_properties.RangedSkill *= 0.95;
		_properties.MeleeSkill *= 0.95;
		_properties.Initiative *= 0.60;
	}


	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
