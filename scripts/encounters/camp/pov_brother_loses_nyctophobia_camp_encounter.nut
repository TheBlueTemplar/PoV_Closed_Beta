this.pov_brother_loses_nyctophobia_camp_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
        vattghern = null
    },
    function create()
    {
        this.createScreens();
        this.m.Type = "encounter.pov_brother_loses_nyctophobia_camp_encounter";
        this.m.Name = "A shadow at the edge of camp...";
        this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
    }

    function createScreens() 
    {
        this.m.Screens.push({
            ID = "A",
            Title = "Fear Defeated",
            Text = "[img]gfx/ui/events/pov_lose_nyctophobia.png[/img]{You find %vattghern% sitting at the very edge of camp, where the firelight fades and shadows gather thickly. It\'s strange... not long ago, the %person_vattghern% would barely leave the tents at night without a torch clutched tight in %their_vattghern% hand. Now %they_vattghern% sits there calmly, staring into the darkness as though it were an old friend.\n\n You approach quietly, half-expecting %them_vattghern% to flinch or retreat, but %they_vattghern% does neither. Instead, %they_vattghern% glances over %their_vattghern% shoulder with a half-smile, one corner of %their_vattghern% mouth twitching in amusement.%SPEECH_ON% Strange, isn\'t it? I used to fear the dark. Now... it feels like home.%SPEECH_OFF% %They_vattghern% turns %their_vattghern% gaze back to the night, eyes sharp, almost glowing faintly in the moonlight, a lingering gift of the mutagen.%SPEECH_ON% I thought the dark was hiding monsters. I was wrong. The dark hides me.%SPEECH_OFF% There\'s a lightness in %their_vattghern% voice, a kind of fierce pride that wasn\'t there before. You can\'t help but smirk at the realization: %vattghern% hasn\'t just conquered %their_vattghern% fear, %they_vattghern%\'s embraced the night itself. As you leave %their_vattghern% there, a half-joking thought crosses your mind: perhaps all %they_vattghern%\'s missing now is a cloak and a cowl...}" 
            Image = "",
            List = [],
            Characters = [],
            Options = [
                {
                    Text = "Good to know that my men don\'t fear the night...",
                    function getResult( _event )
                    {
                        return 0;
                    }

                }
            ],
            function start( _event )
            {
                this.Characters.push(_event.m.vattghern.getImagePath());
                
                local traitOld = _event.m.vattghern.getSkills().getSkillByID("trait.pov_nyctophobia");
                _event.m.vattghern.getSkills().remove(traitOld);

                local resolve_boost = this.Math.rand(1, 2);
                _event.m.vattghern.getBaseProperties().Bravery += resolve_boost;
                _event.m.vattghern.getSkills().update();

                this.List.push({
                    id = 10,
                    icon = traitOld.getIcon(),
                    text = _event.m.vattghern.getName() + " is no longer afraid of the night..."
                });
                this.List.push({
                    id = 16,
                    icon = "ui/icons/bravery.png",
                    text = _event.m.vattghern.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
                });

                _event.m.vattghern.improveMood(1.0, "I am the night");

                if (_event.m.vattghern.getMoodState() > this.Const.MoodState.Neutral)
                {
                    this.List.push({
                        id = 10,
                        icon = this.Const.MoodStateIcon[_event.m.vattghern.getMoodState()],
                        text = _event.m.vattghern.getName() + this.Const.MoodStateEvent[_event.m.vattghern.getMoodState()]
                    });
                }
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
            return false;
        }

        local brothers = this.World.getPlayerRoster().getAll();
        local pussy_candidates = [];

        foreach( bro in brothers )
        {
            if (bro.getSkills().hasSkill("trait.pov_nyctophobia"))
            {
                if (bro.getSkills().hasSkill("effects.pov_skeleton_mutagen") || bro.getSkills().hasSkill("effects.pov_ghost_mutagen") || bro.getSkills().hasSkill("effects.pov_alp_mutagen") || bro.getSkills().hasSkill("effects.pov_direwolf_mutagen") || bro.getSkills().hasSkill("effects.pov_vampire_mutagen") || bro.getCurrentProperties().Bravery > 90)
                {
                    pussy_candidates.push(bro);
                }
            }
        }

        if (pussy_candidates.len() == 0)
        {
            return;
        }

        return !isOnCooldown();
    }

    function onPrepare()
    {
        
    }

    function onPrepareVariables( _vars )
    {
        _vars.push([
            "vattghern",
            this.m.vattghern.getName()
        ]);
        ::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vattghern.getGender(), "vattghern");
    }

    function onClear()
    {
        this.m.vattghern = null;
    }

});

