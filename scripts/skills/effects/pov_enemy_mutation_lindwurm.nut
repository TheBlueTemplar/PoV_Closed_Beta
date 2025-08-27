this.pov_enemy_mutation_lindwurm <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_lindwurm";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyMutation + "] Wurm's Acid [/color]";
		this.m.Description = "This enemy has some properties of an Wurm! Their blood boils with acid, coating enemies that attack from close.";
		this.m.Icon = "skills/pov_lindwurm_mutant.png";
		this.m.IconMini = "pov_mini_lindwurm_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This enemy has some properties of an Wurm! Their blood boils with acid, coating enemies that attack from close.";
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
				icon = "ui/icons/pov_poison.png",
				text = "This character is [color=" + this.Const.UI.Color.PositiveValue + "]immune[/color] to acid."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/pov_poison.png",
				text = "This character\'s blood burns with [color=" + this.Const.UI.Color.PositiveValue + "]acid[/color], damaging adjacent attacker's armor whenever they deal hitpoint damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Has -[color=" + this.Const.UI.Color.NegativeValue + "]10[/color] Melee Defense."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Lindwurm));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		// Debuffs
		_properties.MeleeDefense += -10;
		_properties.RangedDefense += -5;
	}

	function onAdded()
	{
		this.m.Container.getActor().getFlags().add("body_immune_to_acid");
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints <= 0)
		{
			return;
		}

		if (_attacker == null || !_attacker.isAlive())
		{
			return;
		}

		if (_attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}

		if (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			return;
		}

		if (_attacker.getFlags().has("lindwurm"))
		{
			return;
		}

		if ((_attacker.getFlags().has("body_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Body) <= 0) && (_attacker.getFlags().has("head_immune_to_acid") || _attacker.getArmor(this.Const.BodyPart.Head) <= 0))
		{
			return;
		}

		local poison = _attacker.getSkills().getSkillByID("effects.lindwurm_acid");

		if (poison == null)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/lindwurm_acid_effect"));
		}
		else
		{
			poison.resetTime();
		}

		this.spawnIcon("status_effect_78", _attacker.getTile());
	}

});
