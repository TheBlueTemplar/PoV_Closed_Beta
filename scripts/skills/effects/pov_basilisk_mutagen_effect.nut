this.pov_basilisk_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
		},
	function create()
	{
		this.m.ID = "effects.pov_basilisk_mutagen";
		this.m.Name = "Mutation: Basilisk";
		this.m.Icon = "skills/pov_basilisk.png";
		this.m.IconMini = "";
		this.m.Overlay = "basilisk";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Enhanced Optics[/color]: The vatt'ghern's mutated eyes glow with an unnatural intensity, granting them the ability to perceive even the subtlest vulnerabilities in their foes. With deadly precision, they target weak points, turning every strike to the head into a calculated execution. However, this heightened focus comes at a cost—draining their stamina and diminishing their effectiveness in broader combat. A fearsome gift, but one that demands careful control.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Unnatural Glare[/color]: The vatt'ghern's unnatural eyes emit an intimidating brilliance. When focused on an enemy, it deeply unsettles them, throwing them off balance.";
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
				text = "Adds the [color=" + this.Const.UI.Color.PositiveValue + "]\"Glare\"[/color] skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit the head"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Regenerate [color=" + this.Const.UI.Color.PositiveValue + "] 7%[/color] of base fatigue when hitting an enemy to the head (once per turn)"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+8%[/color] more damage when hitting the head with any weapon"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] less damage when hitting the body with any weapon"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "All skills cost [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color] more fatigue"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		// Glare Ability and fat regen on hdsh
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.08;
		// Debuffs
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] += -0.20;
		_properties.FatigueEffectMult *= 1.15;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				if (!this.m.IsSpent)
				{
					this.m.IsSpent = true;
					local actor = this.getContainer().getActor();
					actor.setFatigue(this.Math.max(0, actor.getFatigue() - actor.getBaseProperties().Stamina * actor.getBaseProperties().StaminaMult * 0.70));
					actor.setDirty(true);
				}
				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " regenerated fatigue by hitting " + this.Const.UI.getColorizedEntityName(_targetEntity) + " in the head");
				}
			}
		}
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function onAdded()
	{
		// ADD GLARE SKILL HERE
		if (!this.m.Container.hasSkill("actives.pov_glare"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pov_glare_skill"));
		}

	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function inBattleHiddenCheck()
	{
		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return false;
		}

		return true;
	}

});

