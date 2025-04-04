this.pov_donkey_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_donkey_mutagen";
		this.m.Name = "Mutation: Donkey";
		this.m.Icon = "skills/pov_donkey.png";
		this.m.IconMini = "";
		this.m.Overlay = "donkey";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Strong Back[/color]: This character has enhanced back structure and musles, allowing them to carry more things. Pack animals watch out!\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Unusual Mutagen[/color]: This mutation appears to not be as invasive as the other ones, allowing this character to have this along with other mutations easily.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]Increased Stubborness[/color]: This character appears to be much more stubborn than usual, showing similar symptoms to lower intellect, making learning anything new a little harder.";
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
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Experience Gain"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "This character gains [color=" + this.Const.UI.Color.PositiveValue + "]+8[/color] max fatigue."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.Stamina += 8;
		// Debuffs
		_properties.XPGainMult *= 0.90;
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

