this.pov_thirdeye_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = "actives.pov_thirdeye_skill";
		this.m.Name = "Third Eye";
		this.m.Description = "Use your third eye to gain vision of the battle field, and give your allies temporary insight. Can be used once per combat.";
		this.m.Icon = "skills/pov_active_third_eye.png";
		this.m.IconDisabled = "skills/pov_active_third_eye_sw.png";
		this.m.Overlay = "active_104";
		this.m.SoundOnUse = [
			"sounds/combat/scry_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
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
			}
		];

		if (this.m.Cooldown >= 1)
		{
			ret.extend([
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/warning.png",
					text = "Skill is on cooldown. Will be available in the [color=" + this.Const.UI.Color.NegativeValue + "]next[/color] battle."
				}
			]);
		}

		return ret;
	}

	function onCombatStarted()
	{
		this.m.Cooldown = 0;
	}

	function isUsable()
	{
		if (this.m.Cooldown <= 0){
			return true;
		}else{
			return false;
		}
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 999;
		this.Tactical.queryTilesInRange(_user.getTile(), 1, 15, false, [], this.onQueryTile, _user.getFaction());
		
		//local actor = this.getContainer().getActor();
		local allies = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		foreach( ally in allies )
		{
			if (ally.getFaction() == _user.getFaction())
			{
				ally.getSkills().add(this.new("scripts/skills/effects/pov_thirdeye_buff_effect"));
			}
		}
		return true;
	}

	function onQueryTile( _tile, _tag )
	{
		_tile.addVisibilityForFaction(_tag);

		if (_tile.IsOccupiedByActor)
		{
			_tile.getEntity().setDiscovered(true);
		}
	}

	function onCombatFinished()
	{
		this.m.Cooldown = 0;
	}

});

