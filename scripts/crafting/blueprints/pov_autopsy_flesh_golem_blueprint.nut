this.pov_autopsy_flesh_golem_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_flesh_golem";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_flesh_golem_item");
		this.m.Cost = 110;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_flesh_golem_item",
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
				_stash.add(this.new("scripts/items/misc/pov_grafted_flesh_item"));
			}
		if (this.Math.rand(1, 100) <= 25)
			{
				_stash.add(this.new("scripts/items/loot/pov_ivory_spine_shard_item"));
			}
		if (this.Math.rand(1, 100) <= 10)
			{
				_stash.add(this.new("scripts/items/loot/pov_rot_essence_special_item"));
			}
	}

});

