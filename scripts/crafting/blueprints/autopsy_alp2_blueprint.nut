this.autopsy_alp2_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_alp2";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_alp2_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_alp2_item",
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
				_stash.add(this.new("scripts/items/misc/anatomist/alp_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 50)
			{
				_stash.add(this.new("scripts/items/loot/soul_splinter_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/legend_demon_alp_skin_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/legend_demon_third_eye_item"));
			}
		if (this.Math.rand(1, 100) <= 70)
			{
				_stash.add(this.new("scripts/items/misc/petrified_scream_item"));
			}
	}

});

