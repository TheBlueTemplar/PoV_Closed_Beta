this.pov_beastmut_wolf_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_beastmut_wolf_camp_encounter";
        this.m.Name = "A swadow at the edge of the camp!";
		this.m.Event = "event.pov_beastmut_wolf";
	}
})
