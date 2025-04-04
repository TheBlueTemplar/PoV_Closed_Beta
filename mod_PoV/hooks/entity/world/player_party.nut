::TLW.HooksMod.hook("scripts/entity/world/player_party", function ( q )
{
    //q.m.BarterMultiplier <- 0.0;

    q.updateStrength = @(__original) function()
    {
        local roster = this.World.getPlayerRoster().getAll();
        __original();
        local broScale = 1.0;
        local count = 0;
        foreach(bro in roster)
        {
            if (bro.getSkills().hasSkill("trait.pov_witcher"))
            {
                //this.m.Strenght * 1.5;

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

    /*q.getBarterMult = @(__original) function()
    {
        return this.m.BarterMultiplier;
    }

    q.calculateModifiers = @(__original) function ()
    {
        if (this.World.State.m.AppropriateTimeToRecalc == 1)    //Leonion's fix
        {
            this.calculateBarterMult();
            this.calculateWageModifier();
            this.calculateFoodModifier();
            this.calculateAmmoModifier();
            this.calculateArmorPartsModifier();
            this.calculateMedsModifier();
            this.calculateStashModifier();
        }
    }*/

    /*q.calculateBarterMult = @(__original) function ()
    {
        if (this.World.State.m.AppropriateTimeToRecalc == 0)
        {
            return;
        }

        local barterMult = 0.0;
        local greed = 1;
        foreach (bro in this.World.getPlayerRoster().getAll())
        {
            barterMult += bro.getBarterModifier();
            if (bro.getSkills().hasSkill("perk.legend_barter_greed"))
            {
                greed += 1;
            }
        }

        if (this.World.Assets.getOrigin().getID() == "scenario.trader")
        {
            barterMult = barterMult * 1.1;
        }

        this.m.BarterMultiplier = barterMult / greed;
    }*/

});