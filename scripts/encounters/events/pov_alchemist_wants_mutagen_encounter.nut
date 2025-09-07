this.pov_alchemist_wants_mutagen_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
        Peddler = null,
        Merchant = null,
        Reward = 0,
        Item = null,
        Town = null
    },
    function create()
    {
        this.createScreens();
        this.m.Type = "encounter.pov_alchemist_wants_mutagen";
        this.m.Name = "Take a stroll through the market...";
        this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
    }

    function createScreens() 
    {
        this.m.Screens.push({
            ID = "A",
            Title = "An Alchamist wants your mutagen",
            Text = "[img]gfx/ui/events/event_184.png[/img]{As you move through the town\'s muddy streets, your nose catches a sharp, acrid scent that cuts through the usual reek of livestock and sweat. Turning a corner, you nearly stumble into a man hunched over a bundle of bloodied cloths and bones, muttering to himself. His hair is a wild thicket of grey, and his robe is stitched together from so many different patches that it looks like a skinwalker\'s disguise. He peers up at you through round, fogged spectacles, his eyes glittering with a manic energy. %SPEECH_ON% Ah, a mercenary! Perfect, perfect. You have what I need, yes? Fresh samples, sinew, rare bone formations? %SPEECH_OFF% Without waiting for your reply, he circles you, sniffing like a hound. %SPEECH_ON% That specimen there, the %trophy%, magnificent! A real marvel. I\'ll give you %reward% crowns for it. No haggling, no questions. Only science! %SPEECH_OFF%}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Deal.",
                    function getResult( _event )
                    {
                        if (_event.m.Merchant != null)
                        {
                            return "Merchant";
                        }
                        if (_event.m.Peddler != null)
                        {
                            return "Peddler";
                        }
                        else
                        {
                            this.World.Assets.addMoney(_event.m.Reward);
                            local stash = this.World.Assets.getStash().getItems();

                            foreach( i, item in stash )
                            {
                                if (item != null && item.getID() == _event.m.Item.getID())
                                {
                                    stash[i] = null;
                                    break;
                                }
                            }

                            return 0;
                        }
                    }

                },
                {
                    Text = "No deal.",
                    function getResult( _event )
                    {
                        if (_event.m.Merchant != null)
                        {
                            return "Merchant";
                        }
                        if (_event.m.Peddler != null)
                        {
                            return "Peddler";
                        }
                        else
                        {
                            return 0;
                        }
                    }

                }
            ],
            function start( _event )
            {
            }

        });
        this.m.Screens.push({
            ID = "Peddler",
            Title = "A price improved",
            Text = "[img]gfx/ui/events/event_184.png[/img]{%peddler% saunters up with a grin, slipping between you and the wild-eyed anatomist like a knife through cloth. Without so much as a glance your way, %they_peddler% launches into a tirade of shouts, gestures, and accusations about the quality of the goods and the rarity of the specimen. The anatomist, flustered, snaps back just as fiercely, the two of them tossing numbers and insults into the air with such speed and venom it feels more like a tavern brawl than a barter. After a few breathless moments, %peddler% turns on his heel and strolls back to you. %SPEECH_ON% Got him where we want him. He\'s offering %reward% crowns now. I\'ll leave you to squeeze the rest out of him. I\'m off to find something less loud to spend it on.%SPEECH_OFF% With a casual pat on your shoulder, %they_peddler% vanishes into the crowd, leaving you with a much-improved offer.}",
            Image = "",
            List = [],
            Characters = [],
            Options = [
                {
                    Text = "Deal.",
                    function getResult( _event )
                    {
                        this.World.Assets.addMoney(_event.m.Reward);
                        local stash = this.World.Assets.getStash().getItems();

                        foreach( i, item in stash )
                        {
                            if (item != null && item.getID() == _event.m.Item.getID())
                            {
                                stash[i] = null;
                                break;
                            }
                        }

                        return 0;
                    }

                },
                {
                    Text = "No deal.",
                    function getResult( _event )
                    {
                        return 0;
                    }

                }
            ],
            function start( _event )
            {
                this.Characters.push(_event.m.Peddler.getImagePath());
                _event.m.Reward = this.Math.floor(_event.m.Reward * 1.33);
            }

        });
        this.m.Screens.push({
            ID = "Merchant",
            Title = "A price improved",
            Text = "[img]gfx/ui/events/event_184.png[/img]{You spot the hesitation in the anatomist\'s eyes and know it\'s your moment to strike. With the easy confidence of a man who\'s bartered for silk, spices, and sharper things still, you step forward, presenting the mutagen with a flourish.The anatomist clutches his purse tightly, as though you might pluck the coins from it directly, but you just smile and let the strange vial catch the light.%SPEECH_ON% This isn\'t just a trinket. This is a miracle bottled: a wonder of flesh and alchemy! No other merchant in these parts will ever have its like.%SPEECH_OFF%The anatomist shifts, his greed and curiosity battling his good sense. You lean in slightly, your voice low, persuasive.%SPEECH_ON% With this mutagen, you\'ll draw every scholar, every lord curious for power, right to your door. Think of the prestige... and the profits.%SPEECH_OFF%After a moment of agonized silence, the man finally nods, digging into his pouch with shaking hands.%SPEECH_ON% %reward% crowns. It\'s yours... but you didn\'t get it from me.%SPEECH_OFF%}",
            Image = "",
            List = [],
            Characters = [],
            Options = [{
                Text = "Deal.",
                function getResult( _event ) {
                    this.World.Assets.addMoney(_event.m.Reward);
                    local stash = this.World.Assets.getStash().getItems();
                    foreach( i, item in stash )
                        if (item != null && item.getID() == _event.m.Item.getID()) {
                            stash[i] = null;
                            break;
                        }
                    return 0;
                }
            }, {
                Text = "No deal.",
                function getResult( _event ) {
                    return 0;
                }

            }],
            function start( _event ) {
                this.Characters.push(_event.m.Merchant.getImagePath());
                _event.m.Reward = this.Math.floor(_event.m.Reward * 1.66);
            }
        });
    }

    function isVisible()
    {
        if (!this.World.getTime().IsDaytime)
        {
            return false;
        }
    }

    function isValid(_settlement)
    {
        if (!this.World.getTime().IsDaytime)
        {
            return;
        }

        local stash = this.World.Assets.getStash().getItems();
        local candidates_items = [];

        foreach( item in stash )
        {
            if (item != null)
            {
                if (item.getID() == "misc.pov_alp_mutagen" || item.getID() == "misc.pov_direwolf_mutagen" || item.getID() == "misc.pov_ghost_mutagen" || item.getID() == "misc.pov_ghoul_mutagen" || item.getID() == "misc.pov_goblin_mutagen" || item.getID() == "misc.pov_hexe_mutagen" || item.getID() == "misc.pov_lindwurm_mutagen" || item.getID() == "misc.pov_vampire_mutagen" || item.getID() == "misc.pov_orc_mutagen" || item.getID() == "misc.pov_schrat_mutagen" || item.getID() == "misc.pov_skeleton_mutagen" || item.getID() == "misc.pov_spider_mutagen" || item.getID() == "misc.pov_unhold_mutagen" || item.getID() == "misc.pov_strain_mutagen" || item.getID() == "misc.pov_basilisk_mutagen" || item.getID() == "misc.pov_sandgolem_mutagen" || item.getID() == "misc.pov_serpent_mutagen")
                {
                    candidates_items.push(item);                    
                }
            }
        }

        if (candidates_items.len() == 0)
        {
            return;
        }

        this.m.Item = candidates_items[this.Math.rand(0, candidates_items.len() - 1)];
        this.m.Reward = this.m.Item.getValue() * 5;
        local brothers = this.World.getPlayerRoster().getAll();

        if (brothers.len() < 3)
        {
            return;
        }

        local candidates_peddler = [];
        local candidates_merchant = [];

        foreach( bro in brothers )
        {
            if (bro.getBackground().getID() == "background.peddler" || bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
            {
                candidates_peddler.push(bro);
            }

            if (bro.getBackground().getID() == "background.legend_peddler_commander_background")
            {
                candidates_merchant.push(bro);
            }
        }

        if (candidates_peddler.len() != 0)
        {
            this.m.Peddler = candidates_peddler[this.Math.rand(0, candidates_peddler.len() - 1)];
        }

        if (candidates_merchant.len() != 0)
        {
            this.m.Merchant = candidates_merchant[this.Math.rand(0, candidates_merchant.len() - 1)];
        }

        //this.m.Town = _settlement;
        return !isOnCooldown();
    }

    function onPrepare()
    {
    }

    function onPrepareVariables( _vars )
    {
        _vars.push([
            "merchant",
            this.m.Merchant != null ? this.m.Merchant.getName() : ""
        ]);
        _vars.push([
            "peddler",
            this.m.Peddler != null ? this.m.Peddler.getName() : ""
        ]);
        if (this.m.Peddler != null)
        {
            ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Peddler.getGender(), "peddler");         
        }
        _vars.push([
            "reward",
            this.m.Reward
        ]);
        _vars.push([
            "trophy",
            this.m.Item.getName()
        ]);
        /*_vars.push([
            "townname",
            this.m.Town.getName()
        ]);*/
    }

    function onClear()
    {
        this.m.Peddler = null;
        this.m.Reward = 0;
        this.m.Item = null;
        //this.m.Town = null;
        this.m.Merchant = null;
    }

});

