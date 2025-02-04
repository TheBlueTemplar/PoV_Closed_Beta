this.vattghern_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		KillsPerAction = 150, 
		KillsPerInitiative = 15, 
		KillsPerRegen = 10,  
		KillsPerDamage = 10,  
		KillsPerResolve = 10,  
		StartAction = 1
		StartInitiative = 5
		StartRegen = 3
		StartDamage = 3
		StartResolve = 10
		MaxScale = 5
		MaxAction = 2
		MaxInitiative = 15
		MaxRegen = 18
		MaxDamage = 18
		MaxResolve = 25
		IsActivated = false,
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.witcher";
		this.m.Name = "Vatt'ghern";
		this.m.Icon = "ui/perks/wolf.png";
		this.m.Description = "%name% has survived the [color=" + this.Const.UI.Color.PositiveValue + "]trial of the grasses[/color] and became a Vatt'ghern. Specialised in killing monsters, they are faster and stronger than normal humans. \n\n While the trial left them weak, their skills will improve over time as they get kills. Bonuses Cap at 150 kills. \n\n Due to the Vatt'ghern's skillset, they demand much larger pay than the common mercenary. \n\n %name% can receive up to [color=" + this.Const.UI.Color.PositiveValue + "]one[/color] additional mutation, and can use mutant potions in battle.";
		this.m.Order = this.Const.SkillOrder.Background - 2;
	}

	

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		

		local kills = this.getContainer().getActor().getLifetimeStats().Kills;
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/kills.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + kills + "[/color] Kills"
		});

		local mutations = this.getMutations();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + mutations + "[/color] Mutations"
		});

		local action = this.getActionBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + action + "[/color] AP"
		});
		
		local initiative = this.getInitiativeBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + initiative + "[/color]% Initiative"
		});
		
		local damage = this.getDamageBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + damage + "[/color]% Damage"
		});
		
		local regen = this.getRegenBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + regen + "[/color]% Regeneration"
		});
		
		local resolve = this.getResolveBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + resolve + "[/color]% Resolve"
		});
		
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/money2.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]+100[/color]% Daily Wage"
		});

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/miniboss.png",
			text = "The Vatt'ghern counts as[color=" + this.Const.UI.Color.NegativeValue + "]one and a half[/color] Brother, for the enemy scaling calculation"
		});
		
		return result;
		
	}


	function onUpdate( _properties )
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			_properties.InitiativeMult *= (1+ (0.01 * (this.getInitiativeBonus())));
			_properties.ActionPoints += this.getActionBonus();
			_properties.DamageTotalMult *= (1+ (0.01 * (this.getDamageBonus())));
			_properties.BraveryMult *= (1+ (0.01 * (this.getResolveBonus())));
			_properties.DailyWageMult *= 2;
		}
	}
	
	
	
	function getMutations()
	{
		return this.getContainer().getActor().getFlags().getAsInt("ActiveMutations");
	}
	
	function getInitiativeBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale) 
		{
			return this.m.StartInitiative + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerInitiative);
		}else
		{
			return this.m.MaxInitiative;
		}
	}
	
	function getActionBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale) 
		{
			return this.m.StartAction + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerAction);
		}else
		{
			return this.m.MaxAction;
		}
	}
	
	function getDamageBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale) 
		{
			return this.m.StartDamage + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerDamage);
		}else
		{
			return this.m.MaxDamage;
		}
	}
	
	function getRegenBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale) 
		{
			return this.m.StartRegen + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerRegen);
		}else
		{
			return this.m.MaxRegen;
		}
	}
	
	function getResolveBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale) 
		{
			return this.m.StartResolve + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerResolve);
		}else
		{
			return this.m.MaxResolve;
		}
	}
	
	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, actor.getHitpointsMax()* this.getRegenBonus()/100);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	
});

