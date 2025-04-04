::TLW.HooksMod.hook("scripts/entity/tactical/skeleton", function ( q )
{
	q.onInit = @(__original) function()
	{
		__original()

		//Coprse Drop
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			switch (true) 
			{	//cool kids use switchcases
			case (this.isKindOf(this, "skeleton_priest") || this.isKindOf(this, "skeleton_lich")):
				this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.SkeletonPriest));
				break;
			case (this.isKindOf(this, "skeleton_boss")):
				this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.SkeletonBoss));
				break;
			default:
				this.actor.m.OnDeathLootTable.push(::TLW.CorpseDrop.getCorpseDrop(actor, ::TLW.Corpse.Skeleton));
				break;
			}
	  	}

		// Chaos Mutation
		if (::TLW.ChaosMode && ::TLW.EnableEnemyMutation)
		{
			::TLW.Mod.Debug.printLog("Calling add_mutation_all")
			::TLW.Chaos.add_mutation_all(this.actor, false)
		}

	}

});