this.pov_vampire_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ShouldHeal = false
	},
	function create()
	{
		this.m.ID = "effects.pov_vampire_mutagen";
		this.m.Name = "Mutation: Necrosavant";
		this.m.Icon = "skills/pov_vampire.png";
		this.m.IconMini = "";
		this.m.Overlay = "vampire";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_life_drain_01.wav",
			"sounds/enemies/vampire_life_drain_02.wav",
			"sounds/enemies/vampire_life_drain_03.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Parasitic Blood[/color]: This character\'s body has the incredible ability to incorporate different blood types into itself. This grants them healing from absorption of blood through skin pores.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Lord of the Night[/color]: This character is not affected by the typical nighttime penalties. In addition, they receive a bug bonus to all combat stats when fighting at night.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]Spurned by the Sun[/color]: The nature of this mutation weakens this character when fighting at daytime.";
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
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]immunity[/color] to nighttime penalties."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heal [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of hitpoint damage inflicted on adjacent enemies that have blood. Healing is [color=" + this.Const.UI.Color.NegativeValue + "]capped to 15%[/color] of the Vatt\'ghern\'s max HP."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_time_of_day.png",
				text = "When fighting at [color=" + this.Const.UI.Color.PositiveValue + "]nighttime[/color], all combat stats are increased by [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_time_of_day.png",
				text = "When fighting at [color=" + this.Const.UI.Color.NegativeValue + "]daytime[/color], all combat stats are decreased by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]"
			}
		];
		return ret;
	}


	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		this.m.ShouldHeal = false;

		if (this.getContainer().hasSkill("special.night"))
		{
			// ADD NIGHT BUFF - REMOVED AFTER COMBAT
			actor.getSkills().add(this.new("scripts/skills/effects/pov_vampire_night_effect"));
		}else{
			// ADD DAY DEBUFF - REMOVED AFTER COMBAT
			actor.getSkills().add(this.new("scripts/skills/effects/pov_vampire_day_effect"));
		}
	}

	function onCombatFinished()
	{
		this.m.ShouldHeal = false;

		// DUNNO IF I NEED THIS, WILL TRY IS REMOVED AFTER BATTLE
		/*
		if (this.getContainer().hasSkill("special.night"))
		{
			// REMOVE NIGHT BUFF
		}else{
			// REMOVE DAY DEBUFF
		}
		*/
	}

	// Heal on attacking ppl
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.m.Container.getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			return;
		}

		if (_damageInflictedHitpoints <= 0)
		{
			return;
		}

		if (this.m.ShouldHeal)
		{
			this.lifesteal(_damageInflictedHitpoints);
			this.m.ShouldHeal = false;
			return;
		}

		if (_targetEntity == null || !_targetEntity.isAlive())
		{
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return;
		}

		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) != 1)
		{
			return;
		}

		this.lifesteal(_damageInflictedHitpoints);
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			return;
		}

		local actor = this.m.Container.getActor();

		if (actor.getTile().getDistanceTo(_targetEntity.getTile()) != 1)
		{
			return;
		}

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			return;
		}

		this.m.ShouldHeal = true;
	}

	// Heal for 10% of damage dealt
	// Max healing is 15% of max HP per heal
	function lifesteal( _damageInflictedHitpoints )
	{
		local actor = this.m.Container.getActor();
		this.spawnIcon("status_effect_09", actor.getTile());
		local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * 0.10);
		local maxHeal = this.Math.round(actor.getHitpointsMax()*0.15);

		if(hitpointsHealed > maxHeal)
		{
			hitpointsHealed = maxHeal;
		}

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), hitpointsHealed) + " points");
		}

		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + hitpointsHealed));
		actor.onUpdateInjuryLayer();
	}

	function onUpdate( _properties )
	{
		
		_properties.IsAffectedByNight = false;

		// THIS IS THE EFFECT I WANNA ADD

		/*
		if (this.getContainer().hasSkill("special.night"))
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.20;
			_properties.RangedDefenseMult *= 1.20;
			_properties.MeleeSkillMult *= 1.20;
			_properties.MeleeDefenseMult *= 1.20;
			_properties.InitiativeMult *= 1.20;
			_properties.BraveryMult *= 1.20;
			_properties.StaminaMult *= 1.20;
		}else{
			_properties.Vision += -1;
			_properties.RangedSkillMult *= 0.85;
			_properties.RangedDefenseMult *= 0.85;
			_properties.MeleeSkillMult *= 0.85;
			_properties.MeleeDefenseMult *= 0.85;
			_properties.InitiativeMult *= 0.85;
			_properties.BraveryMult *= 0.85;
			_properties.StaminaMult *= 0.85;
		}
		*/
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
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

