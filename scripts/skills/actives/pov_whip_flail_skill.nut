this.pov_whip_flail_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_whip_flail_skill";
		this.m.Name = "Whip Flail";
		this.m.Description = "Flailing at an opponent. Somewhat unpredictable in damage, but able to strike over or around shield cover.";
		this.m.KilledString = "Smashed";
		this.m.Icon = "skills/active_39.png";
		this.m.IconDisabled = "skills/active_39_sw.png";
		this.m.Overlay = "active_39";
		this.m.SoundOnUse = [
			"sounds/combat/flail_01.wav",
			"sounds/combat/flail_02.wav",
			"sounds/combat/flail_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/flail_hit_01.wav",
			"sounds/combat/flail_hit_02.wav",
			"sounds/combat/flail_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.IsTooCloseShown = true;
		this.m.DirectDamageMult = 0.3;
		this.m.HitChanceBonus = 0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 16;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]3[/color] tiles"
			}
		]);
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores the bonus to Melee Defense granted by shields"
			}
		]);
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to baffle on a hit to the head"
			}
		]);
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			}
		]);
		/*ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]-5%[/color] hit chance overall"
			}
		]);*/

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());

		/*
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && _bodyPart == this.Const.BodyPart.Head)
		{
			target.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + this.Const.UI.getColorizedEntityName(target) + " baffled");
			}
		}

		return success;
		*/
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			//_properties.MeleeSkill += -5;

			if (_targetEntity != null && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			/*else
			{
				_properties.MeleeSkill += -5;
			}*/
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToStun)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " baffled");
				}
			}
		}
	}

});

