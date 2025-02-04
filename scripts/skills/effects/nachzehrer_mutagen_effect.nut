this.nachzehrer_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.nachzehrer_mutagen";
		this.m.Name = "Mutation: Ghoul";
		this.m.Icon = "skills/nachzehrer.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Hyperactive Tissue Growth[/color]: This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Wounds heal much faster than normal as a result.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Frenzied Attacks[/color]: This character\'s movements have become eratic and blidingly fast.  Any opponent engaged in battle with them will have their resolve tested.";
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
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] initiative."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]."
			}
		];
		return ret;
	}


	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1.2;
		_properties.Threat += 5;
		_properties.HitpointsRecoveryRateMult *= 3.0;
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

