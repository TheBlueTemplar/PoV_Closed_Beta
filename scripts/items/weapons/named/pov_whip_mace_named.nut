this.pov_whip_mace_named <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		//PossibleEffects = ["scripts/skills/effects/pov_legend_named_flail_effect"],
		//EffectBounds = [ [100, 100] ]
		//StunChance = 20
	},
	function create()
	{

		local NameList = ["Belmond's Wrath","Chain Flail of the Belmonds","Belmond's Vengeance","Scourge of the Undead", "Blessed Ironlash", "Vampirebane Whip", "Belmond's Caress"];

		this.named_weapon.create();
		this.m.ID = "weapon.pov_whip_mace_named";
		this.m.Name = NameList[this.Math.rand(0, NameList.len() - 1)];
		//this.m.NameList = ["name1","name2","name3"];
		this.m.Description = "An ancient relic. No one knows about its origin, or why it retaining a pristine condition despite its obvious centuries of use.\n\nIt is like a morning star, tied at the end of a metal whip. While elaborate in it's design, it is in many ways impractical and hard to handle, only a skilled individual could use this properly. \n\n It appears to bear traces of an old blessing or enchantment against undead.";
		this.m.IconLarge = "weapons/melee/pov_mace_whip_01_named.png";
		this.m.Icon = "weapons/melee/pov_mace_whip_01_named_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		//this.m.Categories = "Flail, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsDoubleGrippable = false;
		//this.m.IsAgainstShields = true;
		//this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "pov_icon_mace_whip_named";
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.Value = 4000;
		//this.m.ShieldDamage = 12;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
		this.randomizeValues();
	}


	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts an additional [color=" + this.Const.UI.Color.DamageValue + "]10%[/color] damage to undead."
		});
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Also, [color=" + this.Const.UI.Color.DamageValue + "]concecrates[/color] any undead hit, making them take damage over time, and susceptible to bleeding, poison and injuries."
		});
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		//this.addSkill(this.new("scripts/skills/actives/legend_ranged_lash_skill"));
		local whipFlail = this.new("scripts/skills/actives/pov_whip_flail_skill");
		whipFlail.m.Icon = "skills/active_pov_flail_named.png";
		whipFlail.m.IconDisabled = "skills/active_pov_flail_named_sw.png";
		this.addSkill(whipFlail);

		local slam = this.new("scripts/skills/actives/pound");
		slam.m.Name = "Whip Slam";
		slam.m.Icon = "skills/active_pov_pound_named.png";
		slam.m.IconDisabled = "skills/active_pov_pound_named_sw.png";
		slam.m.FatigueCost = 20;
		this.addSkill(slam);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties)
	{
			if (_targetEntity != null)
			{
				if (_targetEntity.getFlags().has("undead"))
				{
					//local holyFlame = this.new("scripts/skills/effects/legend_consecrated_effect");
					//_targetEntity.getSkills().add(holyFlame);
					//holyFlame.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
					_properties.DamageTotalMult *= 1.10;
				}
			}

	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		if ( _skill == null || _skill.m.IsWeaponSkill == false )
			return;

		if (!_target.isAlive() || _target.isDying())
			return;

		//local user = this.getContainer().getActor();

			if (_target.getFlags().has("undead"))
			{
				local holyFlame = this.new("scripts/skills/effects/legend_consecrated_effect");
				holyFlame.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
				_target.getSkills().add(holyFlame);


				//if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer && !_targetEntity.isHiddenToPlayer())
				//{
				//	this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that concecrated " + this.Const.UI.getColorizedEntityName(_targetEntity));
				//}
			}
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

