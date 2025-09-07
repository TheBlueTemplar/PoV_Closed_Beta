this.pov_flesh_golem_rumor_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {},
    function create()
    {
        this.createScreens();
        this.m.Type = "encounter.pov_flesh_golem_rumor";
        this.m.Name = "A commotion in the square...";
        this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
    }

     function createScreens() 
     {
        this.m.Screens.push({
            ID = "A",
            Title = "A commotion in the square...",
            Text = "[img]gfx/ui/events/pov_square_speech.png[/img]{ You approach the square to see what the commotion is about. A well-dressed, armored figure stands at the center, voice steady, though their eyes betray a flicker of unease. A crowd has gathered, all drawn by whispers carried on the wind, whispers of a new horror. With a booming voice, he shouts: %SPEECH_ON%A threat has been sighted. A foul new breed of abomination now roams the land! Things made of grafted flesh, sewn limb to limb, moaning and screaming with every twisted step. They carry with them the stink of rot, and worse... they do not walk alone! Deranged minds lead them, men who speak to bones and wear madness like a crown. If you value your life, steer well clear.%SPEECH_OFF%Gasps ripple through the crowd. Mothers clutch their children. Old men shake their heads, muttering prayers. But you… you are left with a different impression...}"
            Image = "",
            List = [],
            Characters = [],
            Options = [
                {
                    Text = "That\'s Interesting!",
                    function getResult( _event )
                    {
                        return 0;
                    }

                }
            ],
            function start( _event )
            {
                // Skibidi Gyatt kind of event!
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
        if (this.World.getTime().Days <= 30)
        {
            return false;
        }

        if (!this.World.getTime().IsDaytime)
        {
            return false;
        }

        return !isOnCooldown();
    }

    function onPrepare()
    {
    }

    function onPrepareVariables( _vars )
    {

    }

    function onClear()
    {

    }

});

