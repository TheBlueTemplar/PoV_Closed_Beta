this.pov_spider_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
//		TurnsLeft = 3, //luft wuz 'ere //sorry luft //templar was here too
//		Damage = 5,
//		LastRoundApplied = 0
	},

//	function getDamage()		//remnants of the OG spider_poison_effect
//	{
//		return this.m.Damage;
//	}
//
//	function setDamage( _d )
//	{
//		this.m.Damage = _d;
//	}

	function create()
	{
		this.m.ID = "effects.pov_spider_mutagen";
		this.m.Name = "Mutation: Spider";
//		this.m.KilledString = "Died from Witcher Venom";		//we use spider_poison_effect on enemies, it got its own string for this
		this.m.Icon = "skills/pov_spider.png";
		this.m.IconMini = "";
//		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;		//bad implementation
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Mutated Circulatory System[/color]: This character\'s body has mutated, allowing them to be disposed of any toxins without serious health effects.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Venom Glands[/color]: This character has developed glands that allow them to produce a strong venom that can be applied to their weapons. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Venomous Reliance[/color]: This character excels in exploiting the weakness of already poisoned enemies, but does not have maximum damage efficiency against enemies that are not poisoned.";
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
				icon = "ui/icons/special.png",
				text = "Can craft Vattghern Poisoned Oil."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "Immunity to poison effects."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "Attacks with any weapon [color=" + this.Const.UI.Color.PositiveValue + "]Poison[/color] the enemy (\"Mutant Poison\"), dealing [color=" + this.Const.UI.Color.PositiveValue + "]7[/color] damage for two turns, and reducing their initiative and damage by [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] and vision by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Attacks with any weapon deal [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] damage to a poisoned enemy, but [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] damage to an enemy that is not poisoned."
			},

			//we are using spider_poison_effect now, it got its own tooltip
//			{
//				id = 11,
//				type = "text",
//				icon = "ui/icons/special.png",
//				text = "Targets affected will lose [color=" + this.Const.UI.Color.NegativeValue + "]15[/color] hitpoints per turn until the effect has faded."
//			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		// More damage to poisoned enemies 10%
		_properties.IsImmuneToPoison = true;
		
		// Debuffs
		// Less damage to non poisoned enemies 15%
	}

//	function resetTime()		//OG implementation, and again, dont know why this was done in such way, but u gotta do what u gotta do, i guess
//	{
//		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
//
//		if (this.getContainer().hasSkill("trait.ailing"))
//		{
//			++this.m.TurnsLeft;
//		}
//	}
//
//	function applyDamage()
//	{
//		if (this.m.LastRoundApplied != this.Time.getRound())
//		{
//			this.m.LastRoundApplied = this.Time.getRound();
//			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());
//
//			if (this.m.SoundOnUse.len() != 0)
//			{
//				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
//			}
//
//			local hitInfo = clone this.Const.Tactical.HitInfo;
//			hitInfo.DamageRegular = this.m.Damage;
//			if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
//			{
//				hitInfo.DamageRegular = 2 * this.m.Damage;
//			}
//
//			hitInfo.DamageDirect = 1.0;
//			hitInfo.BodyPart = this.Const.BodyPart.Body;
//			hitInfo.BodyDamageMult = 1.0;
//			hitInfo.FatalityChanceMult = 0.0;
//			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
//		}
//	}
//
//	function onAdded()
//	{
//		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
//
//		if (this.getContainer().hasSkill("trait.ailing"))
//		{
//			++this.m.TurnsLeft;
//		}
//	}
//
//	function onTurnEnd()
//	{
//		this.applyDamage();
//
//		if (--this.m.TurnsLeft <= 0)
//		{
//			this.removeSelf();
//		}
//	}
//
//	function onWaitTurn()
//	{
//		this.applyDamage();
//	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		//fallback
		if (_targetEntity == null)
		{
			return;
		}

		if (_targetEntity.getSkills().getSkillByID("effects.pov_spider_poison") != null || _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_poison") != null || _targetEntity.getSkills().getSkillByID("effects.spider_poison") != null || _targetEntity.getSkills().getSkillByID("effects.goblin_poison") != null || _targetEntity.getSkills().getSkillByID("effects.legend_basilisk_poison") != null)
		{
			_properties.DamageRegularMult *= 1.10;
		}else{
			_properties.DamageRegularMult *= 0.90;
		}
	}

	//"new" implementation
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		//fallback
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity == null)
			return;

		//poison immunity and hitpoint damage checks(we cant apply poison if we just scratch the armor, can we?)
		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
			return;

		//undead check, cant poison them, makes sense i guess
		if (_targetEntity.getFlags().has("undead"))
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned by Vatt\'ghern poison");
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());

		local poison = _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_poison");
		if (poison == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/pov_vattghern_poison_effect"));
		else
			poison.resetTime();
	}


});

