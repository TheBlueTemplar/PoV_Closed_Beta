this.pov_exhausted_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.pov_exhausted";
		this.m.Name = "Mentally Exhausted";
		this.m.Description = "This character is mentally exhausted. For a few days, they will not be able to learn new things easily.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury | this.Const.SkillType.DrugEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = false;
		this.m.HealingTimeMin = 4;
		this.m.HealingTimeMax = 5;
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
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Gains [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] less experience points."
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();
	}

	function onRemoved()
	{
		
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.XPGainMult *= 0.5;
	}

});

