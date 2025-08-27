this.pov_greater_flesh_golem_buff_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_greater_flesh_golem_buff";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Greater Living Rot[/color]";
		this.m.Description = "Blob, tanky";
		this.m.Icon = "skills/pov_flesh_golem.png";
		this.m.IconMini = "pov_mini_flesh_golem";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		//this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "Blob, tanky";
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] hitpoint bonus."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] melee attack."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] damage resistance."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "Takes [color=" + this.Const.UI.Color.NegativeValue + "]+80%[/color] more fire damage."
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
		_properties.HitpointsMult *= 1.50;
		_properties.MeleeSkill += 10;
		_properties.Threat += 3;
		// Debuffs
		_properties.MeleeDefense -= 6;
		_properties.RangedDefense -= 12;
		_properties.Initiative -= 10;
		// Takes more fire dmg
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 0.90;

		// Fire Damage Taken Debuff
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 1.80;
		}
	}

});
