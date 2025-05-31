foreach(event in [
	"jousting_tournament_event",
	"traveling_troupe_event",
	"pov_hexemut_brawl_event", 
	"pov_alchemist_wants_mutagen_event",
	"pov_brother_loses_nyctophobia_event",
	"pov_psychopath_vs_cannibal_event"
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
