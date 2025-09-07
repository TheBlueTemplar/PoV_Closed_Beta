this.pov_missing_hp_dmg_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_missing_hp_dmg_effect";
		this.m.Name = "Colossal Strength";
		this.m.Description = "The Vatt\'ghern\'s unhold mutation restricts their damage output, if their hp is lower than maximum.";
		this.m.Icon = "skills/pov_troll.png";
		this.m.IconMini = "pov_mini_troll";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "The Vatt\'ghern\'s unhold mutation affects their damage potential. While at max Hp, they have a [color=" + this.Const.UI.Color.PositiveValue + "]damage bonus %[/color] equal to 8% of their max hp (caps at 20% Bonus). Damage bonus scales down until current Hp is 75% of max.\n\n While under 75% of max HP, the vattghern deals [color=" + this.Const.UI.Color.NegativeValue + "]less[/color] damage, scaling linearly with missing HP. (-15% Damage, for each 25% missing HP below the 75% mark). \n\n This affects only weapons that require muscle work to effectively use, similarly to the mascularity perk (so crossbows are unaffected for example)";
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
			}

		];

		local dmgMod = getHpDmgMod();

		if (dmgMod >= 1.0)
		{
			dmgMod = this.Math.floor((dmgMod * 100) - 100);
			ret.push({
			    id = 11,
			    type = "text",
			    icon = "ui/icons/health.png",
			    text = "Deals [color=" + this.Const.UI.Color.PositiveValue + "]"+dmgMod+"[/color] % more damage due to high health."
			});
		} else {
			dmgMod = this.Math.floor(100 - (dmgMod * 100));
			ret.push({
			    id = 11,
			    type = "text",
			    icon = "ui/icons/health.png",
			    text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]"+dmgMod+"[/color] % less damage due to missing health."
			});
		}

		return ret;
	}

	// + Scaling Damage when > 75% Hp, - Damage when < 75% Hp 
	function getHpDmgMod()
	{
	    local actor = this.getContainer().getActor();
	    local maxHp = actor.getHitpointsMax();
	    // Actors current hp %, value is from 0.00 - 1.00, so I multiply with 100 to get %
	    local currentHpPercent = actor.getHitpointsPct() * 100; 

    	// how much of MaxHP turns into % damage at 100% HP
   		// e.g., 0.08 => "+8% of MaxHP" becomes +12% dmg if MaxHP=150
   		local maxHpBonusMult = 0.08;
   		local maxHpBonus = (maxHp * maxHpBonusMult) / 100;

   		// Cap the bonus on 20% Bonus Damage
   		if (maxHpBonus > 0.20) maxHpBonus = 0.20;

	    if (currentHpPercent < 75)
	    {	
	    	// 0% → 75% HP: 0.55 → 1.00 Dmg Mult (linear)
		    return this.Math.min(1.0,0.55 + (currentHpPercent / 75.0) * 0.45);  // 0.55 → 1.0
	    }
		else
		{
			// 75% → 100% HP: 1.00 → 1.00 + maxHpBonus Dmg Mult (linear)
		    return this.Math.max(1.0,1.0 + (maxHpBonus * (currentHpPercent - 75.0) / 25.0)); // 1.0 → 1.0+bonus
		}
	}
	/*
	// Interpolation Example - Works Fine
	// See points table below for exact values
	function getHpDmgMod()
	{
	    local actor = this.getContainer().getActor();
	    local maxHp = actor.getHitpointsMax();
	    local Hp = actor.getHitpoints();

	    // Schizo fallbacks
	    if (maxHp <= 0) return 0.01;
	    if (Hp <= 0) return 0.01;

	    local currentHpPercent = (Hp * 100.0) / maxHp;

	    // clamp to [0,100] just in case
    	if (currentHpPercent < 0) currentHpPercent = 0.0;
    	if (currentHpPercent > 100) currentHpPercent = 100.0;

    	// how much of MaxHP turns into % damage at 100% HP
   		// e.g., 0.08 => "+8% of MaxHP" becomes +12% dmg if MaxHP=150
   		local maxHpBonusMult = 0.08;
   		local maxHpBonus = (maxHp * maxHpBonusMult) / 100;

   		// Cap the bonus on 20% Bonus Damage
   		if (maxHpBonus > 0.20) maxHpBonus = 0.20;

	    // Define breakpoints: [HP%, Damage Multiplier - 100% is dynamic]
	    // Multiplier = 1.0 means base damage
	    local points = [
	        [100, 1.00 + maxHpBonus],  // 100% HP -> +8% of Max HP, Cap 20% on 250HP
	        [75,  1.00],  // 75% HP  -> base
	        [50,  0.85],  // 50% HP  -> -15%
	        [25,  0.70],  // 25% HP  -> -30%
	        [0,   0.55]   // ~0% HP  -> -45%
	    ];

	    // Find which segment current HP falls into
	    // Piecewise-linear interpolation across the whole table
	    local finalDamageMult = points[points.len()-1][1]; // fallback to lowest table value

	    for (local i = 0; i < points.len() - 1; i++)
	    {
	        local pHigh = points[i];      // higher HP%
	        local pLow  = points[i + 1];  // lower  HP%

	        if (currentHpPercent >= pLow[0] && currentHpPercent <= pHigh[0])
	        {
	            local t = (currentHpPercent - pLow[0]) / (pHigh[0] - pLow[0]); // [0..1]
	            finalDamageMult = pLow[1] + (pHigh[1] - pLow[1]) * t;
	            break;
	        }
	    }

	    return finalDamageMult;
	}*/

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		local isValidRanged = item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && (item.isWeaponType(this.Const.Items.WeaponType.Throwing) || item.isWeaponType(this.Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(this.Const.Items.ItemType.Weapon)))
		{
			_properties.DamageTotalMult *= getHpDmgMod();
		}
	}

});
