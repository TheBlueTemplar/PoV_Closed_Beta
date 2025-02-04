this.autopsy_serpent_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_serpent";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_serpent_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_serpent_item",
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
		if (this.Math.rand(1, 100) <= 10)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/spider_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 30)
			{
				_stash.add(this.new("scripts/items/loot/rainbow_scale_item"));
			}
		if (this.Math.rand(1, 100) <= 30)
			{
				_stash.add(this.new("scripts/items/loot/serpent_skin_item"));
			}
		if (this.Math.rand(1, 100) <= 30)
			{
				_stash.add(this.new("scripts/items/loot/glistening_scales_item"));
			}	
		
	}

});

