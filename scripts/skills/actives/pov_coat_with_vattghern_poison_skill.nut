this.pov_coat_with_vattghern_poison_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pov_coat_with_vattghern_poison";
		this.m.Name = "Use Vattghern-Poisoned Oil";
		this.m.Description = "Coat your weapons and arrowtips with vattghern poison. Can not be used while engaged in melee.";
		this.m.Icon = "skills/pov_active_coat_vattghern_poison.png";
		this.m.IconDisabled = "skills/pov_active_coat_vattghern_poison_sw.png";
		this.m.Overlay = "active_139";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] attacks will apply the Poisoned status effect for [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] damage per turn. While under this poison, they also losing [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] initiative and damage and [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] vision."
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local poison = _user.getSkills().getSkillByID("effects.pov_vattghern_poison_coat");

		if (poison != null)
		{
			poison.resetTime();
		}
		else
		{
			this.m.Container.add(this.new("scripts/skills/effects/pov_vattghern_poison_coat_effect"));
		}

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.removeSelf();
		}

		return true;
	}

});

