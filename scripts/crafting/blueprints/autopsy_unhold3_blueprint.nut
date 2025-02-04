this.autopsy_unhold3_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_unhold3";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_unhold3_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_unhold3_item",
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
		if (this.Math.rand(1, 100) <= 20)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/unhold_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 50)
			{
				_stash.add(this.new("scripts/items/loot/deformed_valuables_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/unhold_bones_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/unhold_hide_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/unhold_heart_item"));
			}
		_stash.add(this.new("scripts/items/supplies/strange_meat_item"));
	}

});

