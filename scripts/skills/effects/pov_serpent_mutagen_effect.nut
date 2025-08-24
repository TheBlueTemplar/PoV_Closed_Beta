this.pov_serpent_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
		},
	function create()
	{
		this.m.ID = "effects.pov_serpent_mutagen";
		this.m.Name = "Mutation: Serpent";
		this.m.Icon = "skills/pov_serpent.png";
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
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color] of max health"
			}
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
		// Buffs
		_properties.SurroundedBonus += 3;
		_properties.FatigueRecoveryRate += 2;

		// Debuffs
		// ADDED VIA SERPENTINE EFFECT
		//_properties.SurroundedDefense -= 4;
		_properties.HitpointsMult *= 0.85;
		// Takes 10% More dmg
	}

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

