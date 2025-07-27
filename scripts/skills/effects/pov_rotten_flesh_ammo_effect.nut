this.pov_rotten_flesh_ammo_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_rotten_flesh_ammo";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Does the thing, dont ask how"
			}
		]);
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.fire_handgonne")
		{
			_skill.m.SoundOnFire = [
				"sounds/combat/pov_fire_gonne_flesh_01.wav",
				"sounds/combat/pov_fire_gonne_flesh_02.wav",
				"sounds/combat/pov_fire_gonne_flesh_03.wav",
				"sounds/combat/pov_fire_gonne_flesh_04.wav"
			];
		}

		local item = _skill.getItem();
		if (_skill.isAttack() && item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isWeaponType(this.Const.Items.WeaponType.Firearm))
		{
			_properties.DamageArmorMult *= 0.75;
			_properties.RangedDamageMult *= 0.85;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{	
		// Add Rot Effect on Hit
		if (_damageInflictedHitpoints > 0 || _damageInflictedArmor > 0)
		{
			if (!_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("effects.pov_alp_mutagen") && !_targetEntity.getSkills().hasSkill("effects.pov_skeleton_mutagen") && !_targetEntity.getSkills().hasSkill("effects.pov_strain_mutagen") && !_targetEntity.getSkills().hasSkill("effects.pov_ghoul_mutagen") && !_targetEntity.getSkills().hasSkill("effects.pov_enemy_mutation_alp"))
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/pov_stench_effect"));
				_targetEntity.checkMorale(-1, 10);
			}
		}
		
	}

	function onUpdate(_properties)
	{
		_properties.Bravery -= 5;
	}

});
