this.alp_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.alp_mutagen";
		this.m.Name = "Mutation: Alp";
		this.m.Icon = "skills/alp.png";
		this.m.IconMini = "";
		this.m.Overlay = "alp";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Enhanced Vision[/color]: This character\'s eyes have mutated to respond faster and more drastically to low light environments. As a result, they have night vision nearly on par with their sight during the day.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Third Eye[/color]: This character has developed the ability to percieve their surroundings. While the character can now peek into the uknown, they suddenly show a struggle to recall some of their memory. \n\n[color=" + this.Const.UI.Color.PositiveValue + "]Mutated Lungs[/color]: This character\'s lungs have mutated to assist in filtering contaminants in harmful environments. This filtering process stresses the lungs a little bit more though.";
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
				icon = "ui/icons/special.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Gain the [color=" + this.Const.UI.Color.PositiveValue + "]Third Eye[/color] skill, and an additional [color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] vision"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only take [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of damage inflicted by harmful miasmas"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color] Experience Gain."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Fatigue recovery reduced by [color=" + this.Const.UI.Color.NegativeValue + "]-1[/color]."
			}

		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByNight = false;
		_properties.IsResistantToMiasma = true;
		_properties.Vision += 1;
		_properties.XPGainMult *= 0.70;
		_properties.FatigueRecoveryRate += -1;
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function onAdded()
	{
		
		if (!this.m.Container.hasSkill("actives.thirdeye_skill"))
		{
			this.m.Container.add(::new("scripts/skills/actives/thirdeye_skill"));
		}
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

 