this.pov_calcium_deficiency_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_calcium_deficiency";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Calcium Deficiency[/color]";
		this.m.Description = "This one did not drink enough milk xd.";
		this.m.Icon = "skills/pov_skeleton.png";
		this.m.IconMini = "pov_mini_skeleton";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This one did not drink enough milk xd.";
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
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color] max hitpoints."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Takes [color=" + this.Const.UI.Color.NegativeValue + "]+10%[/color] damage."
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
		_properties.HitpointsMult *= 0.65;
		// Debuffs
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 1.10;
	}

});
