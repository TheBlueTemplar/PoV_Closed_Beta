this.pov_autopsy_zombie3_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_zombie3";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_necro_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_necro_item",
				Num = 1
			},
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_legend_field_triage"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/pov_undead_alpha_item"));
			}
		if (this.Math.rand(1, 100) <= 10)
			{
				_stash.add(this.new("scripts/items/misc/legend_ancient_scroll_item"));
			}	
	}

});

