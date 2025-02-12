this.lindwurm_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.lindwurm_mutagen";
		this.m.Name = "Mutation: Wurm";
		this.m.Icon = "skills/lindwurm.png";
		//this.m.IconMini = "status_effect_140_mini";
		this.m.Overlay = "lindwurm";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Acidic blood[/color]: This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray. This same acid slighlt reduces healing speed.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Acidic Reinforcement[/color]: By slightly infusing their weapons with their own acid, the Vatt\'ghern does extra damage to enemie\'s armor. \n\n[color=" + this.Const.UI.Color.NegativeValue + "]Dravonic Cockiness[/color]: The Vatt\'ghern is full of himslef, disregarding his own defense, and demanding even more pay than usual.";
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
				text = "This character\'s blood burns with [color=" + this.Const.UI.Color.PositiveValue + "]acid[/color], damaging adjacent attacker's armor whenever they deal hitpoint damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to acid."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Do [color=" + this.Const.UI.Color.PositiveValue + "]20% + 10[/color] more damage to armor."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s lost health recovers [color=" + this.Const.UI.Color.NegativeValue + "]30%[/color] slower."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s melee defense is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/money2.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+25[/color]% Daily Wage"
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageArmorMult *= 1.2;
		_properties.DamageArmorMult += 0.1;
		_properties.DailyWageMult *= 1.25;
		_properties.HitpointsRecoveryRateMult *= 0.7;
		_properties.MeleeDefenseMult *= 0.85;
	}

	function onAdded()
	{
			this.m.Container.getActor().getFlags().add("body_immune_to_acid");
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints <= 0)
		{
			return;
		}

		if (_attacker == null || !_attacker.isAlive())
		{
			return;
		}

		if (_attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}

		if (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			return;
		}

		if (_attacker.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _attacker.getSkills().getSkillByID("effects.lindwurm_acid");

		if (poison == null)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		}
		else
		{
			poison.resetTime();
		}

		this.spawnIcon("status_effect_78", _attacker.getTile());
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

