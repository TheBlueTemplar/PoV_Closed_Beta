this.anatomist2_potion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

		if (_actor.getSkills().hasSkill("injury.sickness2"))
		{
			_actor.getSkills().getSkillByID("injury.sickness2").addHealingTime(this.Math.rand(1, 3));
		}
		else
		{
			_actor.getSkills().add(this.new("scripts/skills/injury/sickness2_injury"));
		}

		_actor.getSkills().getSkillByID("injury.sickness2").addHealingTime(7 - _actor.getFlags().getAsInt("ActiveMutations"));
		_actor.getFlags().increment("ActiveMutations");
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		_actor.getFlags().set("PotionLastUsed", time);
		_actor.getFlags().increment("PotionsUsed", 1);
		return true;
	}

});

 