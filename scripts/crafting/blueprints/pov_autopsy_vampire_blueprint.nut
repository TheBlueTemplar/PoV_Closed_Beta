this.pov_autopsy_vampire_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_vampire";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_vampire_item");
		this.m.Cost = 105;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_vampire_item",
				Num = 1
			},
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
							"scripts/skills/perks/perk_legend_potion_brewer"
							]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		if (this.Math.rand(1, 100) <= 10)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/pov_vampire_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 15)
			{
				_stash.add(this.new("scripts/items/misc/legend_ancient_scroll_item"));
			}
		if (this.Math.rand(1, 100) <= 35)
			{
				_stash.add(this.new("scripts/items/misc/vampire_dust_item"));
			}
	}

});

