this.pov_undead_pain_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_undead_pain";
		this.m.Name = "[color="+ ::Const.UI.Color.povPainEffect + "]Destabilised[/color]";
		this.m.Icon = "skills/pov_skeleton.png";
		this.m.IconMini = "pov_mini_skeleton";
		this.m.Overlay = "pov_medium_skeleton";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "While this character cannot feel severe pain from their recent Injury, the magic keeping them togeather has been severely destabilised, and will need time to recover, resulting in reduced speed and increased fragility. Stacking. \n\n Will wear off in [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				text = "Takes [color=" + this.Const.UI.Color.NegativeValue + "]+12%[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-12%[/color] Melee and Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Initiative"
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
		this.spawnIcon("pov_medium_skeleton", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		//Debuffs
		_properties.MeleeDefenseMult *= 0.88;
		_properties.RangedDefenseMult *= 0.88;
		_properties.InitiativeMult *= 0.80;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 1.12;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

