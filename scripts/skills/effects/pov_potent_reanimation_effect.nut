this.pov_potent_reanimation_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_potent_reanimation";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Potent Reanimation[/color]";
		this.m.Description = "This enemy has some properties of an Orc! They are much more agressive, and deal more damage, at the cost of their defences.";
		this.m.Icon = "skills/pov_skeleton.png";
		this.m.IconMini = "pov_mini_skeleton";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are much more agressive, and deal more damage, at the cost of their defences.";
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
				icon = "ui/icons/health.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] hitpoint bonus."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] damage resistance."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		// Add some kind of drop?
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.HitpointsMult *= 1.15;
		// Debuffs
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 0.90;

		// Fire Damage Taken Debuff
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 1.5;
		}
	}

});
