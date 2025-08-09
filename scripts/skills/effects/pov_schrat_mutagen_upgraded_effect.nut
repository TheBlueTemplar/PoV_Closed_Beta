this.pov_schrat_mutagen_upgraded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		HeadArmorBoost = 40,
		HeadDamageTaken = 0,
		BodyArmorBoost = 40,
		BodyDamageTaken = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_schrat_mutagen_upgraded";
		this.m.Name = "[color=#012810]Reinforced Mutation: Greenwood Schrat[/color]";
		this.m.Icon = "skills/pov_schrat_greenwood.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Flexile Ligaments[/color]: This character\'s legs have mutated to respond with unnatural force and stability, allowing them to resist any attempt to be displaced. Their stance remains firm, even against powerful external forces.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Barkskin[/color]: This character\'s skin has become incredibly rigid, forming a natural armor that absorbs a portion of incoming damage. When bearing a shield, their defensive instincts sharpen further, providing them the best resilience.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]Encumbered Frame[/color]: The weight of their altered form makes movement far more taxing, causing them to tire slightly quicker when repositioning. Without a shield to balance their hardened structure, they become weaker to incoming attacks.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Flammable Carapace[/color]: The mutation has an unfortunate drawback—while their body is tougher than normal, it is also highly susceptible to fire, causing them to suffer extreme burns when exposed to flames, though the body has adapted, and is not as reactive as it used to be.";
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
				text = "This character\'s skin is hard, granting [color=" + this.Const.UI.Color.PositiveValue + "]40[/color] points of natural armor"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "When equipped with a shield, gain [color=" + this.Const.UI.Color.PositiveValue + "]+16[/color] to all defences, and [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] damage resistance"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Movement costs [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color] more fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]125%[/color] more damage from fire attacks."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]+10%[/color] damage when not using a shield."
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Fallbacks/Attempts to fix some shet
		if(this.m.HeadDamageTaken < 0) {this.m.HeadDamageTaken = 0;}
		if(this.m.BodyDamageTaken < 0) {this.m.BodyDamageTaken = 0;}
		
		// Buffs
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.Armor[this.Const.BodyPart.Head] += this.Math.max(0.0, this.m.HeadArmorBoost - this.m.HeadDamageTaken);
		_properties.Armor[this.Const.BodyPart.Body] += this.Math.max(0.0, this.m.BodyArmorBoost - this.m.BodyDamageTaken);
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.m.HeadArmorBoost;
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.m.BodyArmorBoost;
		// Debuffs
		_properties.MovementFatigueCostMult *= 1.15;
		// No shield Effect

		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			_properties.DamageReceivedRegularMult *= 0.70;
			_properties.MeleeDefense += 16;
			_properties.RangedDefense += 16;
		}else{
			_properties.DamageReceivedRegularMult *= 1.10;
			if (!actor.getSkills().hasSkill("scripts/skills/effects/pov_schrat_no_shield_effect"))
			{
				actor.getSkills().add(this.new("scripts/skills/effects/pov_schrat_no_shield_effect"));
			}
		}
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
		//_properties.DamageReceivedRegularMult *= 0.90;

		// Fallbacks/Attempts to fix some shet
		if(this.m.HeadDamageTaken < 0) {this.m.HeadDamageTaken = 0;}
		if(this.m.BodyDamageTaken < 0) {this.m.BodyDamageTaken = 0;}

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

		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 1.25;
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


