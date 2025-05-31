this.pov_missing_hp_dmg_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_missing_hp_dmg_effect";
		this.m.Name = "Hp Weakness";
		this.m.Description = "The Vatt\'ghern\'s unhold mutation restricts their damage output, if their hp is lower than maximum.";
		this.m.Icon = "skills/pov_troll.png";
		this.m.IconMini = "pov_mini_troll";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The Vatt\'ghern\'s unhold mutation restricts their damage output, if their hp is lower than maximum. The reduction is [color=" + this.Const.UI.Color.NegativeValue + "]1%[/color] less damage, for each [color=" + this.Const.UI.Color.NegativeValue + "]2%[/color] of missing hp.\n\n This affects only weapons that require muscle work to effectively use, similarly to the mascularity perk (so crossbows are unaffected for example)";
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
			// HANDLED BY getHpDmgPen
			/*
			local actor = this.getContainer().getActor();
			local maxHp = actor.getHitpointsMax();
			local Hp = actor.getHitpoints();
			local currentHpPercent = (Hp * 100) / maxHp;
			local missingHpPercent = 100 - currentHpPercent;

			local damagePenalty = this.Math.maxf(0, missingHpPercent / 2) * 0.01; 

			if (damagePenalty >= 1)
			{	
				// This is me being paranoic xd
				damagePenalty = 1;
			}

			local finalDamageMult = 1 - damagePenalty;
			*/
			_properties.DamageTotalMult *= getHpDmgPen();

		}
	}

});
