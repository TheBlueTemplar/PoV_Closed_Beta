this.pov_thirdeye_buff_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_thirdeye_buff";
		this.m.Name = "Increased Insight";
		this.m.Description = "Thanks to the very clear information they have over the battlefield, this character has increased resolve and ranged performance.";
		this.m.Icon = "skills/pov_thirdeye_buff.png";
		this.m.IconMini = "pov_mini_thirdeye_buff";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Thanks to the very clear information they have over the battlefield, this character has increased resolve and ranged performance.";
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
				icon = "ui/icons/ranged_defense.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+4[/color] Ranged Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+4[/color] Ranged Skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Gain + [color=" + this.Const.UI.Color.PositiveValue + "]+4[/color] Bravery."
			}

		];

		if (this.m.TurnsLeft >= 1)
		{
			ret.extend([
				{
					id = 7,
					type = "hint",
					icon = "ui/icons/special.png",
					text = "This effect will last for [color=" + this.Const.UI.Color.NegativeValue + "]"+this.m.TurnsLeft+"[/color] more turns"
				}
			]);
		}

		return ret;
	}

	function onAdded() 
	{
		this.m.TurnsLeft = 2;
		this.spawnIcon("pov_medium_thirdeye_buff", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.Bravery += 4;
		_properties.RangedDefense += 4;
		_properties.RangedSkill += 4;
	}

	function onTurnEnd()
	{
		this.m.TurnsLeft -= 1;

		if (this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
