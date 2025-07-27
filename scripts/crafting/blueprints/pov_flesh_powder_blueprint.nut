this.pov_flesh_powder_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_flesh_powder";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/ammo/pov_rotten_flesh_bag");
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/ammo/powder_bag",
				Num = 1
			},
			{
				Script = "scripts/items/misc/pov_grafted_flesh_item",
				Num = 3
			},
			{
				Script = "scripts/items/loot/pov_rot_essence_special_item",
				Num = 1
			}
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
		_stash.add(this.new("scripts/items/ammo/pov_rotten_flesh_bag"));
	}

});

