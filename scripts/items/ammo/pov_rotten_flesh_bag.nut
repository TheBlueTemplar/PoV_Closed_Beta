this.pov_rotten_flesh_bag <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.powder";
		this.m.Name = "Rotten Flesh Powder Bag";
		this.m.Description = "A bag of black powder, grotesqely infused with grafted flesh and the essence of rot. Used for arming exotic firearms, to rain death and rot to any enemy, at the cost of damage. \n\n Is automatically refilled after each battle if you have enough ammunition, and the stomach for it.";
		this.m.Icon = "ammo/pov_flesh_powder_bag.png";
		this.m.IconEmpty = "ammo/pov_flesh_powder_bag_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Powder;
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 750;
		this.m.Ammo = 5;
		this.m.AmmoMax = 5;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Contains powder for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies the [color=" + this.Const.UI.Color.PositiveValue + "]\"Foul Stench\"[/color] effect, as well as lower the morale of enemies hit."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "User has [color=" + this.Const.UI.Color.NegativeValue + "]-5 [/color] Resolve, due to the ammo\'s sickening stench."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]-15% [/color] ranged damage, with [color=" + this.Const.UI.Color.NegativeValue + "]-25% [/color] effectiveness against armor"
		});

		return result;
	}

	function onEquip()
	{
		this.ammo.onEquip();
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/pov_rotten_flesh_ammo_effect"));
	}

	function onUnequip()
	{
		this.ammo.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.pov_rotten_flesh_ammo");
	}

});

