this.pov_hexe_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 0.05
	},
	function create()
	{
		this.m.ID = "effects.pov_hexe_mutagen";
		this.m.Name = "Mutation: Hexen";
		this.m.Icon = "skills/pov_hexe.png";
		this.m.IconMini = "";
		this.m.Overlay = "witch";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Whispered Bargains[/color]: This character’s silver tongue secures better trade deals and lowers the cost of hiring fresh recruits. Tryout fees are reduced, and more candidates become available.\n\n [color=" + this.Const.UI.Color.PositiveValue + "]Thread of Fate[/color]: Attacks against this character sometimes falter at the last moment, as if fate itself intervenes to turn aside deadly blows.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Marked by the Unknown[/color]: Enemies feel an unnatural pull toward this character, making them a more frequent target in battle. Strange misfortunes tend to follow them, both on and off the battlefield.";
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
			/*{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reflect [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] of hitpoint damage received back at the attacker"
			},*/
			{
				id = 10,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5.0%[/color] barter skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Makes you pay [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] less for hiring new men, and [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] less for tryouts"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_luck.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]12%[/color] chance to have any attacker require two successful attack rolls in order to hit."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Enemies are [color=" + this.Const.UI.Color.NegativeValue + "]more likely[/color] to attack this character"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "There is a chance for various [color=" + this.Const.UI.Color.NegativeValue + "]negative events[/color] to happen, related to this character"
			}
		];
		return ret;
	}

	// No need for that, too broken, left for future reference if needede
	// Damage Reflect Code
	/*function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints > 0 && _attacker != null && _attacker.isAlive() && _attacker.getHitpoints() > 0 && _attacker.getID() != this.getContainer().getActor().getID() && !_attacker.getCurrentProperties().IsImmuneToDamageReflection)
		{
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = _damageHitpoints; //bruh, 100% reflect? seems overkill for a passive imo
			hitInfo.DamageArmor = 0.0;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_attacker.onDamageReceived(_attacker, null, hitInfo);
		}
	}*/

	function onUpdate( _properties )
	{
		// Buffs
		_properties.RerollDefenseChance += 12;
		// Debuffs
		_properties.TargetAttractionMult *= 1.2;
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

	// Meant to add skills for the hexe effect, ignore for now
	/*function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.pov_charm")) //check for one skill should be enough, as they are given together, therefore we cant miss even one
		{
			//this.m.Container.add(::new("scripts/skills/actives/pov_hexe_charm_skill"));
			//this.m.Container.add(::new("scripts/skills/actives/pov_hexe_curse_skill"));
			//this.m.Container.add(::new("scripts/skills/actives/pov_hexe_hex_skill"));
		}
	}*/

	function getModifier()
	{
		return this.m.Amount;
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
	}

});

