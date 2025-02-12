this.direwolf_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsUsed = {},
		ArmorPenalty = 0
	},
	function create()
	{
		this.m.ID = "effects.direwolf_mutagen";
		this.m.Name = "Mutation: Beast";
		this.m.Icon = "skills/werewolf.png";
		this.m.IconMini = "";
		this.m.Overlay = "werewolf";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Elasticized Sinew[/color]: This character\'s muscles have mutated to become highly efficient, increasing the character\'s stamina while moving and fighting.\n\n [color=" + this.Const.UI.Color.PositiveValue + "]Enhanced Vision[/color]: This character\'s eyes have mutated to adapt rapidly to low light conditions, halving nighttime penalties.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Subdermal Clotting[/color]: A powerful clotting agent in the skin makes this character immune to bleeding effects.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Adaptive Exoskeleton[/color]: Due to structural mutations in the character's body, effectively using body armor, especially the heavier kinds, is much more difficult.";
	}

	function getPenalty()
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}
	
		local armorFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Body);
		local helmetFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Head);
		local totalPen = armorFatPen + helmetFatPen;
		local penalty = totalPen * 0.4;
		return penalty;
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
				icon = "ui/icons/fatigue.png",
				text = "Movement costs [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less Fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Skills cost [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] less fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Nighttime penalties are [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to bleeding effects."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The fatigue and initiative penalty from wearing armor is increased by [color=" + this.Const.UI.Color.NegativeValue + "]40%[/color]."
			},
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostMult *= 0.5;
		//_properties.MovementFatigueCostAdditional *= 0.5;
		//_properties.IsAffectedByNight = false;
		_properties.FatigueEffectMult *= 0.85;
		_properties.IsImmuneToBleeding = true;
		_properties.Stamina += this.getPenalty();
		_properties.Initiative += this.getPenalty();

		if (this.getContainer().hasSkill("special.night") && _properties.IsAffectedByNight)
		{
			_properties.Vision += 1;
			_properties.RangedSkillMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
		}
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

 