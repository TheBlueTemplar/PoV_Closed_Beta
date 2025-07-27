this.pov_autopsy_basilisk_sentry_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_basilisk_sentry";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_basilisk_sentry_item");
		this.m.Cost = 115;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_basilisk_sentry_item",
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
		if (this.Math.rand(1, 100) <= 15)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/pov_basilisk_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 60)
			{
				_stash.add(this.new("scripts/items/misc/legend_basilisk_eye_item"));
			}
		if (this.Math.rand(1, 100) <= 60)
			{
				_stash.add(this.new("scripts/items/misc/legend_basilisk_feathers_item"));
			}
		if (this.Math.rand(1, 100) <= 50)
			{
				_stash.add(this.new("scripts/items/loot/legend_basilisk_talon_item"));
			}
	}

});

