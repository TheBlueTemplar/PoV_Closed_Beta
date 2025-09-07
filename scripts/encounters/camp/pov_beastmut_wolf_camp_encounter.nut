this.pov_beastmut_wolf_camp_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
        vattghernBeast = null
    },
    function create()
    {
        this.createScreens();
        this.m.Type = "encounter.pov_beastmut_wolf_camp_encounter";
        this.m.Name = "You hear howling...";
        this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
    }

    function createScreens() 
    {
        this.m.Screens.push({
            ID = "A",
            Title = "A new companion",
            Text = "[img]gfx/ui/events/pov_find_wolf.png[/img]{The night is quiet save for the crackle of the campfire and the low murmur of tired men. Then, a sound cuts through it... a long, haunting howl rolling over the hills. The company stiffens, hands drifting toward weapons, but no threat comes. Instead, it is %vattghern% who steps out of the shadows, grinning as though nothing is amiss.\n\nBehind %them_vattghern% pads a wolf, its coat ragged and its eyes gleaming with a feral light. The beast moves with wary grace, but does not strike, instead, it settles at %vattghern%\'s side, as if the two had known each other for years.%SPEECH_ON% Easy now, lads. This one\'s no enemy. Name\'s Blaidd, and he\'s part of the company now.%SPEECH_OFF%The men exchange uneasy glances, muttering prayers or curses under their breath. Still, none dare step forward as the wolf sits by the fire, its fangs flashing in the firelight, a silent promise of loyalty.\n\nYou sigh, knowing resistance is pointless. Another mouth to feed, another risk to bear, but a useful set of fangs...}",
            Image = "",
            List = [],
            Characters = [],
            Options = [
                {
                    Text = "That\'s some interesting company.",
                    function getResult( _event )
                    {
                        return 0;
                    }

                }
            ],
            function start( _event )
            {
                local item = this.new("scripts/items/accessory/wolf_item");
                item.m.Name = "Bleidd";
                this.World.Assets.getStash().add(item);

                _event.m.vattghernBeast.improveMood(0.5, "Found a new friend");

                this.List.push({
                    id = 10,
                    icon = "ui/items/" + item.getIcon(),
                    text = "You get " + item.getName()
                });
                this.List.push({
                    id = 10,
                    icon = this.Const.MoodStateIcon[_event.m.vattghernBeast.getMoodState()],
                    text = _event.m.vattghernBeast.getName() + this.Const.MoodStateEvent[_event.m.vattghernBeast.getMoodState()]
                });
            }

        });
    }

    function isVisible()
    {
        if (this.World.getTime().IsDaytime)
        {
            return false;
        }
    }

    function isValid(_camp)
    {
        if (this.World.getTime().IsDaytime)
        {
            return;
        }

        local brothers = this.World.getPlayerRoster().getAll();
        local vattghern_candidates = [];
        
        foreach( bro in brothers )
        {
            if (bro.getSkills().hasSkill("effects.pov_direwolf_mutagen") || bro.getSkills().hasSkill("effects.pov_direwolf_mutagen_upgraded"))
            {
                vattghern_candidates.push(bro);
            }
        }

        if (vattghern_candidates.len() == 0)
        {
            return;
        }

        this.m.vattghernBeast = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
        return !isOnCooldown();
    }

    function onPrepare()
    {
    }

    function onPrepareVariables( _vars )
    {
        _vars.push([
            "vattghern",
            this.m.vattghernBeast.getName()
        ]);
        ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vattghernBeast.getGender(), "vattghern");
    }

    function onClear()
    {
        this.m.vattghernBeast = null;
    }

});


