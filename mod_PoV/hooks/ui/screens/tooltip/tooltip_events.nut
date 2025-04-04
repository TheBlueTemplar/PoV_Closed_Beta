/*::TLW.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	// Failed attempt for now
	q.general_queryUIElementTooltipData = @(__original) function (_entityId, _elementId, _elementOwner )
	{
		__original()

		if (_elementId == "menu-screen.new-campaign.LegendaryDifficulty")
		{
			return [
				{
					id = 1,
					type = "title",
					text = "Death March"
				},
				{
					id = 2,
					type = "description",
					text = "Evil lurks in every corner — this is where legends are forged.\n\n All enemies gain new perks, some have new effects entirely. Scaling and mechanics is about that of Expert early game, but will rapidly increase mid-late game. Expect to see more champions earlier and harder enemies much sooner — along with the the experience and equipment they bring... \n\n All mechanics of the PoV mod are also deeply affected by this setting, expect quite a challenge! \n\n Recommended for those who enjoy a tactical challenge and can accept losses for a greater good."
				}
			];
		}
		return (_entityId, _elementId, _elementOwner);
	}

});*/