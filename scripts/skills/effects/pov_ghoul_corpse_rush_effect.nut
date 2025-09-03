this.pov_ghoul_corpse_rush_effect <- this.inherit("scripts/skills/skill", {
	m = {
		StartingEntities = 0,
		CountedEntities = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_ghoul_corpse_rush";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Scavenger\'s Surge![/color]";
		this.m.Description = "With every fresh corpse, the ghouls grow bolder, swifter, and more difficult to strike. The scent of death ignites something primal in them, a ravenous urge to feast, to frenzy, to overwhelm.";
		this.m.Icon = "skills/pov_ghoul.png";
		this.m.IconMini = "pov_mini_ghoul";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "With every fresh corpse, the ghouls grow bolder, swifter, and more difficult to strike. The scent of death ignites something primal in them, a ravenous urge to feast, to frenzy, to overwhelm.";
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
			    text = "If less than [color=" + this.Const.UI.Color.NegativeValue + "]6[/color] allies are alive, then this entity loses [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] Resolve and Initiative, and [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Melee Skill, as well as the above buffs."
			},
		];
		return ret;
	}

	function calculateBonus()
	{
		if (!("Entities" in this.Tactical))
		{
			return [0, 0];
		}
		if (this.Tactical.Entities == null)
		{
			return [0, 0];
		}
		if (!this.Tactical.isActive())
		{
			return [0, 0];
		}

		local actor = this.getContainer().getActor();
		local entities = this.Tactical.Entities.getAllInstancesAsArray();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local allyCount = 0;
		local entityCount = 0;
		local deadEnemies = 0;
		local buff = 0;

		foreach( entity in entities )
		{
			if(entity.isPlacedOnMap())
			{
				entityCount += 1;				
			}
		}

		// All of the ally counting shit and the functions below, are to make sure that the calculation is done right
		foreach( ally in allies )
		{
			if(ally.isPlacedOnMap())
			{
				allyCount += 1;				
			}
		}

		if (this.Time.getRound() <=1 && this.m.CountedEntities <= allyCount && entityCount != 0)
		{
			this.m.StartingEntities = entityCount;
			this.m.CountedEntities += 1;
		}

		if (this.m.StartingEntities <= 0){
			::TLW.Mod.Debug.printLog("Starting Entities Not Counted!");
			//::TLW.Mod.Debug.printLog("Start Entities:: " + this.m.StartingEntities + "Entity Count:: " + entityCount + "Counted?: " + this.m.CountedEntities);
			return [0,0];
		}

		deadEnemies = this.m.StartingEntities - entityCount;
		buff = 100 - ((entityCount * 100) / this.m.StartingEntities); // that is a percent of the dead enemies, eg. 50
		//::TLW.Mod.Debug.printLog("Start Entities:: " + this.m.StartingEntities + "Entity Count:: " + entityCount + " Dead Enemies: " + deadEnemies + " Buff%: " + buff);
		return [deadEnemies, buff * 0.01]; // reurns all entities sum, and then this is sth like 0.5
	}

	function onUpdate( _properties )
	{
		local dead = calculateBonus();
		if(dead[0] >= 1)
		{
			this.m.Name = "[color=#5c3a01]Scavenger\'s Surge (x"+ dead[0] +")[/color]";
			_properties.MeleeSkillMult += dead[1];
			_properties.MeleeDefenseMult += dead[1]*2;
			_properties.InitiativeMult += dead[1]*1.25;
		}

		if(dead[1] >= 0.5)
		{
			this.m.Name = "[color=#5c3a01]Scavenger\'s Surge (Hightened) (x"+ dead[0] +")[/color]";
			_properties.MeleeSkill += 5;
			_properties.MeleeDefense += 5;
			_properties.Initiative += 5;
		}
	}

});
