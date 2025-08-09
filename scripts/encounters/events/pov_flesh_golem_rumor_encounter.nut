this.pov_flesh_golem_rumor_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_flesh_golem_rumor";
        this.m.Name = "A Commotion at the square...";
		this.m.Event = "event.pov_flesh_golem_rumor";
	}
})
