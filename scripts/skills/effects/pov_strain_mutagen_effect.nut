this.pov_strain_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_strain_mutagen";
		this.m.Name = "Mutation: The Strain";
		this.m.Icon = "skills/pov_necro.png";
		this.m.IconMini = "";
		this.m.Overlay = "necro";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Dark Visions[/color]: This character has strange visions of things that have been and things to come.  It gives them a certain ability to connect and internalize new experiences faster. On the other hand, these same visions cause extreme distress to the Vatt\'ghern\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Reactive Muscle Tissue[/color]: This character\'s body reacts to physical trauma, secreting a calciferous substance that causes their muscles to reflexively sieze and contract at points of impact to minimize muscle damage, reducing the chances of injury in battle. But, this reactivity works against the character when attacked with fire.\n\n[color=" + this.Const.UI.Color.PositiveValue + "]Foul Stench[/color]: This character also emits a very powerful smell in battle, which really helps to disorient its enemies. This comes at the further cost of the subject\'s sanity.";
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
				text = "This character gains the [color=#044391] Foul Stench [/color] Passive ability when in battle."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "This character suffers [color=" + this.Const.UI.Color.PositiveValue + "]no fatigue[/color] from enemy attacks"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Experience Gain"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Lose [color=" + this.Const.UI.Color.NegativeValue + "]30% + 12[/color] Resolve, due to dark visions"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_fire.png",
				text = "This character takes [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] more damage from fire attacks."
			}
		];
		return ret;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/pov_unbearable_stench_passive_effect"));
	}

	function onUpdate( _properties )
	{
		// Buffs
		_properties.XPGainMult *= 1.20;
		_properties.FatigueLossOnAnyAttackMult = 0.0;
		_properties.ThresholdToReceiveInjuryMult *= 1.50;
		// Debuffs
		_properties.BraveryMult *= 0.70;
		_properties.Bravery += -12;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Burning)
		{
			_properties.DamageReceivedRegularMult *= 1.5;
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

