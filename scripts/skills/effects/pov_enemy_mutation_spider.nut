this.pov_enemy_mutation_spider <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_spider";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]Spider\'s Glands[/color]";
		this.m.Description = "This enemy has some properties of a spider! They can poison their enemies, and deal more damage to them while they are poisoned.";
		this.m.Icon = "skills/pov_spider_mutant.png";
		this.m.IconMini = "pov_mini_spider_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This eneny has some properties of a spider! They can poison their enemies, and deal more damage to them while they are poisoned.";
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
				icon = "ui/icons/pov_poison.png",
				text = "Attacks with any weapon [color=" + this.Const.UI.Color.PositiveValue + "]Poison[/color] the enemy, dealing [color=" + this.Const.UI.Color.PositiveValue + "]9[/color] damage for two turns, and reducing their initiative and damage by [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Attacks with any weapon deal [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] damage to a poisoned enemy, but [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] damage to an enemy that is not poisoned."
			},

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Spider));
	  	}

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

			if (actor.getAIAgent().findBehavior(this.Const.AI.Behavior.ID.ThrowNet) == null)
			{
				actor.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
				actor.getAIAgent().finalizeBehaviors();
			}
		}
	
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		//fallback
		if (_targetEntity == null)
		{
			return;
		}

		if (_targetEntity.getSkills().getSkillByID("effects.pov_mutant_poison") != null || _targetEntity.getSkills().getSkillByID("effects.spider_poison") != null || _targetEntity.getSkills().getSkillByID("effects.goblin_poison") != null || _targetEntity.getSkills().getSkillByID("effects.legend_basilisk_poison") != null || _targetEntity.getSkills().getSkillByID("effects.pov_vattghern_upgraded_poison") != null || _targetEntity.getSkills().getSkillByID("effects.stench") != null)
		{
			_properties.DamageRegularMult *= 1.15;
		}else{
			_properties.DamageRegularMult *= 0.85;
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

		local poison = _targetEntity.getSkills().getSkillByID("effects.pov_mutant_poison");
		if (poison == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/pov_mutant_poison_effect"));
		else
			poison.resetTime();
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
