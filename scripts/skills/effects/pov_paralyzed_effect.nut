this.pov_paralyzed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_paralyzed";
		this.m.Name = "Paralyzed";
		this.m.Description = "This character has been partially paralyzed, making their movement much harder, and hindering their ability to effectively attack";
		this.m.Icon = "skills/pov_paralyzed.png";
		this.m.IconMini = "pov_mini_paralyzed";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been paralyzed, losing  [color=" + this.Const.UI.Color.NegativeValue + "] 40% [/color] initiative and [color=" + this.Const.UI.Color.NegativeValue + "] 15% [/color] of defences, for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		/*
		if (this.m.TurnsLeft != 0)
		{
			_properties.InitiativeForTurnOrderAdditional += -2000;
		}
		*/
		_properties.RangedSkillMult *= 0.85;
		_properties.MeleeSkillMult *= 0.85;
		_properties.InitiativeMult *= 0.60;

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").setBrush("pov_bust_paralyzed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}


	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
