this.pov_enemy_mutation_skeleton <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_skeleton";
		this.m.Name = "[color=#034207] Curse Of Undeath [/color]";
		this.m.Description = "This enemy has the curse of Undeath! They are especially resistant to pierce damage, and tire less quickly, but they also have less hitpoints. They also dont like holy water and priests...and crosses, they hate crosses.";
		this.m.Icon = "skills/pov_skeleton_mutant.png";
		this.m.IconMini = "pov_mini_skeleton_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are especially resistant to pierce damage, and tire less quickly, but they also have less hitpoints. They also dont like holy water and priests...and crosses, they hate crosses.";
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
				icon = "ui/icons/fatigue.png",
				text = "Increases Fatigue by[color=" + this.Const.UI.Color.PositiveValue + "] 10%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "This character has [color=" + this.Const.UI.Color.PositiveValue + "]40%[/color] piercing damage resistance."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] more damage from fire attacks."
			},

		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.StaminaMult *= 1.1;
		// Debuffs
		_properties.HitpointsMult *= 0.90;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.6;
				}
				else
				{
					if (_skill.isRanged())
					{
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
						{
							_properties.DamageReceivedRegularMult *= 0.6;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.6;
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.5;
				break;
		}
	}
});
