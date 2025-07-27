this.pov_charge_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsCharging = false
		},
	function create()
	{
		this.m.ID = "actives.pov_charge";
		this.m.Name = "Charge";
		this.m.Description = "Charge your enemies, stunning them on contact. \n\n Shielded enemies have a chance to resist the stun, especially using shieldwall.";
		this.m.Icon = "skills/pov_active_52.png";
		this.m.IconDisabled = "skills/pov_active_52_sw.png";
		this.m.Overlay = "active_52";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_charge_01.wav",
			"sounds/enemies/orc_charge_02.wav",
			"sounds/enemies/orc_charge_03.wav",
			"sounds/enemies/orc_charge_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingActorPitch = true;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Charges anywhere within [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] Tiles"
			}
		]);
		/*ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Attacks a target with [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of Total Damage"
			}
		]);*/
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance stun the targer. Shielded Targets can resist the stun."
			}
		]);
		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Targets that resist the stun are [color=" + this.Const.UI.Color.PositiveValue + "]baffled[/color] instead."
			}
		]);
		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference)
		{
			return false;
		}

		local myPos = _originTile.Pos;
		local targetPos = _targetTile.Pos;
		local distance = _originTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);

			if (!tile.IsOccupiedByActor && !tile.IsEmpty)
			{
				return false;
			}

			if (tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				return false;
			}

			if (this.Math.abs(tile.Level - _originTile.Level) > 1)
			{
				return false;
			}
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			for( local i = 0; i < distance; i = ++i )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
					}
				}
			}
		}

		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local ZOC = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();

					if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
					{
					}
					else
					{
						ZOC.push(actor);

						if (betterThanNothing == null)
						{
							betterThanNothing = actor;
						}

						if (actor.getCurrentProperties().IsImmuneToStun)
						{
						}
						else
						{
							potentialVictims.push(actor);
						}
					}
				}
			}
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " charges and is repelled");
				}

				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}

				for( local i = 0; i != 6; i = ++i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = myTile.getNextTile(i);

						if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1)
						{
							if (tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0)
							{
							}
							else
							{
								_tag.TargetTile = tile;
								this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
								return;
							}
						}
					}
				}

				_tag.TargetTile = _tag.OldTile;
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
				return;
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null)
		{
			potentialVictims.push(betterThanNothing);
		}

		//Stun and/or other effects added here
		if (potentialVictims.len() != 0)
		{
			local victim = potentialVictims[this.Math.rand(0, potentialVictims.len() - 1)];
			local chance = 100;

			/*_tag.Skill.m.IsCharging = true;
			// Make the attack happen before causing the Stun
			_entity.getSkills().getAttackOfOpportunity().useForFree(victim.getTile());
			_tag.Skill.m.IsCharging = false;*/

			if (victim.isArmedWithShield())
			{
				local shield = victim.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
				chance = chance - shield.getMeleeDefense();

				if (victim.getSkills().hasSkill("effects.shieldwall"))
				{
					chance = chance - shield.getMeleeDefense()*2;
				}
			}

			if (_tag.Skill.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, victim.getPos());
			}

			if (!victim.isHiddenToPlayer())
			{
				local layers = this.Const.ShakeCharacterLayers[this.Const.BodyPart.Body];
				this.Tactical.getShaker().shake(victim, myTile, 2);
			}

			if (!victim.getCurrentProperties().IsImmuneToStun && this.Math.rand(1, 100) <= chance)
			{
				victim.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " charges and stuns " + this.Const.UI.getColorizedEntityName(victim));
				}

				return;
			}else
			{
				victim.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));

				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " charges and baffles " + this.Const.UI.getColorizedEntityName(victim));
				}

				return;
			}
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " charges");
		}

		/*function onAnySkillUsed( _skill, _targetEntity, _properties )
		{
			if (this.m.IsCharging)
				_properties.DamageTotalMult *= 0.10;
		}

		function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
		{
			if (this.m.IsCharging)
				this.m.IsCharging = false;
		}*/
	}

});
