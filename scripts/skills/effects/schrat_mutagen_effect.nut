this.schrat_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		HeadArmorBoost = 50,
		HeadDamageTaken = 0,
		BodyArmorBoost = 50,
		BodyDamageTaken = 0
	},
	function create()
	{
		this.m.ID = "effects.schrat_mutagen";
		this.m.Name = "Mutation: Elemental";
		this.m.Icon = "skills/schrat.png";
		this.m.IconMini = "";
		this.m.Overlay = "schrat";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Flexile Ligaments[/color]: This character\'s legs have mutated to respond much more rapidly and powerfully to external force. As a practical matter, they can maintain their center of balance and respond to any attempt to move them.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Hardened Exterior[/color]: This character\'s skin has mutated to become much stiffer and can resist a portion on any damage.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Hardened Skin[/color]: This character\'s skin has mutated and now forms hard patches that are difficult to puncture.";
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
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]Damage Reduction."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s skin is hard, granting [color=" + this.Const.UI.Color.PositiveValue + "]50[/color] points of natural armor"
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.Armor[this.Const.BodyPart.Head] += this.Math.max(0.0, this.m.HeadArmorBoost - this.m.HeadDamageTaken);
		_properties.Armor[this.Const.BodyPart.Body] += this.Math.max(0.0, this.m.BodyArmorBoost - this.m.BodyDamageTaken);
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.HeadArmorBoost;
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.m.BodyArmorBoost;
		
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

	

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 0.90;
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


