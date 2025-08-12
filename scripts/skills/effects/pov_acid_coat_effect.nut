this.pov_acid_coat_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.pov_acid_coat";
		this.m.Name = "Weapon coated with acidic blood";
		this.m.Icon = "skills/pov_acid_coat_effect.png";
		this.m.IconMini = "pov_acid_coat_effect_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is using a weapon coated with corrosive acid! Their next attack will be more effective against armor and apply the acid effect on their enemy! \n\n Missing the attack will waste the effect.";
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
			}
		];
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.DamageArmorMult *= 1.2;
		// Debuffs
	}

	function resetTime()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("status_effect_78", this.getContainer().getActor().getTile());
		}

		this.m.AttacksLeft = 1;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
    {
    	if (_skill.m.IsAttack)
    	{
    		--this.m.AttacksLeft;
    	}
    	
    	if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}
    }

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		//--this.m.AttacksLeft;

		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is covered in acid");
		}

		local effect = this.new("scripts/skills/effects/acid_effect");
		_targetEntity.getSkills().add(effect);

		/*if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}*/
	}

	/*function onTargetMissed( _skill, _targetEntity )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}
	}*/

});

