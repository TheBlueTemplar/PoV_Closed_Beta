this.pov_whip_mace <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		//StunChance = 20
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.pov_whip_mace";
		this.m.Name = "Whip Flail";
		this.m.Description = "An eccentric weapon combining the qualities of the flail and the whip\n\nIt is in many ways impractical and hard to handle, only a skilled individual could use this properly";
		this.m.IconLarge = "weapons/melee/pov_mace_whip_01.png";
		this.m.Icon = "weapons/melee/pov_mace_whip_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		//this.m.Categories = "Flail, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsDoubleGrippable = false;
		//this.m.IsAgainstShields = true;
		//this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "pov_icon_mace_whip";
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.Value = 3000;
		//this.m.ShieldDamage = 12;
		this.m.Condition = 70.0;
		this.m.ConditionMax = 70.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
	}

/*
	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts an additional [color=" + this.Const.UI.Color.DamageValue + "]50%[/color] damage to monstesr."
		});
		return result;
	}
*/
	function onEquip()
	{
		/*
		this.weapon.onEquip();
		local slash = this.new("scripts/skills/actives/pov_silverslash");
		slash.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(slash);
		*/

		/*
		// This was my first time testing this, used a modified legends skill!
		this.weapon.onEquip();
		local longFlail = this.new("scripts/skills/actives/legend_ranged_flail_skill");
		longFlail.m.MaxRange = 3;
		longFlail.m.Name = "Whip Flail";
		longFlail.m.FatigueCost = 16;
		this.addSkill(longFlail);
		*/

		this.weapon.onEquip();
		//this.addSkill(this.new("scripts/skills/actives/legend_ranged_lash_skill"));
		this.addSkill(this.new("scripts/skills/actives/pov_whip_flail_skill"));

		local slam = this.new("scripts/skills/actives/pound");
		slam.m.Name = "Whip Slam";
		slam.m.Icon = "skills/active_76.png";
		slam.m.IconDisabled = "skills/active_76_sw.png";
		slam.m.FatigueCost = 20;
		this.addSkill(slam);

	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

