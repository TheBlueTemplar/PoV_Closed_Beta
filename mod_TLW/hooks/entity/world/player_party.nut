::TLW.HooksMod.hook("scripts/entity/world/player_party", function ( q )
{
    q.updateStrength = @(__original) function()
    {
        local roster = this.World.getPlayerRoster().getAll();
        __original();
        local broScale = 1.0;
        local count = 0;
        foreach(bro in roster)
        {
            if (bro.getSkills().hasSkill("trait.witcher"))
            {
//                this.m.Strenght * 1.5;
                
                local brolevel = bro.getLevel();
                //broScale *= 1.5;

                if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
                {
                    this.m.Strength += ((3 + ((brolevel / 4) + (brolevel - 1)) * 1.5) * broScale)/2;
                }
                else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Normal)
                {
                    this.m.Strength += ((10 + (((3 * brolevel) / 4) + (brolevel - 1)) * 2) * broScale)/2;
                }
                else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
                {
                    this.m.Strength += ((6 + (count / 2) + ((brolevel / 2) + (pow(brolevel, 1.2)))) * broScale)/2;
                }
                else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
                {
                    this.m.Strength += ((count + (brolevel + (pow(brolevel, 1.2)))) * broScale)/2;
                } 
            }
            count++;
        }
    }
});