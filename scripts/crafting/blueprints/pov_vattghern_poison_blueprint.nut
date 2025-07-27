this.pov_vattghern_poison_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_vattghern_poison";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/pov_vattghern_poison_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 3
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/effects/pov_spider_mutagen_effect"
					//"scripts/skills/perks/perk_legend_potion_brewer"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/pov_vattghern_poison_item"));
	}

});

