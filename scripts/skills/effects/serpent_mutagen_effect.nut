this.serpent_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
		},
	function create()
	{
		this.m.ID = "effects.serpent_mutagen";
		this.m.Name = "Mutation: Serpent";
		this.m.Icon = "skills/serpent.png";
		this.m.IconMini = "";
		this.m.Overlay = "serpent";
		//this.m.Overlay = "status_effect_87";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Pack Instinct[/color]: The vatt\'ghern excels when fighting alongside allies, feeding off their presence to strike with greater precision. When surrounded themselves though, this inctinct can turn to panic, redicing the Vatt\'ghern\'s defense.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Endurance Boost[/color]: Enhanced stamina allows the vatt'ghern to recover fatigue more quickly each turn, keeping them in the fight longer.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Singular Focus[/color]: When facing a single opponent, the vatt\'ghern gains a significant boost to melee and ranged defense. This defensive edge diminishes in chaotic skirmishes with multiple enemies.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Reflexive Defense[/color]: The vatt'ghern's quick reflexes grant them additional melee and ranged defense based on their current initiative.\n\n [color=" + this.Const.UI.Color.NegativeValue + "]Frail Frame[/color]: The mutation weakens their overall health, reducing their maximum vitality and making them more vulnerable to damage.";
	}

	function isHidden()
	{
		return this.getBonus() == 0;
	}

	// ADDED VIA SERPENTINE AGILITY EFFECT
	/*function getBonus()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return 0;
		}

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local myFaction = actor.getFaction();
		local nearbyEnemies = 0;

		if (myTile == null)
		{
			return 0;
		}

		if (!("Entities" in this.Tactical))
		{
			return 0;
		}

		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local actors = this.Tactical.Entities.getAllInstancesAsArray();
		local bonus = 0;
		foreach( a in actors )
		{
			if (a == null)
			{
				continue;
			}

			if(!a.isPlacedOnMap())
			{
				continue;
			}

			if (a.getFaction() == myFaction)
			{
				continue;
			}

			if (a.getTile() == null)
			{
				continue;
			}

			if (a.getTile().getDistanceTo(myTile) != 1)
			{
				continue;
			}
			++nearbyEnemies;
		}

		if (nearbyEnemies > 1)
		{
			return 0;
		}
		if (nearbyEnemies == 1)
		{
			return 10;
		}
		else
		{
			return 0;
		}
	}*/

	function getTooltip()
	{
		// ADDED VIA SERPENTINE AGILITY EFFECT
		//local initiative = this.Math.floor(this.getContainer().getActor().getInitiative() * 0.10);
		//local bonus = this.getBonus();
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
				text = "Gain the [color=" + this.Const.UI.Color.PositiveValue + "]\"Serpentine Agility\"[/color] effect while in battle, which increases defenses by 10% of current initiative, with an additional bonus when engaged with exactly [color=" + this.Const.UI.Color.PositiveValue + "]one[/color] enemy. This character also suffers a [color=" + this.Const.UI.Color.NegativeValue + "]-4[/color] melee defense penalty for each enemy surrounding them."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]+3%[/color] chance to hit in melee for every ally adjacent to your target."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] fatigue recovery per turn."
			},
			/*{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense when fighting a single enemy, and half of that bonus to ranged defence."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Get [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of your current initiative as melee and ranged defence. (Added as an effect when in battle)"
			},*/
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Take [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] more damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] of max health"
			}
			/*{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Have [color=" + this.Const.UI.Color.NegativeValue + "]-4[/color] defense per surrounding enemy."
			}*/
		];
		return ret;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		// ADD SERPENTINE AGILITY EFFECT - REMOVED AFTER BATTLE
		actor.getSkills().add(this.new("scripts/skills/effects/pov_serpentine_agility_effect"));
	}

	function onUpdate( _properties )
	{
		// ADDED VIA SERPENTINE EFFECT
		//local bonus = this.getBonus();
		//_properties.MeleeDefense += bonus;
		//_properties.RangedDefense += bonus / 2;
		_properties.SurroundedBonus += 3;

		// ADDED VIA SERPENTINE EFFECT
		//_properties.SurroundedDefense -= 3;
		_properties.FatigueRecoveryRate += 2;
		_properties.HitpointsMult *= 0.75;

		/*
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.05;
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] += -0.25;
		_properties.FatigueEffectMult *= 1.15;
		*/
	}

	// ADDED VIA SERPENTINE EFFECT
	/*function onAfterUpdate( _properties )
	{
		local initiative = this.Math.floor(this.getContainer().getActor().getInitiative() * 0.10);
		_properties.MeleeDefense += this.Math.max(0, initiative);
		_properties.RangedDefense += this.Math.max(0, initiative);
	}*/

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		_properties.DamageReceivedRegularMult *= 1.10;
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
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

 