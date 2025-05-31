this.pov_silvering_kit <- this.inherit("scripts/items/item", {
	m = {
		Item = null
	},
	function create()
	{
		this.item.create();
		this.m.ID = "special.silvering_kit";
		this.m.Name = "Silvering Kit";
		this.m.Description = "A special kit, frequently sought after by professional monster hunters. It contains special oils and alloys for coating a weapon with silver. \n\n The special mixture digs into the metals of the weapon itself, giving it potent properties agains monstrous and supernatural enemies, though it overall weakens the weapon's durability, and efficiency against humans.";
		this.m.Icon = "special/pov_silvering_kit.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 2000;
	}

	function getTooltip()
	{
		local result = this.item.getTooltip();
		result.push({
			id = 3,
			type = "text",
			text = "Use to coat a melee weapon in silver, causing it to deal [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Damage to enemy beasts. Gain [color=" + this.Const.UI.Color.PositiveValue + "]half[/color] of this bonus against Mutants, and the Undead. Also, Deal [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Damage to enemy humans and other humanoids.\n\n The weapon will also lose [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color] of its maximum durability."
		});
		return result;
	}

	function onUse( _actor, _item = null )
    {
		local mainhand = _actor.getMainhandItem();
		if (mainhand == null)
			return false;

		if (!mainhand.isItemType(this.Const.Items.ItemType.MeleeWeapon)) 
		{
			this.Sound.play("sounds/upgrade/pov_silvered_fail.wav");
			return false;
		}

		if (mainhand.isSilvered()) 
		{
			this.Sound.play("sounds/upgrade/pov_silvered_fail.wav");
			return false;
		}

		if (mainhand.m.ID == "weapon.pov_witcher_longsword") 
		{
			this.Sound.play("sounds/upgrade/pov_silvered_fail.wav");
			return false;
		}

		mainhand.setSilvered();
		this.Sound.play("sounds/upgrade/pov_silvered.wav");
		return true;
    }
});

