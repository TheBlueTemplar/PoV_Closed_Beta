this.pov_enemy_mutation_schrat <- this.inherit("scripts/skills/skill", {
	m = {
		HeadArmorBoost = 25,
		HeadDamageTaken = 0,
		BodyArmorBoost = 25,
		BodyDamageTaken = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_schrat";
		this.m.Name = "[color=#034207] Barkskin [/color]";
		this.m.Description = "This enemy has some properties of a Scrat! So...wood";
		this.m.Icon = "skills/pov_schrat_mutant.png";
		this.m.IconMini = "pov_mini_schrat_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This enemy has some properties of a Scrat! So...wood";
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
				text = "Immunity to being moved."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "This character\'s skin is hard, granting [color=" + this.Const.UI.Color.PositiveValue + "]25[/color] points of natural armor"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Movement costs [color=" + this.Const.UI.Color.NegativeValue + "]30%[/color] more fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]300%[/color] more damage from fire attacks."
			}

		];
		return ret;
	}


	function onCombatStarted()
	{
		this.m.HeadDamageTaken = 0;
		this.m.BodyDamageTaken = 0;
	}

	function onCombatFinished()
	{
		this.m.HeadDamageTaken = 0;
		this.m.BodyDamageTaken = 0;
	}

	function onUpdate( _properties )
	{
		// BUFFS
		_properties.Armor[this.Const.BodyPart.Head] += this.Math.max(0.0, this.m.HeadArmorBoost - this.m.HeadDamageTaken);
		_properties.Armor[this.Const.BodyPart.Body] += this.Math.max(0.0, this.m.BodyArmorBoost - this.m.BodyDamageTaken);
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.HeadArmorBoost;
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.m.BodyArmorBoost;
		_properties.IsImmuneToKnockBackAndGrab = true;
		// DEBUFFS
		_properties.MovementFatigueCostMult *= 1.3;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		//_properties.DamageReceivedRegularMult *= 0.90;
		if (_hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			if (this.m.HeadDamageTaken >= this.m.HeadArmorBoost)
			{
				return;
			}

			_properties.DamageArmorReduction += this.m.HeadArmorBoost - this.m.HeadDamageTaken;
			this.m.HeadDamageTaken += _hitInfo.DamageArmor;
		}
		else if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			if (this.m.BodyDamageTaken >= this.m.BodyArmorBoost)
			{
				return;
			}

			_properties.DamageArmorReduction += this.m.BodyArmorBoost - this.m.BodyDamageTaken;
			this.m.BodyDamageTaken += _hitInfo.DamageArmor;
		}

		// Fire Damage Taken Debuff
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 3;
		}
	}
});
