this.pov_alchemist_wants_mutagen_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_alchemist_wants_mutagen";
        this.m.Name = "Take a stroll through the market...";
		this.m.Event = "event.pov_alchemist_wants_mutagen";
	}
})
