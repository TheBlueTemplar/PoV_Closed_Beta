this.pov_enemy_mutation_ghoul <- this.inherit("scripts/skills/skill", {
	m = {
		StartingEntities = 0,
		CountedEntities = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_ghoul";
		this.m.Name = "[color=#034207] Ghoulish Hunger [/color]";
		this.m.Description = "This enemy has some properties of a Nahrezer! They become more swift and have a terrifying presence, but they are also easier to injure, and their fast attacks do not pack the same punch.";
		this.m.Icon = "skills/pov_ghoul_mutant.png";
		this.m.IconMini = "pov_mini_ghoul_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They become more swift and have a terrifying presence, but they are also easier to injure, and their fast attacks do not pack the same punch.";
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
				text = "Gain a stacking [color=" + this.Const.UI.Color.PositiveValue + "]buff[/color] which increases as more enttities die in a battle."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.PositiveValue + "]-8[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] melee damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Injury threshold reduced by [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color]."
			}

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
		::TLW.Mod.Debug.printLog("Start Entities:: " + this.m.StartingEntities + "Entity Count:: " + entityCount + " Dead Enemies: " + deadEnemies + " Buff%: " + buff);
		return [deadEnemies, buff * 0.01]; // reurns all entities sum, and then this is sth like 0.5
	}

	function onAdded() 
	{
		//local dead = calculateBonus();
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Ghoul));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		local dead = calculateBonus();
		if(dead[0] >= 1)
		{
			this.m.Name = "[color=#034207] Ghoulish Hunger (x"+ dead[0] +")[/color]";
			_properties.MeleeSkillMult += dead[1]*0.60;
			_properties.MeleeDefenseMult += dead[1]*0.40;
			_properties.InitiativeMult += dead[1]*0.75;
		}

		if(dead[1] >= 0.5)
		{
			this.m.Name = "[color=#034207] Ghoulish Hunger (Peaked) (x"+ dead[0] +")[/color]";
			_properties.MeleeSkill += 4;
			_properties.MeleeDefense += 4;
			_properties.Initiative += 4;
		}
		_properties.Threat += 8;
		// Debuffs
		_properties.ThresholdToReceiveInjuryMult *= 0.75;
		_properties.RangedSkillMult *= 0.80;
		_properties.MeleeDamageMult *= 0.95;
	}

});
