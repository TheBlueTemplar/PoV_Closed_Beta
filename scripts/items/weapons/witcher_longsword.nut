this.witcher_longsword <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 20
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.witcher_longsword";
		this.m.Name = "Beowulf";
		this.m.Description = "A long silver sword.  Perfectly balanced and ideal for slaying monsters.\n\nThis legendary weapon is as old, if not more, than some of the Vatt'ghern.";
		this.m.IconLarge = "weapons/melee/witchersword.png";
		this.m.Icon = "weapons/melee/witchersword_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_longsword_01";
		this.m.Value = 5000;
		this.m.ShieldDamage = 12;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Skills inflict an additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] damage to monsters."
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		
		local slash = this.new("scripts/skills/actives/silverslash");
		slash.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(slash);
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skillToAdd);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties, )
	{

			if (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
			{
				_properties.DamageTotalMult *= 1.20;
			}

	}
	
});

