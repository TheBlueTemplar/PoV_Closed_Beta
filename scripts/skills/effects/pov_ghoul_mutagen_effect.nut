this.pov_ghoul_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_ghoul_mutagen";
		this.m.Name = "Mutation: Ghoul";
		this.m.Icon = "skills/pov_ghoul.png";
		this.m.IconMini = "";
		//this.m.Overlay = "status_effect_149";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Hyperactive Tissue Growth[/color]: This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal, vastly increasing regeneration. On the other hand, the user becomes more prone to injuries thanks to cellular instability.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Frenzied Attacks[/color]: This character\'s movements have become eratic and blidingly fast, vastly increasing initiative. This also renders the user almost unable to properly use ranged weapons though, while also slightly lowering their damage output.\n\n [color=" + this.Const.UI.Color.PositiveValue + "]Terrifying Presence[/color]: Any opponent engaged in battle with them will have their resolve tested. ";
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
				icon = "ui/icons/days_wounded.png",
				text = "Lost health regenerates 3x faster than normal."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] initiative."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.PositiveValue + "]-12[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] melee damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Injury threshold reduced by [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color]."
			}
		];
		return ret;
	}


	function onUpdate( _properties )
	{
		// Buffs
		_properties.InitiativeMult *= 1.2;
		_properties.Threat += 12;
		_properties.HitpointsRecoveryRateMult *= 3.0;
		// Debuffs
		_properties.ThresholdToReceiveInjuryMult *= 0.75;
		_properties.RangedSkillMult *= 0.50;
		_properties.MeleeDamageMult *= 0.90;
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

