this.pov_emperor_skull_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.pov_emperor_skull_item";
		this.m.Name = "Skull of the Emperor";
		this.m.Description = "This relic is radiating intense magical energy.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_corpse_skeleton4.png";
		//this.m.StaminaModifier = -2;
		this.m.Value = 70;
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
				id = 3,
				type = "image",
				image = "consumables/pov_corpse_skeleton4.png",
		});


		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unlocks new crafting when equipped."
		});

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Experience"
		});
result.push({
	id = 10,
			type = "text",
	icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Resolve"
		});


		return result;

	}

function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local skill = this.new("scripts/skills/effects/pov_emperor_effect");
		skill.setItem(this);
		this.addSkill(skill);

	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.XPGainMult *= 1.2;
		_properties.Bravery += 20;
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

