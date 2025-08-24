this.pov_thirdeye_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function create()
	{
		this.m.ID = "actives.pov_thirdeye_skill";
		this.m.Name = "Third Eye";
		this.m.Description = "Use your third eye to gain vision of the battle field.";
		this.m.Icon = "skills/active_118.png";
		this.m.IconDisabled = "skills/active_118_sw.png";
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
		this.m.FatigueCost = 20;
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
		return ret;
	}



	function onUse( _user, _targetTile )
	{
		this.Tactical.queryTilesInRange(_user.getTile(), 1, 15, false, [], this.onQueryTile, _user.getFaction());
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

});

