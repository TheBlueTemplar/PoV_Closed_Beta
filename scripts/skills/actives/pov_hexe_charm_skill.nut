this.pov_hexe_charm_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = this.Math.rand(1, 2) //should be ok on serialization, i think tis in the parent table
	},
	function create()
	{
		this.m.ID = "actives.pov_charm";
		this.m.Name = "Charm";	//same comment as charm_ally effect
		this.m.Description = "You charm your ally/enemy, invigorating/hexing them.";	//this probably should be more sublime and poetic or whatever
		this.m.Icon = "skills/entice.png";	//wip obv
		this.m.IconDisabled = "skills/entice_bw.png";
		this.m.Overlay = "entice";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_charm_kiss_01.wav",	//these will probably sound out of place
			"sounds/enemies/dlc2/hexe_charm_kiss_02.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_03.wav",
			"sounds/enemies/dlc2/hexe_charm_kiss_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 5;		//play with numbers urself
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 8;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants the target ally bla bla buffs, target enemy bla debuffs, bla bla should make something up"	//im not good at this
			}
		];
		return ret;
	}

	function isUsable()
	{
		return this.m.Cooldown == 0 && this.skill.isUsable();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

//		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))	//ally check, maybe will be useful for later if you decide to separate the charm effect for ally\\enemy
//		{
//			return false;
//		}

		//target check, calling by ID
		if (_targetTile.getEntity().getSkills().hasSkill("effects.pov_charm") || _targetTile.getEntity().getSkills().hasSkill("effects.pov_hex"))	//should prevent you from using this on already affected targets
		{
			return false;
		}

		return true;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function onUse(_user, _targetTile) //this implementation is just for the flying heart effect, i think
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		this.m.Cooldown = this.Math.rand(1, 2);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local time = this.Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
		local self = this;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _e )
		{
			if (!_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))	//enemy check
			{
				local bonus = _targetTile.getDistanceTo(_user.getTile()) == 1 ? -5 : 0;

				if (target.getSkills().hasSkill("background.eunuch")/* || target.getSkills().hasSkill("trait.player") || target.getSkills().hasSkill("trait.loyal")*/)	//dont think some of these checks are needed as we are already past the enemy check
				{
					if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " cannot be charmed");
					}

					return false;
				}

				if (target.checkMorale(0, -50 + bonus, this.Const.MoraleCheckType.MentalAttack))
				{
					if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
					}

					return false;
				}

				if (target.checkMorale(0, -50 + bonus, this.Const.MoraleCheckType.MentalAttack))
				{
					if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his resolve");
					}

					return false;
				}
				if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
				{
					if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his unnatural physiology");
					}

					return false;
				}
				target.getSkills().add(this.new("scripts/skills/effects/pov_hexe_hex_effect")); //debuff effect, for enemies
				return true;
			}
			else	//ally "check"
			{
				if (target.getSkills().hasSkill("background.eunuch")) //no pp, poor guy
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " cannot be charmed");
					return false;
				}
				if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)	//some people are just strange
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being charmed thanks to his unnatural physiology");
					return false;
				}
				target.getSkills().add(this.new("scripts/skills/effects/pov_hexe_charm_ally_effect")); //buff effect, for allies
				return true;
			}
		}.bindenv(this), this);
	}
});