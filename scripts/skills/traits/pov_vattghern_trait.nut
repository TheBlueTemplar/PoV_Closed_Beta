/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

this.pov_vattghern_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		// HERE IS THE LOGIC FOR THE VARS BELOW:
		// All things here keep counting until lifetile mills > MaxScale
		// Max Values are selected after this is surpassed

		// To determine how to re-scale (damage as example)
		// Max Scale / (MaxDamage - Start Damage) = KillsPerDamage
		// Idk What Im writing
		KillsPerAction = 200,
		KillsPerInitiative = 22,
		KillsPerRegen = 14,
		KillsPerDamage = 14,
		KillsPerResolve = 13,
		StartAction = 1,
		StartInitiative = 1,
		StartRegen = 0,
		StartDamage = 0.5,
		StartResolve = 3.5,
		MaxScale = 201,
		MaxAction = 2,
		MaxInitiative = 12,
		MaxRegen = 15,
		MaxDamage = 15,
		MaxResolve = 20,
		IsActivated = false

		// Old Scaling
		/*KillsPerAction = 150,
		KillsPerInitiative = 15,
		KillsPerRegen = 10,
		KillsPerDamage = 10,
		KillsPerResolve = 10,
		StartAction = 1
		StartInitiative = 5
		StartRegen = 3
		StartDamage = 3
		StartResolve = 10
		MaxScale = 151
		MaxAction = 2
		MaxInitiative = 15
		MaxRegen = 18
		MaxDamage = 18
		MaxResolve = 25
		IsActivated = false,*/
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_witcher";
		this.m.Name = "Vatt'ghern";
		this.m.Icon = "ui/traits/pov_vattghern.png";
		this.m.Description = "%name% has survived the [color=#031b99]Trial of the grasses[/color] and became a Vatt'ghern. Specialized in killing monsters, they are faster and stronger than normal humans, and can ingest special [color=#031b99]mutagens[/color]. \n\n Their skills further improve over time as they get kills and mutations. Bonuses Cap at 200 kills. \n\n Due to the Vatt'ghern's skillset, they demand much larger pay than the common mercenary, and attract stronger opponents.";
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
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.round(action) + "[/color] AP"
		});

		local initiative = this.getInitiativeBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.round(initiative) + "[/color]% Initiative"
		});

		local damage = this.getDamageBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.round(damage) + "[/color]% Damage"
		});

		local regen = this.getRegenBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.round(regen) + "[/color]% Regeneration"
		});

		local resolve = this.getResolveBonus();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.round(resolve) + "[/color]% Resolve"
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
			text = "The Vatt'ghern counts as[color=" + this.Const.UI.Color.NegativeValue + "] one and a half[/color] Brother, for the enemy scaling calculation"
		});

		return result;

	}

	// Vattghern Eyes and Bust Effect
	function onAdded()
	{
		local actor = this.getContainer().getActor();

		// If actor is a Vattghern, add a new, special bust layer!
		if (actor.hasSprite("socket"))
		{
			local bust_sprite = actor.getSprite("socket");
			bust_sprite.setBrush("pov_vattghern_bust"); 
			//mutant_bust_sprite.Saturation = 0.8;
			bust_sprite.Visible = true;
		}

		if (actor.hasSprite("permanent_injury_4"))
		{
			local sprite = actor.getSprite("permanent_injury_4");
			sprite.Visible = true;
			sprite.setBrush("pov_vattghern_eyes");
			sprite.Alpha = 0;
			sprite.fadeIn(1500);
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
			_properties.InitiativeMult *= (1+ (0.01 * (this.getInitiativeBonus())));
			_properties.ActionPoints += this.getActionBonus();
			_properties.DamageTotalMult *= (1+ (0.01 * (this.getDamageBonus())));
			_properties.BraveryMult *= (1+ (0.01 * (this.getResolveBonus())));
			_properties.DailyWageMult *= 2;
	}

	function getMutations()
	{
		return this.getContainer().getActor().getFlags().getAsInt("pov_ActiveMutations");
	}

	function getInitiativeBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			return this.m.StartInitiative + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerInitiative) + (getMutations() * 0.70);
		}else
		{
			return this.m.MaxInitiative + (getMutations() * 0.70);
		}
	}

	function getActionBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			return this.m.StartAction + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerAction) + (getMutations() * 0.03);
		}else
		{
			return this.m.MaxAction + (getMutations() * 0.03);
		}
	}

	function getDamageBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			return this.m.StartDamage + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerDamage) + (getMutations() * 0.50);
		}else
		{
			return this.m.MaxDamage + (getMutations() * 0.50);
		}
	}

	function getRegenBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			return this.m.StartRegen + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerRegen) + (getMutations() * 0.90);
		}else
		{
			return this.m.MaxRegen + (getMutations() * 0.90);
		}
	}

	function getResolveBonus()
	{
		if(this.getContainer().getActor().getLifetimeStats().Kills < this.m.MaxScale)
		{
			return this.m.StartResolve + (this.getContainer().getActor().getLifetimeStats().Kills / this.m.KillsPerResolve) + (getMutations() * 1.5);
		}else
		{
			return this.m.MaxResolve + (getMutations() * 1.50);
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

