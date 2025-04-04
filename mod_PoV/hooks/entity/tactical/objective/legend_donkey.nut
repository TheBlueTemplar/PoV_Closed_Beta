::TLW.HooksMod.hook("scripts/entity/tactical/objective/legend_donkey", function ( q )
{
	q.onInit = @(__original) function()
	{	
		if (!::MSU.isKindOf(this.actor, "player")) 
		{
			this.actor.m.OnDeathLootTable.push([2,"scripts/items/misc/anatomist/pov_donkey_mutagen_item"]);
		}
	}

});