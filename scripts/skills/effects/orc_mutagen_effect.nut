this.orc_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0,
		RageStacks = 0
	},
	function create()
	{
		this.m.ID = "effects.orc_mutagen";
		this.m.Name = "Mutation: Orc";
		this.m.Icon = "skills/orc1.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Kinetic Fibers[/color]: This character\'s muscles have mutated in such a way that the they allowing hits to strike harder.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Sensory Redundancy[/color]:This character\'s body has mutated to develop a number of redundant synapses.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Berserker Rage[/color]: This character\'s adrenaline and hormonal glands have mutated, causing an unconsolable rage in battle.";
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
				icon = "ui/icons/armor_damage.png",
				text = "Attacks have an additional [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] effectiveness against armor"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Adds [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gains the ability to charge and stun opponents."
			}
		];

		if (this.m.RageStacks > 0)
		{
			ret.extend([
				{
					id = 12,
					type = "text",
					icon = "ui/icons/sturdiness.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (100 - this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks) * 100) + "%[/color] damage reduction"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.RageStacks + "[/color] damage dealt"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.RageStacks + "[/color] Resolve"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.RageStacks + "[/color] Initiative"
				}
			]);
		}





		return ret;
	}

	function addRage( _r )
	{
		this.m.RageStacks = this.Math.min(this.m.RageStacks + _r, 15);
		local actor = this.getContainer().getActor();

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_143", actor.getTile());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gains rage!");
		}
	}

	function onUpdate( _properties )
	{
		_properties.DamageArmorMult += 0.25;
		_properties.IsResistantToPhysicalStatuses = true;
		_properties.IsProficientWithHeavyWeapons = true;
		_properties.DamageReceivedTotalMult *= this.Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
		_properties.Bravery += 1 * this.m.RageStacks;
		_properties.DamageRegularMin += 1 * this.m.RageStacks;
		_properties.DamageRegularMax += 1 * this.m.RageStacks;
		_properties.Initiative += 1 * this.m.RageStacks;

	}
//Start Rage
	function onTurnEnd()
	{
		this.m.RageStacks = this.Math.max(0, this.m.RageStacks - 1);
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.SkillCount == this.Const.SkillCounter)
		{
			return;
		}

		this.m.SkillCount = this.Const.SkillCounter;

		if (_attacker != null && _attacker.getID() != this.getContainer().getActor().getID() && _damageHitpoints > 0)
		{
			this.addRage(3);
		}
	}

	function onCombatStarted()
	{
		this.m.SkillCount = 0;
		this.m.RageStacks = 0;
	}

	function onCombatFinished()
	{
		this.m.SkillCount = 0;
		this.m.RageStacks = 0;
	}
//End Rage

	function onAdded()
	{

		if (!this.m.Container.hasSkill("actives.legend_charge_skill"))
		{
			this.m.Container.add(::new("scripts/skills/actives/legend_charge_skill"));
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

