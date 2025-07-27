::TLW.HooksMod.hook("scripts/entity/tactical/objective/legend_donkey", function ( q )
{
	q.onInit = @(__original) function()
	{	
		__original()

		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push([2,"scripts/items/misc/anatomist/pov_donkey_mutagen_item"]);
		}

		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}
	}

});
