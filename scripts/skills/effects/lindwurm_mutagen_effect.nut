this.lindwurm_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.lindwurm_mutagen";
		this.m.Name = "Mutation: Wurm";
		this.m.Icon = "skills/lindwurm.png";
		//this.m.IconMini = "status_effect_140_mini";
		this.m.Overlay = "lindwurm";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Acidic blood[/color]: This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray.";
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
				text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is immune to acid."
			}
			
		];
		return ret;
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

	function inBattleHiddenCheck()
	{
		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return false;
		}

		return true;
	}

});

