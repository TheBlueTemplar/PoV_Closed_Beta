this.skeleton_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.skeleton_mutagen";
		this.m.Name = "Mutation: Undeath";
		this.m.Icon = "skills/skele.png";
		this.m.IconMini = "";
		this.m.Overlay = "skele";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Curse Essence[/color]: This character\'s body is sustained by the curse of undeath.  They require less food and do not tire as quickly.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Synapse Blockage[/color]: This character\'s body has mutated in such a way that their fight-or-flight response is altered, increasing their resolve.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Subdermal Stitching[/color]: This character\'s skin and subdermal tissue has mutated and will rapidly stitch back together.";
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
				text = "Reduces the Fatigue cost actions by[color=" + this.Const.UI.Color.PositiveValue + "] 30%[/color]."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "This character consumes [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less food."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "This character has plus [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] to bravery."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character takes [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueEffectMult = 0.7;
		_properties.Bravery *= 1.2;
		_properties.DailyFood *= 0.5;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.fire_handgonne")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
		else if (_skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.ignite_firelance")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.lunge" || _skill.getID() == "actives.throw_spear")
		{
			_properties.DamageReceivedRegularMult *= 0.50;
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

