this.necrosavant_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ShouldHeal = false
	},
	function create()
	{
		this.m.ID = "effects.necrosavant_mutagen";
		this.m.Name = "Mutation: Necrosavant";
		this.m.Icon = "skills/vampire.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Parasitic Blood[/color]: This character\'s body has the incredible ability to incorporate different blood types into itself. This grants them healing from absorption of blood through skin pores.";
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
				icon = "ui/icons/health.png",
				text = "Heal [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of hitpoint damage inflicted on adjacent enemies that have blood"
			}
		];
		return ret;
	}

	function onCombatStarted()
	{
		this.m.ShouldHeal = false;
	}

	function onCombatFinished()
	{
		this.m.ShouldHeal = false;
	}

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

	function lifesteal( _damageInflictedHitpoints )
	{
		local actor = this.m.Container.getActor();
		this.spawnIcon("status_effect_09", actor.getTile());
		local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * 0.25);

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

