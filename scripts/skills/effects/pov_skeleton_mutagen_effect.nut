this.pov_skeleton_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_skeleton_mutagen";
		this.m.Name = "Mutation: Undeath";
		this.m.Icon = "skills/pov_skeleton.png";
		this.m.IconMini = "";
		this.m.Overlay = "skele";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Curse Essence[/color]: This character\'s body is sustained by the curse of undeath.  They require less food and have increased stamina.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Synapse Blockage[/color]: This character\'s body has mutated in such a way that their emotions have become muted, especially preventing the character from reaping the benefits of high morale, but also making morale attacks against them weaker\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Subdermal Stitching[/color]: This character\'s skin and subdermal tissue has mutated and will rapidly stitch back together, increasing piercing damage resistance. On the other hand, open wounds take more time to fully heal";
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
				icon = "ui/icons/asset_daily_food.png",
				text = "This character consumes [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] less food."
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
				icon = "ui/icons/bravery.png",
				text = "Has a bonus of [color=" + this.Const.UI.Color.PositiveValue + "]20[/color] on all morale checks."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "This character\'s lost health recovers [color=" + this.Const.UI.Color.NegativeValue + "]60%[/color] slower."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] more damage from fire attacks."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will never be of [color=" + this.Const.UI.Color.NegativeValue + "]confident[/color] morale."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.StaminaMult *= 1.1;
		//_properties.Bravery *= 1.2;
		_properties.DailyFood *= 0.25;

		// Debuffs
		_properties.HitpointsRecoveryRateMult *= 0.4;

		local actor = this.getContainer().getActor();
		actor.setMaxMoraleState(this.Const.MoraleState.Steady);

		if (actor.getMoraleState() > this.Const.MoraleState.Steady)
		{
			actor.setMoraleState(this.Const.MoraleState.Steady);
			//actor.setDirty(true);
		}
	}

	// THIS HAS NOT BE FULLY TESTED
	function checkMorale( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		_difficulty = _difficulty + 20;
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

