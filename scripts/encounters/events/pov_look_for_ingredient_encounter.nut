this.pov_look_for_ingredient_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.pov_look_for_ingredient";
        this.m.Name = "Look For a Missing Ingredient...";
		this.m.Event = "event.pov_look_for_ingredient";
	}
})
