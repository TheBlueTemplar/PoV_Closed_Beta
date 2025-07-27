this.pov_autopsy_lindwurm2_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.pov_autopsy_lindwurm2";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/autopsy/pov_autopsy_lindwurm2_item");
		this.m.Cost = 115;
		local ingredients = [
			{
				Script = "scripts/items/misc/corpse/pov_corpse_lindwurm2_item",
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
		if (this.Math.rand(1, 100) <= 40)
			{
				_stash.add(this.new("scripts/items/misc/anatomist/pov_lindwurm_mutagen_item"));
			}
		if (this.Math.rand(1, 100) <= 75)
			{
				_stash.add(this.new("scripts/items/misc/lindwurm_blood_item"));
			}
		if (this.Math.rand(1, 100) <= 75)
			{
				_stash.add(this.new("scripts/items/misc/lindwurm_scales_item"));
			}
		if (this.Math.rand(1, 100) <= 75)
			{
				_stash.add(this.new("scripts/items/misc/lindwurm_bones_item"));
			}
	}

});

