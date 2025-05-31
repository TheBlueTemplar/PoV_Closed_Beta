this.pov_psychopath_vs_cannibal_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_psychopath_vs_cannibal_camp_encounter";
        this.m.Name = "Noise in the camp...";
		this.m.Event = "event.pov_psychopath_vs_cannibal";
	}
})
