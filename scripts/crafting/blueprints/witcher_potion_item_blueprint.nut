this.witcher_potion_item_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.witcher_potion_item";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/witcher_potion_item");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/misc/third_eye_item",//drop from alp
				Num = 1
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",//drop from hyena NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/poison_gland_item",//drop from spider NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_heart_item",//drop from unhold NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",//drop from direwolf
				Num = 1
			},
			{
				Script = "scripts/items/misc/vampire_dust_item",//drop from vampire NEW
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_brain_item",//drop from nach
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/anatomist/witcher_potion_item"));
	}

});

