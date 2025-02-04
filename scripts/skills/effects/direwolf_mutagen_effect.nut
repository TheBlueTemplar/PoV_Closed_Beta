this.direwolf_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsUsed = {}
	},
	function create()
	{
		this.m.ID = "effects.direwolf_mutagen";
		this.m.Name = "Mutation: Beast";
		this.m.Icon = "skills/werewolf.png";
		this.m.IconMini = "";
		this.m.Overlay = "werewolf";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Elasticized Sinew[/color]: This character\'s muscles have mutated and respond differently to movement impulses.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Enhanced Vision[/color]: This character\'s eyes have mutated to respond faster and more drastically to low light environments.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Subdermal Clotting[/color]: When this character\'s skin is broken, a substance is secreted that drastically quickens the blood clotting process in the area.";
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
				text = "Movement costs [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less Fatigue."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "+ [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Health"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is immune to bleeding effects."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MovementFatigueCostMult *= 0.5;
		_properties.IsAffectedByNight = false;
		_properties.HitpointsMult *= 1.1;
		_properties.IsImmuneToBleeding = true;
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

 