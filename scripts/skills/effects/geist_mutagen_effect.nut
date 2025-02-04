this.geist_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.geist_mutagen";
		this.m.Name = "Mutation: Spirit";
		this.m.Icon = "skills/geist.png";
		this.m.IconMini = "";
		this.m.Overlay = "geist";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Phase Coating[/color]: This character is able to secrete a substance that vibrates rapidly when stimulated. When applied to weapons, this aids in armor penetration.";
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
				icon = "ui/icons/direct_damage.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of damage ignores armor when using melee weapons"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageDirectMeleeAdd += 0.25;
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

