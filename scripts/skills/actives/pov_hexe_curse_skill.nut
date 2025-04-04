this.pov_hexe_curse_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = this.Math.rand(1, 2) //should be ok on serialization, i think tis in the parent table
	},
	function create()
	{
		this.m.ID = "actives.pov_curse";
		this.m.Name = "Curse";
		this.m.Description = "You hex your enemy, they move slow, you move slow etc"; //wip, sorry
		this.m.Icon = "skills/hex_square.png";	//placeholders
		this.m.IconDisabled = "skills/hex_square_bw.png";
		this.m.Overlay = "active_119";
		this.m.SoundOnHit = [
			"sounds/enemies/dlc2/hexe_hex_01.wav",
			"sounds/enemies/dlc2/hexe_hex_02.wav",
			"sounds/enemies/dlc2/hexe_hex_03.wav",
			"sounds/enemies/dlc2/hexe_hex_04.wav",
			"sounds/enemies/dlc2/hexe_hex_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 4;		//maybe should tweak these
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
				text = "Make an enemy last in turn order next turn, also affects the caster" //wip, i told u
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

		if (this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))	//ally check
		{
			return false;
		}

		//calling by ID
		if (_targetTile.getEntity().getSkills().hasSkill("effects.pov_curse_slave") || _targetTile.getEntity().getSkills().hasSkill("effects.pov_curse_master"))	//should prevent you from using this on already affected targets
		{
			return false;
		}

		return true;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function onUse( _user, _targetTile )	//probably just for gx
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

		if (target.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50) //dont know if this check should be there for curse, im not big on the curse lore
		{
			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists being cursed thanks to his unnatural physiology");
			}

			return false;
		}

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " curses " + this.Const.UI.getColorizedEntityName(target));

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, _user.getPos());
			}
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _tag )
		{
			local color;

			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("effect_pentagram_02", color, _targetTile, !target.getSprite("status_hex").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local slave = this.new("scripts/skills/effects/pov_hexe_curse_slave_effect");
			local master = this.new("scripts/skills/effects/pov_hexe_curse_master_effect");
			slave.setMaster(master);
			slave.setColor(color);
			target.getSkills().add(slave);
			master.setSlave(slave);
			master.setColor(color);
			_user.getSkills().add(master);
			slave.activate();
			master.activate();
		}.bindenv(this), null);
	}
});