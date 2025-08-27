this.pov_enemy_mutation_vampire <- this.inherit("scripts/skills/skill", {
	m = {
		ShouldHeal = false
		// THIS EFFECT SHOULD COME WITH THE UNDEAD FLAG, WHICH IS ADDED VIA THE FUNCTION CALLING IT
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_vampire";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "]Vampiric Blood[/color]";
		this.m.Description = "This enemy has Vampiric Blood! They inherit some properties of the necrosavants.";
		this.m.Icon = "skills/pov_vampire_mutant.png";
		this.m.IconMini = "pov_mini_vampire_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This enemy has Vampiric Blood! They inherit some properties of the necrosavants.";
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] lifesteal on attacks, with a limit of  [color=" + this.Const.UI.Color.PositiveValue + "]12.5%[/color] of their max HP"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is considered as [color=" + this.Const.UI.Color.NegativeValue + "]Undead[/color]"
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
			actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_vampire_night_effect"));
		}else{
			// ADD DAY DEBUFF - REMOVED AFTER COMBAT
			actor.getSkills().add(this.new("scripts/skills/effects/pov_enemy_vampire_day_effect"));
		}
	}
 
	function onCombatFinished()
	{
		this.m.ShouldHeal = false;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Vampire));
	  	}
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

	// Heal for 30% of damage dealt
	// Max healing is 40% of max HP per heal
	function lifesteal( _damageInflictedHitpoints )
	{
		local actor = this.m.Container.getActor();
		this.spawnIcon("status_effect_09", actor.getTile());
		local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * 0.30);
		local maxHeal = this.Math.round(actor.getHitpointsMax()*0.40);

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


	function onUpdate(_properties)
	{
		// THE UNDEAD PROPERTY IS ADDED VIA THE METHOD THAT ADDS THIS EFFECT!
		// LEFT THIS FOR REFERENCE

		/*local actor = this.m.Container.getActor();
		//::TLW.Mod.Debug.printLog("undead check");
		if (!actor.getFlags().has("undead"))
		{
			//::TLW.Mod.Debug.printLog("done?");
			actor.getFlags().add("undead");
		}*/

		_properties.IsAffectedByNight = false;
	}

});
