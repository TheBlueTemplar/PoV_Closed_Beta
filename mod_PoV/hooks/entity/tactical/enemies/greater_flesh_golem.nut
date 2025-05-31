::TLW.HooksMod.hook("scripts/entity/tactical/enemies/greater_flesh_golem", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()
		
		// Corpse Drop
		/*if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.Hyena));
	  	}*/
	  	
		// Other Drops
		local chance = 0;
		switch (this.World.Assets.getCombatDifficulty())
		{
			case this.Const.Difficulty.Easy: chance = 2; break
			case this.Const.Difficulty.Normal: chance = 3; break
			case this.Const.Difficulty.Hard: chance = 3; break
			case this.Const.Difficulty.Legendary: chance = 3; break
		}	
		this.actor.m.OnDeathLootTable.push([chance,"scripts/items/pov_undead_alpha_item"]);
		
		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}
	}

});
