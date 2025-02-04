this.autopsy_ghoul2_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_ghoul2";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_ghoul2_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_ghoul2_item",
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
		if (this.Math.rand(1, 100) <= 25)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/ghoul_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 60)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/ghoul_teeth_item"));
			}
		if (this.Math.rand(1, 100) <= 60)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/ghoul_horn_item"));
			}
		if (this.Math.rand(1, 100) <= 60)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/ghoul_brain_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/legend_skin_ghoul_skin_item"));
			}	
		if (this.Math.rand(1, 100) <= 50)
			{
				_stash.add(this.new("scripts/items/loot/growth_pearls_item"));
			}	

	}

});

