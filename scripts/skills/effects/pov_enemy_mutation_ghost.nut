this.pov_enemy_mutation_ghost <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_ghost";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Etherial Attacks [/color]";
		this.m.Description = "This enemy has some properties of a Geist! Their attacks phase through armor, but also fail to damage it efectively.";
		this.m.Icon = "skills/pov_geist_mutant.png";
		this.m.IconMini = "pov_mini_geist_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This enemy has some properties of a Geist! Their attacks phase through armor, but also fail to damage it efectively.";
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
				icon = "ui/icons/direct_damage.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] armor penetration, with an additional flat bonus of [color=" + this.Const.UI.Color.PositiveValue + "]5[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Do [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] less damage to armor."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Ghost));
	  	}

	  	if (!this.m.Container.hasSkill("actives.pov_ghastly_touch"))
		{
			local touch = this.new("scripts/skills/actives/pov_ghastly_touch_skill");
			//touch.m.ActionPointCost = 3;
			this.m.Container.add(touch);
		}
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.DamageDirectAdd += 0.05;
		_properties.DamageDirectMult += 0.15;
		_properties.RangedDefenseMult *= 1.20;
		_properties.RangedDefense += 4;
		// Debuffs
		_properties.DamageArmorMult *= 0.5;
		// Undead Flag
	}

});
