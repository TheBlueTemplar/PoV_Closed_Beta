this.autopsy_ifrit_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_ifrit";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_ifrit_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_ifrit_item",
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
				_stash.add(this.new("scripts/items/misc/anatomist/ifrit_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/loot/glittering_rock_item"));
			}
		if (this.Math.rand(1, 100) <= 20)
			{
				_stash.add(this.new("scripts/items/trade/uncut_gems_item"));
			}
		if (this.Math.rand(1, 100) <= 35)
		{
			_stash.add(this.new("scripts/items/misc/sulfurous_rocks_item"));
		}
	}

});

