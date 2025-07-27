this.pov_spider_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
//		TurnsLeft = 3, //luft wuz 'ere //sorry luft //templar was here too
	},

	function create()
	{
		this.m.ID = "effects.pov_spider_mutagen";
		this.m.Name = "Mutation: Spider";
		this.m.Icon = "skills/pov_spider.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Mutated Circulatory System[/color]: This character\'s body has mutated, allowing them to be disposed of any toxins without serious health effects.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Mutated Εxocrine Glands[/color]: This character has developed glands that allow them to produce a strong venom that can be applied to their weapons. They have also developed the ability to create web, allowing them to trap their enemies. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Venomous Reliance[/color]: This character excels in exploiting the weakness of already poisoned enemies, but does not have maximum damage efficiency against enemies that are not poisoned.";
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
				icon = "ui/icons/special.png",
				text = "Gets the \"Weave Web\" Skill."
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
				text = "Attacks with any weapon deal [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] damage to a poisoned enemy, but [color=" + this.Const.UI.Color.NegativeValue + "]-12%[/color] damage to an enemy that is not poisoned."
			},
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		// More damage to poisoned enemies 10%
		// Applies poison on atk
		_properties.IsImmuneToPoison = true;
		
		// Debuffs
		// Less damage to non poisoned enemies 12%
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.web"))
		{
			local weave = this.new("scripts/skills/actives/web_skill");
			weave.m.ActionPointCost = 5;
			weave.m.FatigueCost = 28;
			weave.m.MaxRange = 2;
			weave.m.Description = "The Vatt\'ghern weaves and covers an enemy in their web, greatly reducing their initiative, defense and damage."
			weave.m.Icon = "skills/active_pov_weave_net.png"; // change these two
			weave.m.IconDisabled = "skills/active_pov_weave_net_sw.png";
			this.m.Container.add(weave);

			//this.getContainer().getActor().m.AIAgent.addBehaviour(this.new("scripts/ai/tactical/behaviors/ai_web"));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		//fallback
		if (_targetEntity == null)
		{
			return;
		}

		if (_targetEntity.getSkills().getSkillByID("effects.pov_mutant_poison") != null || _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_poison") != null || _targetEntity.getSkills().getSkillByID("effects.spider_poison") != null || _targetEntity.getSkills().getSkillByID("effects.goblin_poison") != null || _targetEntity.getSkills().getSkillByID("effects.legend_basilisk_poison") != null)
		{
			_properties.DamageRegularMult *= 1.10;
		}else{
			_properties.DamageRegularMult *= 0.88;
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

