::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o){
	
    local pov_general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
    o.general_queryUIElementTooltipData = function (_entityId, _elementId, _elementOwner)
    {
		
        switch (_elementId)
        {
            case "menu-screen.new-campaign.EasyDifficulty":
            return [
                {
                    id = 1,
                    type = "title",
                    text = "Beginner Difficulty"
                },
                {
                    id = 2,
                    type = "description", //Enemy scaling is same as normal, but 25% easier per bro.
                    text = "We all start somewhere.\n\n Enemy scaling rarely matches your own company strength one-to-one, often giving you an innate advantage in battles. Your fighters will gain bonus experience and retreating from battle is easier and less risky. You have a slight base positive hitchance modifier while your enemies have a negative one.\n\n [color="+ ::Const.UI.Color.povTooltipBlue +"] Combat difficulty affects most mechanics of PoV. On beginner difficulty, most effects buffing enemies will not appear, while enemy mutations will be very rare. Coprse and mutagen drop rates are also increased. It is earier to make a vattghern. [/color]\n\nRecommended for players new to the game or still learning."
                }
            ];

        case "menu-screen.new-campaign.NormalDifficulty":
            return [
                {
                    id = 1,
                    type = "title",
                    text = "Veteran Difficulty"
                },
                {
                    id = 2,
                    type = "description",
                    text = "Provides for a balanced playing experience that can be quite challenging at times.\n\n Enemy scaling typically matches your company strength one-to-one. You may experience some difficult fights, but rarely anything you cannot handle — unless you seek one out. You have a slight base positive hitchance modifier for all attacks against your enemies.\n\n [color="+ ::Const.UI.Color.povTooltipBlue +"] Combat difficulty affects most mechanics of PoV. On normal difficulty, most enemy monsters are buffed, but enemy mutations are still quite rare. Corpse and mutagen drop rates are very slightly increased. [/color]\n\nRecommended for players who enjoy a firm but fair experience in battles."
                }
            ];

        case "menu-screen.new-campaign.HardDifficulty":
            return [
                {
                    id = 1,
                    type = "title",
                    text = "[color="+ ::Const.UI.Color.povTooltipRed +"]Expert Difficulty[/color]"
                },
                {
                    id = 2,
                    type = "description",
                    text = "The odds are against you. This is the intended difficulty and the one Legends is balanced around.\n\n Scaling is easier early game, then 1.5x as hard as normal for mid to late game. Enemies have a slight base hitchance modifier to strike you. \n\n [color="+ ::Const.UI.Color.povTooltipBlue +"] Combat difficulty affects most mechanics of PoV, which is designed and balanced around expert difficulty. All the mechanics of PoV are present, and all chances (corpse,mutation etc.) are at their base value. Expect this to be a fair challenge. [/color]\n\nRecommended for players who have mastered Vanilla and enjoy a tough, yet tactical experience."
                }
            ];

        case "menu-screen.new-campaign.LegendaryDifficulty":
            return [
                {
                    id = 1,
                    type = "title",
                    text = "[color="+ ::Const.UI.Color.povTooltipRed +"]Death March[/color]"
                },
                {
                    id = 2,
                    type = "description",
                    text = "[color="+ ::Const.UI.Color.povTooltipGray +"](Same as Legendary Difficulty)[/color] Evil lurks in every corner — this is where legends are forged.\n\n All enemies gain new perks, some have new effects entirely. Scaling and mechanics is about that of Expert early game, but will rapidly increase mid-late game. Expect to see more champions earlier and harder enemies much sooner — along with the the experience and equipment they bring... \n\n [color="+ ::Const.UI.Color.povTooltipRed +"] Combat difficulty affects many different mechanics of PoV. Death March is the \"hard\" mode of this mod. Most drop chances are lower, it is harder to get a vattghern, and enemy mutations will appear much more often! This is meant to be hard, so only complain if it isn\'t! [/color]\n\n Recommended for those who enjoy a tactical challenge and can accept losses for a greater good."
                }
            ];
                
        }

        return pov_general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

    // DO NOTHING
});