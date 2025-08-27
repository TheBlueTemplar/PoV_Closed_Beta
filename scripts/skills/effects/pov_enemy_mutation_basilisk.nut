this.pov_enemy_mutation_basilisk <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_basilisk";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Basilisk\'s Focus [/color]";
		this.m.Description = "This enemy has some properties of a Basilisk! Their intense focus grants them increased chance and damage against enemie's heads, but reduced damage against their bodies. In addition, all their attacks cost more fatigue";
		this.m.Icon = "skills/pov_basilisk_mutant.png";
		this.m.IconMini = "pov_mini_basilisk_mutant";
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
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit the head"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+12%[/color] more damage when hitting the head with any weapon"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=" + this.Const.UI.Color.NegativeValue + "]-16%[/color] less damage when hitting the body with any weapon"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "All skills cost [color=" + this.Const.UI.Color.NegativeValue + "]15%[/color] more fatigue"
			}
		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Basilisk));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.12;
		// Debuffs
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] += -0.16;
		_properties.FatigueEffectMult *= 1.15;
	}

});
