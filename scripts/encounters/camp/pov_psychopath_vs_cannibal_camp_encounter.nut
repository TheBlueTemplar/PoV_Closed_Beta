this.pov_psychopath_vs_cannibal_camp_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
        cannibal = null, 
        psycho = null, // Guys he\'s literally me
        OtherGuy = null
    },
    function create()
    {
        this.createScreens();
        this.m.Type = "encounter.pov_psychopath_vs_cannibal_camp_encounter";
        this.m.Name = "Noise in the camp";
        this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
    }

    function createScreens() 
    {
        this.m.Screens.push({
            ID = "A",
            Title = "A truly depraved meeting",
            Text = "[img]gfx/ui/events/pov_psycho_vs_cannibal.png[/img]{The fire burns low and steady as laughter echoes from where %cannibal% and %psycho% sit. It\'s a good sound — light, genuine — the sort of thing sorely needed after long days of marching and bleeding. Curious, you drift closer, a small smile tugging at your lips...That\'s when you hear it. %SPEECH_ON% If you\'ve never had human flesh before, think of the taste and texture of beef, except a little sweeter in taste and a little softer in texture. Contrary to popular belief, people do not taste like pork or chicken.%SPEECH_OFF% You freeze just in time to see %psycho% lift a charred piece of meat to %their_psycho% mouth, %their_psycho% teeth flashing as he bites down, grinning like a child sneaking sweets before supper. %cannibal% laughs along, nodding knowingly. Without a word, you slowly back away, careful not to draw their attention.\n\n Turning around, you almost crash into %other%, who stands rigid, face pale and eyes wide. For a moment, you share a silent understanding. Then, without needing to say a word, the two of you head for the nearest bottle of something strong.}",
            Image = "",
            List = [],
            Characters = [],
            Options = [
                {
                    Text = "Should keep an eye on them",
                    function getResult( _event )
                    {
                        return 0;
                    }

                }
            ],
            function start( _event )
            {
                this.Characters.push(_event.m.cannibal.getImagePath());
                this.Characters.push(_event.m.psycho.getImagePath());
                this.Characters.push(_event.m.OtherGuy.getImagePath());

                _event.m.cannibal.improveMood(0.5, "Had a great \"conversation\"");
                _event.m.psycho.improveMood(0.5, "Had a great \"conversation\"");
                _event.m.OtherGuy.worsenMood(0.5, "Overheard a \"great\" \"coversation\"");

                _event.m.psycho.getBaseProperties().DailyFood -= 1.0;
                _event.m.psycho.getSkills().update();

                this.World.Assets.addMoralReputation(-1);

                this.List.push({
                    id = 10,
                    icon = this.Const.MoodStateIcon[_event.m.cannibal.getMoodState()],
                    text = _event.m.cannibal.getName() + this.Const.MoodStateEvent[_event.m.cannibal.getMoodState()]
                });
                this.List.push({
                    id = 10,
                    icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
                    text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
                });
                this.List.push({
                    id = 10,
                    icon = this.Const.MoodStateIcon[_event.m.psycho.getMoodState()],
                    text = _event.m.psycho.getName() + this.Const.MoodStateEvent[_event.m.psycho.getMoodState()]
                });
                this.List.push({
                    id = 16,
                    icon = "ui/icons/asset_food.png",
                    text = _event.m.psycho.getName() + " now consumes [color=" + this.Const.UI.Color.PositiveEventValue + "]50% less[/color] Rations."
                });
                this.List.push({
                    id = 16,
                    icon = "ui/icons/asset_moral_reputation.png",
                    text = _event.m.psycho.getName() + " Your company [color=" + this.Const.UI.Color.NegativeEventValue + "]lost[/color] Reputation."
                });
            }

        });
    }

    function isValid(_camp)
    {
        local brothers = this.World.getPlayerRoster().getAll();
        local psycho_candidates = [];
        local cannibal_candidates = [];
        local other_candidates = [];
        
        foreach( bro in brothers )
        {

            if (bro.getSkills().hasSkill("trait.pov_psychopath") && bro.getBackground().getID() != "background.legend_cannibal")
            {
                psycho_candidates.push(bro);
            }
            else if (bro.getBackground().getID() == "background.legend_cannibal")
            {
                cannibal_candidates.push(bro);
            }
            else
            {
                other_candidates.push(bro);
            }
        }

        if (psycho_candidates.len() == 0 || cannibal_candidates.len() == 0 || other_candidates.len() == 0)
        {
            return;
        }

        this.m.cannibal = cannibal_candidates[this.Math.rand(0, cannibal_candidates.len() - 1)];
        this.m.psycho = psycho_candidates[this.Math.rand(0, psycho_candidates.len() - 1)];
        this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];

        return !isOnCooldown();
    }

    function onPrepare()
    {

    }

    function onPrepareVariables( _vars )
    {
        _vars.push([
            "cannibal",
            this.m.cannibal.getName()
        ]);
        ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.cannibal.getGender(), "cannibal");
        _vars.push([
            "psycho",
            this.m.psycho.getName()
        ]);
        ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.psycho.getGender(), "psycho");
        _vars.push([
            "other",
            this.m.OtherGuy.getName()
        ]);
        ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy.getGender(), "other");
    }

    function onClear()
    {
        this.m.cannibal = null;
        this.m.psycho = null;
        this.m.OtherGuy = null;
    }

});

