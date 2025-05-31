this.pov_glare_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_glare";
		this.m.Name = "Glare";
		this.m.Description = "Inflicts the [color=" + this.Const.UI.Color.NegativeValue + "]Paralyzed[/color] effect on the enemy, reducing their initiative by 40% and Offensive skills by 15% for two turns.";
		this.m.KilledString = "Bok bok BAAAWK";
		this.m.Icon = "skills/pov_glare.png";
		this.m.IconDisabled = "skills/pov_glare_gx.png";
		this.m.Overlay = "glare";
		this.m.SoundOnUse = [
			"sounds/enemies/horror_spell_01.wav",
			"sounds/enemies/horror_spell_02.wav",
			"sounds/enemies/horror_spell_03.wav"

		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav"
		];
		//this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsRanged = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MaxLevelDifference = 6;
		this.m.IsUsingHitchance = false;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip()
		ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Leave your opponent [color=" + this.Const.UI.Color.NegativeValue + "]Paralyzed[/color], reducing their initiative and attack capability"
			})
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

		if (target.isAlive())
		{
			target.getSkills().add(this.new("scripts/skills/effects/pov_paralyzed_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " makes an unnatural glare towards " + this.Const.UI.getColorizedEntityName(target) + " leaving them paralyzed");
			}
		}
	}

	function onVerifyTarget( _originTile, _targetTile ) //This stops you from targeting allies with this skill
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return true;
	}
});
