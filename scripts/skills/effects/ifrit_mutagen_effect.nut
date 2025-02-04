this.ifrit_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		HeadArmorBoost = 50,
		HeadDamageTaken = 0,
		BodyArmorBoost = 50,
		BodyDamageTaken = 0
	},
	function create()
	{
		this.m.ID = "effects.ifrit_mutagen";
		this.m.Name = "Mutation: Ifrit";
		this.m.Icon = "skills/ifrit.png";
		this.m.IconMini = "";
		this.m.Overlay = "ifrit";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Stone Skin[/color]: This character\'s skin has mutated and now forms hard, rock-like patches that are much hardier and difficult to puncture.";
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
				icon = "ui/icons/armor_body.png",
				text = "This character\'s skin is hard and stone-like, granting [color=" + this.Const.UI.Color.PositiveValue + "]50[/color] points of natural armor"
			},
			
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
		_properties.Armor[this.Const.BodyPart.Head] += this.Math.max(0.0, this.m.HeadArmorBoost - this.m.HeadDamageTaken);
		_properties.Armor[this.Const.BodyPart.Body] += this.Math.max(0.0, this.m.BodyArmorBoost - this.m.BodyDamageTaken);
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.HeadArmorBoost;
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.m.BodyArmorBoost;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
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

 