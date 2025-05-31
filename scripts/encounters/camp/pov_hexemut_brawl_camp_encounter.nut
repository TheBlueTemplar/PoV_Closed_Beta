this.pov_hexemut_brawl_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_hexemut_brawl_camp_encounter";
        this.m.Name = "Noise in the Camp...";
		this.m.Event = "event.pov_hexemut_brawl";
	}
})
