this.pov_orc_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0,
		RageStacks = 0
	},
	function create()
	{
		this.m.ID = "effects.pov_orc_mutagen";
		this.m.Name = "Mutation: Orc";
		this.m.Icon = "skills/pov_orc1.png";
		this.m.IconMini = "";
		this.m.Overlay = "orc1";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Kinetic Fibers[/color]: This character\'s muscles have mutated in such a way that the they allow the use of large, unqieldy orc weapons, while also improving the user's strength.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Hightened Agressiveness[/color]:This character\'s nervous system was tweaked to be a pool of endless rage. The Vatt\'ghern gains the charge ability, but has little mind to defend himself properly. When injured, they receive a temporary boost to their agression.";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can wield [color=" + this.Const.UI.Color.PositiveValue + "]orc weapons[/color] without the fatigue penalty on use."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gets [color=" + this.Const.UI.Color.PositiveValue + "]Temporary Buffs[/color] when injured."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gains the ability to [color=" + this.Const.UI.Color.PositiveValue + "]charge[/color] and stun opponents."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Does [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] overall damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Gains a [color=" + this.Const.UI.Color.NegativeValue + "]15% + 7[/color] reduction to Ranged Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-4[/color] Melee Defense for each surrounding enemy."
			}
		];

		return ret;
	}

	

	function onUpdate( _properties )
	{
		// Buffs
		// Charge Ability
		_properties.DamageTotalMult *= 1.10;
		_properties.IsProficientWithHeavyWeapons = true;
		// Debuffs
		_properties.RangedDefense += -7;
		_properties.RangedDefenseMult *= 0.85;
		_properties.SurroundedDefense -= 4;

	}

	function onAdded()
	{

		if (!this.m.Container.hasSkill("actives.pov_charge"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pov_charge_skill"));
		}

		this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons = true;
		local equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}

		equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}


	function isHidden()
	{
		return this.inBattleHiddenCheck();
	}

	function inBattleHiddenCheck()
	{
		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return false;
		}

		return true;
	}

});

