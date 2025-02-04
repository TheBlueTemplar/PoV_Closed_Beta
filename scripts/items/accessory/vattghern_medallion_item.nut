this.vattghern_medallion_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.vattghern_medallion";
		this.m.Name = "Vatt\'ghern Medallion";
		this.m.Description = "A Vatt'ghern medallion, forged from iron and darkened with age, bears the symbol of a fierce wolf, its eyes glinting with a crimson hue.\n\nWorn by the few who have faced the Trial of the Grasses, it serves as both a mark of honor and a reminder of the bloodshed endured to become something more than human.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/vattghern_medallion.png";
		this.m.Sprite = "vattghern_medallion";
		this.m.Value = 1000;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.Bravery += 10;
		_properties.Threat += 10;
	}

});

