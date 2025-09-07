this.pov_schrat_no_shield_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_schrat_no_shield";
		this.m.Name = "No Shield!";
		this.m.Description = "The Vatt\'ghern\'s reliance to shields renders them vulnerable when not equipped with one.";
		this.m.Icon = "skills/pov_schrat_danger.png";
		this.m.IconMini = "pov_mini_schrat_danger";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "TThe Vatt\'ghern\'s reliance to shields renders them vulnerable when not equipped with one. They currently take [color=" + this.Const.UI.Color.NegativeValue + "]more[/color] damage from attacks.\n\n This effect will go away if they reequip a shield!";
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
				icon = "ui/icons/shield_damage.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]+20%[/color] damage when not using a shield."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (this.Tactical.isActive() && actor.isPlacedOnMap())
		{
			this.spawnIcon("pov_medium_schrat_danger", this.getContainer().getActor().getTile());
		}
		
	}

	function onUpdate( _properties )
	{
		//_properties.makeMotherSad = true;
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			this.removeSelf();
		}
	}

});
