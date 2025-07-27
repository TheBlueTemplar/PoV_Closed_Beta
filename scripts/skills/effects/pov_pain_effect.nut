this.pov_pain_effect <- this.inherit("scripts/skills/skill", {
	m = {
		// Full credits for this idea go to Darxo!
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_pain";
		this.m.Name = "[color=#5c0101]Severe Pain[/color]";
		this.m.Icon = "skills/status_effect_119.png";
		this.m.IconMini = "status_effect_119_mini";
		this.m.Overlay = "status_effect_119";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is under a lot of pain, reducing their mobility and damage output. Will wear off in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		return [
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color] Action Point"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Initiative"
			}
		];
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_119", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.90;
		_properties.InitiativeMult *= 0.90;
		_properties.ActionPoints -= 1;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

