this.pov_brother_loses_nyctophobia_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_brother_loses_nyctophobia_camp_encounter";
        this.m.Name = "A swadow at the edge of the camp!";
		this.m.Event = "event.pov_brother_loses_nyctophobia";
	}
})
