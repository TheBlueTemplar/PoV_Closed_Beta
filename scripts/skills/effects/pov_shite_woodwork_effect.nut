this.pov_shite_woodwork_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//I mean, it is fooken shite
	},
	function create()
	{
		this.m.ID = "effects.pov_shite_woodwork";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Shite Woodwork[/color]";
		this.m.Description = "Who built this?";
		this.m.Icon = "skills/pov_catapult.png";
		this.m.IconMini = "pov_mini_catapult";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Who built this?";
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
				icon = "ui/icons/health.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]75%[/color] less hitpoints."
			}
		];
		return ret;
	}
	
	function onUpdate(_properties)
	{
		_properties.HitpointsMult *= 0.25;
	}

});
