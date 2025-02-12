this.strain_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.strain_mutagen";
		this.m.Name = "Mutation: The Strain";
		this.m.Icon = "skills/necro.png";
		this.m.IconMini = "";
		this.m.Overlay = "necro";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Dark Visions[/color]: This character has strange visions of things that have been and things to come.  It gives them a certain ability to connect and internalize new experiences faster. On the other hand, these same visions cause extreme distress to the Vatt\'ghern\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Reactive Muscle Tissue[/color]: This character\'s body reacts to physical trauma, secreting a calciferous substance that causes their muscles to reflexively sieze and contract at points of impact to minimize muscle damage.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Subdermal Reactivity[/color]: This character\'s subdermal flesh has mutated and automatically reacts to sudden trauma, lessening the chance to suffer injuries in battle.";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Experience Gain"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character accumulates no Fatigue from enemy attacks."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]25% + 10[/color] Resolve, due to dark visions"
			},
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 1.25;
		_properties.FatigueLossOnAnyAttackMult = 0.0;
		_properties.ThresholdToReceiveInjuryMult *= 1.50;
		_properties.BraveryMult *= 0.75;
		_properties.Bravery += -10;
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

