this.pov_grafted_flesh_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.pov_grafted_flesh";
		this.m.Name = "Grafted Flesh";
		this.m.Description = "A diisgusting blob of mismatched flesh, harvested from the corpse of a flesh golem. Despite the horrendous grafting process, and the battle that it saw, this piece is in excellent condition. \n\n This piece seems easy to be morphed into something else, allowing some deranged invidivuals to find some pretty practical applications...";
		this.m.Icon = "misc/pov_inventory_grafted_flesh.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1250;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/cleave_hit_hitpoints_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function getSellPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return this.World.State.getCurrentTown().getBeastPartsPriceMult();
	}

});

