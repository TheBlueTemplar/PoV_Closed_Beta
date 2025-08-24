this.pov_ghastly_touch_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_ghastly_touch";
		this.m.Name = "Ghastly Touch";
		this.m.Description = "Focus aetherial energy at the edge of your hand, driving it into an enemy. Does some damage that completely ignores armor.\n\n Can use once per turn.";
		this.m.KilledString = "Frightened to death";
		this.m.Icon = "skills/pov_active_42.png";
		this.m.IconDisabled = "skills/pov_active_42_sw.png";
		this.m.Overlay = "active_42";
		this.m.SoundOnUse = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		return ret;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		if (this.m.Cooldown <= 0){
			return true;
		}else{
			return false;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
		this.m.Cooldown = 1;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// Hit Chance Mod
			_properties.MeleeSkill -= 5;
			// Skill Stats
			_properties.DamageRegularMin = 25;
			_properties.DamageRegularMax = 40;
			_properties.DamageArmorMult *= 0;
			_properties.IsIgnoringArmorOnAttack = true;	
		}
	}

});

