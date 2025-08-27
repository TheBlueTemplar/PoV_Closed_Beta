this.pov_hyena_pack_mentality_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//AllyAmount = 0
		MaxBuff = 20
	},
	function create()
	{
		this.m.ID = "effects.pov_hyena_pack_mentality";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Pack Mentality[/color]";
		this.m.Description = "This entity has a furious bond with their pack! So long as the others still breathe, it fights with the tenacity of a cornered beast—every ally standing feeds his will to live and kill.";
		this.m.Icon = "skills/pov_hyena.png";
		this.m.IconMini = "pov_mini_hyena";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This entity has a furious bond with their pack! So long as the others still breathe, it fights with the tenacity of a cornered beast—every ally standing feeds his will to live and kill.";
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
			    icon = "ui/icons/melee_skill.png",
			    text = "Gets +[color=" + this.Const.UI.Color.PositiveValue + "] 1 [/color]Melee Skill and Resolve for each ally alive. This bonus stacks up to "+ this.m.MaxBuff +" allied entities."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/initiative.png",
			    text = "Also gets [color=" + this.Const.UI.Color.PositiveValue + "]half[/color] of the above bonus to Initiative."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/warning.png",
			    text = "If less than [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] allies are alive, then this entity loses [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] Resolve and Initiative, and [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Melee Skill, as well as the above buffs."
			},
		];
		return ret;
	}
	function calculateBonus()
	{
		local actor = this.getContainer().getActor();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local allyCount = 0;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			allyCount += 1;
		}
		return allyCount;
	}
	

	function onTurnStart()
	{
		::TLW.Mod.Debug.printLog("Hyenas Ally Count:" + calculateBonus());
	}

	function onUpdate( _properties )
	{
		local allies = calculateBonus();
		if(allies >= 5)
		{
			this.m.Name = "[color=#5c3a01]Pack Mentality (x"+ allies +")[/color]";
			_properties.MeleeSkill += allies;
			_properties.Bravery += allies + (allies * 0.5);
			_properties.Initiative += allies;
			_properties.SurroundedBonus += 2;
		}
		else if(allies >= 19)
		{
			this.m.Name = "[color=#5c3a01]Pack Mentality (x20)(Max)[/color]";
			_properties.MeleeSkill += 20;
			_properties.Bravery += 30;
			_properties.Initiative += 20;
			_properties.SurroundedBonus += 3;
		}
		else if (allies < 5)
		{
			this.m.Name = "[color=#5c3a01]Pack Mentality (Losing)[/color]";
			_properties.MeleeSkill -= 5;
			_properties.Bravery -= 10;
			_properties.Initiative -= 10;
		}
	}

});
