this.pov_goblin_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_goblin_mutagen";
		this.m.Name = "Mutation: Goblin";
		this.m.Icon = "skills/pov_goblin.png";
		this.m.IconMini = "";
		this.m.Overlay = "goblin";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.povPerkBlue + "]Reactive Muscles[/color]: This character\'s muscles have mutated, allowing them to execute swift and intricate movements with ease. Their body flows effortlessly through battle, making evasive maneuvers and repositioning far less taxing.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Mutated Cornea[/color]: Their eyes have adapted to detect the subtlest shifts in wind and motion, enhancing their ability to anticipate and correct projectile trajectories. Their ranged attacks strike with uncanny accuracy and can bypass obstructions with surprising frequency.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Frail Physique[/color]: This character\'s body has become more fragile, struggling to endure direct blows. Even minor injuries can take a severe toll, and heavier armor feels overly cumbersome, sapping energy faster than normal.\n\n[color=" + this.Const.UI.Color.povPerkBlue + "]Skittish Mind[/color]: The Vatt\'ghern' is more prone to panic in the face of danger, making them susceptible to fear and doubt. Prolonged engagements or overwhelming odds may break their resolve more easily than most.";
	}

	function getPenalty()
	{
		local actor = this.getContainer().getActor();

		local bodyitem = actor.getBodyItem();

		if (bodyitem == null)
		{
			return 0;
		}
	
		local armorFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Body);
		local helmetFatPen = actor.getItems().getStaminaModifier(::Const.ItemSlot.Head);
		local totalPen = armorFatPen + helmetFatPen;
		local penalty = totalPen * 0.15;
		return penalty;
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
				icon = "ui/icons/action_points.png",
				text = "The action point and fatigue costs of movement abilities is [color=" + this.Const.UI.Color.PositiveValue + "]greatly reduced[/color]. (Sprint, Footwork, Rotation)"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Aimed Shot AP cost reduced by [color=" + this.Const.UI.Color.PositiveValue + "]2[/color], with a slightly increased fatigue cost."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "All Ranged Damage increased by [color=" + this.Const.UI.Color.PositiveValue + "]12%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] ranged skill, with an additional [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] chance that a shot can not be blocked."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Maximum health decreased by [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color] and Melee defense decreased by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Has a penalty of [color=" + this.Const.UI.Color.NegativeValue + "]20[/color] on all morale checks."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "The fatigue and initiative penalty from wearing armor is increased by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		// Buffs
		// Get a bunch of ranged and mobility bonuses too
		_properties.MovementFatigueCostAdditional += -1;
		_properties.RangedSkillMult *= 1.15;
		_properties.RangedDamageMult *= 1.12;
		_properties.RangedAttackBlockedChanceMult = this.Math.max(0, _properties.RangedAttackBlockedChanceMult - 0.25);
		// Debuffs
		// Also a moral check penalty? dunno if it works
		_properties.Hitpoints *= 0.80;
		_properties.MeleeDefenseMult *= 0.85;
		_properties.Stamina += this.getPenalty();
		_properties.Initiative += this.getPenalty();
	}

	// THIS HAS NOT BE FULLY TESTED
	function checkMorale( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		_difficulty = _difficulty - 20;
	}

	function onAfterUpdate(_properties)
	{
		
		local aimedShot = this.getContainer().getSkillByID("actives.aimed_shot");
		if (aimedShot != null)
		{
			aimedShot.m.ActionPointCost -= 2;
			aimedShot.m.FatigueCost *= 1.2;
		};
		local sprint = this.getContainer().getSkillByID("actives.sprint");
		if (sprint != null)
		{
			sprint.m.ActionPointCost = 2;
			sprint.m.FatigueCost *= 0.6;
		};
		local footwork = this.getContainer().getSkillByID("actives.footwork");
		if (footwork != null)
		{
			footwork.m.ActionPointCost = 2;
			footwork.m.FatigueCost *= 0.6;
		};
		local rotation = this.getContainer().getSkillByID("actives.rotation");
		if (rotation != null)
		{
			rotation.m.ActionPointCost = 2;
			rotation.m.FatigueCost *= 0.6;
		}
	}

	function isHidden()
	{
		return this.inBattleHiddenCheck();
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




