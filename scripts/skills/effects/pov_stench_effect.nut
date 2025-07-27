this.pov_stench_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Damage = 6,
		LastRoundApplied = 0
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function create()
	{
		this.m.ID = "effects.pov_stench";
		this.m.Name = "Foul Stench!";
		this.m.KilledString = "Died from the unbearable rot";
		this.m.Icon = "skills/pov_stench_status_effect.png";
		this.m.IconMini = "pov_mini_stench_status_effect";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_poison_01.wav",
			"sounds/enemies/dlc2/giant_spider_poison_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has piercing stench and rot invading his eyes and lungs, causing them to lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s). \n\n While under this effect, they also losing [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color] initiative, [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] damage, [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] Resolve and [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] Vision.";
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("pov_medium_stench_status_effect", this.getContainer().getActor().getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		this.spawnIcon("pov_medium_stench_status_effect", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 0.85;
		_properties.DamageTotalMult *= 0.90;
		_properties.BraveryMult *= 0.75;
		_properties.Vision -= 1;
	}


	function onTurnEnd()
	{
		this.applyDamage();

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

