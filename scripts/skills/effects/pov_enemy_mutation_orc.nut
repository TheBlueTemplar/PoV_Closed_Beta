this.pov_enemy_mutation_orc <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_orc";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Orcish Agression [/color]";
		this.m.Description = "This enemy has some properties of an Orc! They are much more agressive, and deal more damage, at the cost of their defences.";
		this.m.Icon = "skills/pov_orcber_mutant.png";
		this.m.IconMini = "pov_mini_orcber_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are much more agressive, and deal more damage, at the cost of their defences.";
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
				icon = "ui/icons/ranged_defense.png",
				text = "Gains a [color=" + this.Const.UI.Color.NegativeValue + "]10% + 5[/color] reduction to Ranged Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]10% + 5[/color] reduction to Melee Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Has + [color=" + this.Const.UI.Color.PositiveValue + "]10% + 8[/color] Melee skill and + [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Melee Damage."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Orc));
	  	}

	  	if (!this.m.Container.hasSkill("actives.pov_charge"))
		{
			local charge = this.new("scripts/skills/actives/pov_charge_skill");
			charge.m.ActionPointCost = 5;
			charge.m.FatigueCost = 30;
			charge.m.MaxRange = 3;
			this.m.Container.add(charge);

			if (actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.Charge) == null)
			{
				actor.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charge"));
				actor.getAIAgent().finalizeBehaviors();
			}
		}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.MeleeSkill += 8;
		_properties.MeleeSkillMult *= 1.10;
		_properties.MeleeDamageMult *= 1.10;
		// Debuffs
		_properties.MeleeDefense += -5;
		_properties.MeleeDefenseMult *= 0.90;
		_properties.RangedDefense += -5;
		_properties.RangedDefenseMult *= 0.90;
		_properties.SurroundedDefense -= 3;
	}

});
