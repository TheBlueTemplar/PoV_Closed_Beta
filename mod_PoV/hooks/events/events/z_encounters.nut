// New Encounters Made From Events Should Be Added Here 
// Should ditch this method, keeping it in case I need it
/*
foreach(event in [
	//"jousting_tournament_event",
	//"traveling_troupe_event",
	//"pov_hexemut_brawl_event", 
	//"pov_alchemist_wants_mutagen_event",
	//"pov_brother_loses_nyctophobia_event",
	//"pov_psychopath_vs_cannibal_event",
	//"pov_high_renown_event",
	//"pov_look_for_ingredient_event",
	//"pov_flesh_golem_rumor_event",
	//"pov_beastmut_wolf_event"
]) {
	::mods_hookExactClass("events/events/" + event, function(o) {
		o.m.isValidForEncounter <- false;

		local onUpdateScore = o.onUpdateScore;
		o.onUpdateScore = function() {
			onUpdateScore();
			this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
			this.m.Score = 0; // this disables event from happening normally
		}
	})
}
*/