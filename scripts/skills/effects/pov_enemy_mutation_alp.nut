this.pov_enemy_mutation_alp <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_alp";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Alp\'s Resistance [/color]";
		this.m.Description = "This enemy has some properties of an Alp! They are not affected by the night, and are resistant to ranged attacks.";
		this.m.Icon = "skills/pov_alp_mutant.png";
		this.m.IconMini = "pov_mini_alp_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are not affected by the night, and are resistant to ranged attacks.";
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
				icon = "ui/icons/pov_time_of_day.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]decent[/color] resistance to ranged attacks"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fatigue recovery reduced by [color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]."
			}
		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Alp));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.IsAffectedByNight = false;
		// Debuffs
		_properties.FatigueRecoveryRate += -5;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.70; 
				}
				else
				{					
					if (_skill.isRanged())
					{				
						local weapon = _skill.getItem();
						if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
						{
							if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
							{
								_properties.DamageReceivedRegularMult *= 0.4;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(this.Const.Items.WeaponType.Firearm))
							{
								_properties.DamageReceivedRegularMult *= 0.55;
							}
							else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
							{
								if (_skill.getID() == "actives.throw_spear")
								{
									_properties.DamageReceivedRegularMult *= 0.65;
								}
								else
								{
									_properties.DamageReceivedRegularMult *= 0.5;
								}								
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.5;
							}
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.7;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.7;
					}
				}
				break;
		}
	}

});
