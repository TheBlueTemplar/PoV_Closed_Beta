this.pov_vattghern_corpse_rush_effect <- this.inherit("scripts/skills/skill", {
	m = {
		StartingEntities = 0,
		CountedEntities = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_vattghern_corpse_rush";
		this.m.Name = "Scavenger\'s Surge!";
		this.m.Description = "With every fresh corpse, the vattghern grows bolder, swifter, and more difficult to strike. The scent of death ignites something primal in them, a ravenous urge to feast, to frenzy, to overwhelm.";
		this.m.Icon = "skills/pov_ghoul.png";
		this.m.IconMini = "pov_mini_ghoul";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "With every fresh corpse, the vattghern grows bolder, swifter, and more difficult to strike. The scent of death ignites something primal in them, a ravenous urge to feast, to frenzy, to overwhelm.";
	}

	function getTooltip()
	{
		local dead = calculateBonus();
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
			    text = "Gets +[color=" + this.Const.UI.Color.PositiveValue + "]"+ dead[1]*35 +"[/color]% Melee Skill due to sensing the dead"
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_defense.png",
			    text = "Gets +[color=" + this.Const.UI.Color.PositiveValue + "]"+ dead[1]*25 +"[/color]% Melee Defense due to sensing the dead"
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/initiative.png",
			    text = "Gets +[color=" + this.Const.UI.Color.PositiveValue + "]"+ dead[1]*50 +"[/color]% Initiative due to sensing the dead"
			}
		];

		if(dead[1] >= 0.5)
			{
				ret.push({
				    id = 11,
				    type = "text",
				    icon = "ui/icons/special.png",
				    text = "Also gets +[color=" + this.Const.UI.Color.PositiveValue + "]4 [/color]Melee Skill, Defense and Initiative from overwhelming hunger"
				});
			}

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

		//local actor = this.getContainer().getActor();
		local entities = this.Tactical.Entities.getAllInstancesAsArray();
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

		if (this.Time.getRound() <=1 && this.m.CountedEntities <= 2 && entityCount != 0)
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
			this.m.Name = "Scavenger\'s Surge (x"+ dead[0] +")";
			_properties.MeleeSkillMult += dead[1]*0.35;
			_properties.MeleeDefenseMult += dead[1]*0.25;
			_properties.InitiativeMult += dead[1]*0.50;
		}

		if(dead[1] >= 0.5)
		{
			this.m.Name = "Scavenger\'s Surge (Hightened) (x"+ dead[0] +")";
			_properties.MeleeSkill += 4;
			_properties.MeleeDefense += 4;
			_properties.Initiative += 4;
		}
	}

});
