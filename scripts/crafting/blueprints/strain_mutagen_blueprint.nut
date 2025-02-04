this.strain_mutagen_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.strain_mutagen";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/strain_mutagen_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/undead_alpha_item",
				Num = 3
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
		_stash.add(this.new("scripts/items/misc/anatomist/strain_mutagen_item"));
	
	}

});


