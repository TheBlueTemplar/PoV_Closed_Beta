this.hexe_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.hexe_mutagen";
		this.m.Name = "Mutation: Hexen";
		this.m.Icon = "skills/witch.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Sympathetic Call[/color]: There\'s something different about this character. Physically they seem unchanged, yet somehow a sense of dread precedes them. Any harm that they endure, on or off the battlefield, seems to affect another nearby. Useful in a fight, annoying in camp, and surely isolating in every day society.";
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
				text = "Reflect [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] of hitpoint damage received back at the attacker"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] chance to have any attacker require two successful attack rolls in order to hit."
			}
		];
		return ret;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints > 0 && _attacker != null && _attacker.isAlive() && _attacker.getHitpoints() > 0 && _attacker.getID() != this.getContainer().getActor().getID() && !_attacker.getCurrentProperties().IsImmuneToDamageReflection)
		{
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = _damageHitpoints;
			hitInfo.DamageArmor = 0.0;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_attacker.onDamageReceived(_attacker, null, hitInfo);
		}
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += 25;
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

//_properties.RerollDefenseChance += 15;
