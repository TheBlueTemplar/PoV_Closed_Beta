this.goblin_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.goblin_mutagen";
		this.m.Name = "Mutation: Goblin";
		this.m.Icon = "skills/goblin.png";
		this.m.IconMini = "";
		this.m.Overlay = "goblin";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Reactive Muscles[/color]: This character\'s muscles have mutated, allowing them to make swift, complex movements.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Mutated Cornea[/color]: This character\'s eyes have mutated and are now capable of detecting the subtlest movements of wind and air. This allows them to better predict the trajectory of projectile attacks.";
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
				icon = "ui/icons/action_points.png",
				text = "The action point and fatigue costs of movement is greatly reduced."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Gain a [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] bonus to initiative."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] of ranged skill."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance that a shot can not be blocked."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Aimed Shot AP cost reduced by [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]."
			}
			
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		
		_properties.MovementFatigueCostAdditional *= 0.5;
		_properties.RangedSkillMult *= 1.2;
		_properties.RangedAttackBlockedChanceMult = 0.5;
		_properties.InitiativeMult *= 1.2;
	}

	function onAfterUpdate(_properties)
	{
		
		local aimedShot = this.getContainer().getSkillByID("actives.aimed_shot");
		if (aimedShot != null)
		{
			aimedShot.m.ActionPointCost -= 2;
		};
		local sprint = this.getContainer().getSkillByID("actives.sprint");
		if (sprint != null)
		{
			sprint.m.ActionPointCost = 2;
			sprint.m.FatigueCost *= 0.5
		};
		local footwork = this.getContainer().getSkillByID("actives.footwork");
		if (footwork != null)
		{
			footwork.m.ActionPointCost = 2;
			footwork.m.FatigueCost *= 0.5
		};
		local rotation = this.getContainer().getSkillByID("actives.rotation");
		if (rotation != null)
		{
			rotation.m.ActionPointCost = 2;
			rotation.m.FatigueCost *= 0.5
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




