this.pov_autopsy_goblin1_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_goblin1";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_goblin1_item");
		this.m.Cost = 105;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_goblin1_item",
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
		if (this.Math.rand(1, 100) <= 8)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/pov_goblin_mutagen_item"));
			}
		//_stash.add(this.new("scripts/items/supplies/strange_meat_item"));
	}

});


