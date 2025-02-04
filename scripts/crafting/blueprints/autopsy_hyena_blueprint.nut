this.autopsy_hyena_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.autopsy_hyena";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy_hyena_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse_hyena_item",
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
				_stash.add(this.new("scripts/items/misc/anatomist/direwolf_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 20)
			{
				_stash.add(this.new("scripts/items/loot/sabertooth_item"));
			}
		if (this.Math.rand(1, 100) <= 30)
			{
				_stash.add(this.new("scripts/items/misc/hyena_fur_item"));
			}
		if (this.Math.rand(1, 100) <= 30)
			{
				_stash.add(this.new("scripts/items/misc/acidic_saliva_item"));
			}
		_stash.add(this.new("scripts/items/supplies/strange_meat_item"));
	}

});

