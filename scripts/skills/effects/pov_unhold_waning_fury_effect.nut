this.pov_unhold_waning_fury_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_unhold_waning_fury";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Waning Fury[/color]";
		this.m.Description = "This beast thrives on brute strength. The healthier it is, the harder it hits, but as it takes wounds, its power wanes.";
		this.m.Icon = "skills/pov_troll.png";
		this.m.IconMini = "pov_mini_troll";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This beast thrives on brute strength. The healthier it is, the harder it hits, but as it takes wounds, its power wanes.";
	}

	function getTooltip()
	{
		local penalty = this.Math.floor(100 - (getHpDmgPen() * 100));
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
			    icon = "ui/icons/health.png",
			    text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]"+penalty+"[/color] % less damage due to missing health."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/health.png",
			    text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] more max HP"
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/damage_dealt.png",
			    text = "Deals [color=" + this.Const.UI.Color.PositiveValue + "]12%[/color] more damage at max HP"
			}

		];
		return ret;
	}

	function getHpDmgPen()
	{
			local actor = this.getContainer().getActor();
			local maxHp = actor.getHitpointsMax();
			local Hp = actor.getHitpoints();
			local currentHpPercent = (Hp * 100) / maxHp;
			local missingHpPercent = 100 - currentHpPercent;

			// 50% less damage on 1% health, 25% less dmg on 50% health
			local damagePenalty = this.Math.maxf(0, missingHpPercent / 2) * 0.01; 

			if (damagePenalty >= 1)
			{	
				// This is me being paranoic xd
				damagePenalty = 1;
			}

			local finalDamageMult = 1 - damagePenalty;

			return finalDamageMult;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		local isValidRanged = item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && (item.isWeaponType(this.Const.Items.WeaponType.Throwing) || item.isWeaponType(this.Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(this.Const.Items.ItemType.Weapon)))
		{
			_properties.DamageTotalMult *= getHpDmgPen();
		}
	}

	function onUpdate (_properties)
	{
		_properties.HitpointsMult *= 1.10;
		_properties.DamageTotalMult *= 1.12;
	}

});
