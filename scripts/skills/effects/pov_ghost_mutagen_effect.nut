this.pov_ghost_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_ghost_mutagen";
		this.m.Name = "Mutation: Spirit";
		this.m.Icon = "skills/pov_geist.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Phase Coating[/color]: This character is able to secrete a substance that vibrates rapidly when stimulated. When applied to weapons, this aids in armor penetration. This very coating though reduces the damage done to armor itself.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Screaming Strikes[/color]: This character\'s strikes carry the echo of lost, vengeful souls, inflicting as much mental harm as physical to the enemies.";
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
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
				text = "Gain the [color=" + this.Const.UI.Color.PositiveValue + "]Fearsome[/color] Perk. (Or gain +10 Resolve if the Vatt'ghern already had the perk)."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] armor penetration, with an additional flat bonus of [color=" + this.Const.UI.Color.PositiveValue + "]5[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Do [color=" + this.Const.UI.Color.NegativeValue + "]40%[/color] less damage to armor."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.DamageDirectAdd += 0.05;
		_properties.DamageDirectMult += 0.20;
		// Debuffs
		_properties.DamageArmorMult *= 0.6;
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

