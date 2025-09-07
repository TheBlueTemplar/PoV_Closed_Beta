this.pov_enemy_mutation_goblin <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_goblin";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Goblin\'s Cunning [/color]";
		this.m.Description = "This enemy has some properties of a Goblin! They are much more proficient with using bows, but are more squisky in return, as well as hindered by armor more.";
		this.m.Icon = "skills/pov_goblin_mutant.png";
		this.m.IconMini = "pov_mini_goblin_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are much more proficient with using bows, but are more squisky in return, as well as hindered by armor more.";
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
				icon = "ui/icons/ranged_skill.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]18%[/color] of ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] chance that a shot can not be blocked."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Maximum health decreased by [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Melee defense decreased by [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Has a penalty of [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color] resolve."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The fatigue and initiative penalty from wearing armor is increased by [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color]."
			}
		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Goblin));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.MovementFatigueCostAdditional += -2;
		_properties.RangedSkillMult *= 1.18;
		_properties.RangedDamageMult *= 1.12;
		_properties.RangedDefenseMult *= 1.15;
		_properties.RangedAttackBlockedChanceMult = this.Math.max(0, _properties.RangedAttackBlockedChanceMult - 0.20); //ty satan
		// Debuffs
		_properties.Hitpoints *= 0.80;
		_properties.MeleeDefenseMult *= 0.80;
		_properties.BraveryMult *= 0.85;
		_properties.Stamina += this.getPenalty();
		_properties.Initiative += this.getPenalty();
	}

	function onAfterUpdate(_properties)
	{
		// All those are buffs too
		local aimedShot = this.getContainer().getSkillByID("actives.aimed_shot");
		if (aimedShot != null)
		{
			aimedShot.m.ActionPointCost -= 1;
			//aimedShot.m.FatigueCost *= 1.2;
		};
		local footwork = this.getContainer().getSkillByID("actives.footwork");
		if (footwork != null)
		{
			//footwork.m.ActionPointCost = 2;
			footwork.m.FatigueCost *= 0.7;
		};
		local rotation = this.getContainer().getSkillByID("actives.rotation");
		if (rotation != null)
		{
			//rotation.m.ActionPointCost = 2;
			rotation.m.FatigueCost *= 0.7;
		}
	}

});
