this.pov_coat_with_acid_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_coat_with_acid";
		this.m.Name = "Coat with Acid";
		this.m.Description = "The character slashes themselves, coating their weapon in their corrosive blood. \n\n Slightly damages both themselves and their weapon.";
		this.m.Icon = "skills/pov_active_acid_coat.png";
		this.m.IconDisabled = "skills/pov_active_acid_coat_sw.png";
		this.m.Overlay = "active_139";
		this.m.SoundOnUse = [
			"sounds/combat/pov_coat_acid_01.wav",
			"sounds/combat/pov_coat_acid_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 8;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next attack will be 20% more effective against armor and apply the [color=" + this.Const.UI.Color.PositiveValue + "]acid[/color] status effect on the hit enemy, further corroding their armor."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "On use, the character takes damage equal to [color=" + this.Const.UI.Color.NegativeValue + "]8%[/color] of their max health, and their weapon loses [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] of its max durability."
			},
		];

		local actor = this.getContainer().getActor();
		local poison = actor.getSkills().getSkillByID("effects.pov_acid_coat");
		//fallback
		if (poison != null)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Cannot be used because this character already has this effect[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local poison = actor.getSkills().getSkillByID("effects.pov_acid_coat");

		if (actor.getMainhandItem() == null){return false;}
		if (poison != null){return false;}else{return true;}
	}

	function onUse( _user, _targetTile )
	{
		// Damage Self (8% Max Hp)
		local actor = this.getContainer().getActor();
		local maxHp = actor.getHitpointsMax();
		local damageTaken = maxHp * 0.08;

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damageTaken;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		actor.onDamageReceived(actor, this, hitInfo);

		// Damage Weapon (10% Max Durability)
		local mainhand = actor.getMainhandItem();
		local weaponDamage = mainhand.m.ConditionMax * 0.10;

		mainhand.m.Condition -= weaponDamage;

		// Apply Acid
		local poison = _user.getSkills().getSkillByID("effects.pov_acid_coat");

		//fallback
		if (poison != null)
		{
			poison.resetTime();
		}
		else
		{
			this.m.Container.add(this.new("scripts/skills/effects/pov_acid_coat_effect"));
		}

		return true;
	}

});

