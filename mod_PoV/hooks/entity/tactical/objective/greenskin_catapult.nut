::TLW.HooksMod.hook("scripts/entity/tactical/objective/greenskin_catapult", function ( q )
{
	q.onInit = @(__original) function()
	{	
		__original()

		// HERE, ADD EFFECTS YOU ALWAYS WANT APPLIED
		if(this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Easy)
		{
			local chanceSecret = 3;
			if (this.Math.rand(1.0, 100.0) <= chanceSecret)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/pov_shite_woodwork_effect"));
			}
		}
	}

});
