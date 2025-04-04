/*::TLW.HooksMod.hook("scripts/skills/actives/rally_the_troops", function ( q ) {

	q.onUse = @(__original) function(_user, _targetTile)
	{
		local bravery = this.getBonus();
		local actors = this.Tactical.Entities.getAllInstancesAsArray(); //Take all actors instead of ones belonging to the user's faction

		foreach(a in actors)
		{
			if (a.getFaction() == _user.getFaction())
			{
				if (a.getSkills().hasSkill("effects.pov_curse_master")) //the idea is for rally to work on our effects too, and maybe someday we will give access to our effects to enemies so they can interact with this too
				{
					local rand = this.Math.rand(1, 100);
					if( bravery > rand )
					{
						a.getSkills().removeByID("effects.pov_curse_master");
					}
				}
			}
		}
		__original(_user, _targetTile);
	}
});*/	//commented out for now as we dont use this effects

//dont know how this will work with legends' hook, but should be okay, maybe