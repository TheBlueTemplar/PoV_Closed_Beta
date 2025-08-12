this.pov_vattghern_poison_coat_effect <- this.inherit("scripts/skills/skill", {
	m = {
		AttacksLeft = 4
	},
	function create()
	{
		this.m.ID = "effects.pov_vattghern_poison_coat";
		this.m.Name = "Weapon coated with vattghern poison";
		this.m.Icon = "skills/pov_coat_vattghern_poison.png";
		this.m.IconMini = "pov_coat_vattghern_poison_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is using a weapon coated with concentrated vattghern poison. The next few hits doing at least [color=" + this.Const.UI.Color.NegativeValue + "]" + this.Const.Combat.PoisonEffectMinDamage + "[/color] damage to hitpoints will apply it. Targets affected will lose [color=" + this.Const.UI.Color.NegativeValue + "]7[/color] hitpoints per turn until the effect has faded. \n\n While under this poison, they also losing [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] initiative and damage and [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] vision.\n\n Missing an attack wastes a stack of this coating effect.";
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

	function resetTime()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("status_effect_88", this.getContainer().getActor().getTile());
		}

		this.m.AttacksLeft = 4;
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
		if (!_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		local effect = this.new("scripts/skills/effects/pov_vattghern_poison_effect");
		//effect.setDamage(7);
		_targetEntity.getSkills().add(effect);
	}

});

