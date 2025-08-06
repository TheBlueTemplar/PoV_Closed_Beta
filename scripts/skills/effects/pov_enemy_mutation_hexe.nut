this.pov_enemy_mutation_hexe <- this.inherit("scripts/skills/skill", {
	m = {
		canHex = true
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_hexe";
		this.m.Name = "[color=#034207] Hexen Curse [/color]";
		this.m.Description = "This enemy has some properties of an Orc! They are much more agressive, and deal more damage, at the cost of their defences.";
		this.m.Icon = "skills/pov_hexe_mutant.png";
		this.m.IconMini = "pov_mini_hexe_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "They are much more agressive, and deal more damage, at the cost of their defences.";
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
				icon = "ui/icons/ranged_defense.png",
				text = "Gains a [color=" + this.Const.UI.Color.NegativeValue + "]10% + 4[/color] reduction to Ranged Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]10% + 4[/color] reduction to Melee Defense."
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Has + [color=" + this.Const.UI.Color.PositiveValue + "]10% + 5[/color] Melee skill and + [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Melee Damage."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Hexe));
	  	}
	}

	function onUpdate( _properties )
	{
		// Buffs
		
		// Debuffs

	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		// Fallback, fix for some crash (corpse explosion caused it?)
		if (_attacker == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		if (this.m.canHex == true && !_attacker.getSkills().hasSkill("effects.pov_hexe_mutagen"))
		{
			if (_attacker.getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
			{
				if (!_user.isHiddenToPlayer() && !_attacker.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_attacker) + " resists being hexed thanks to his unnatural physiology");
				}
				return false;
			}

			local color;
			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("effect_pentagram_02", color, actor.getTile(), !_attacker.getSprite("status_hex").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local slave = this.new("scripts/skills/effects/pov_hexe_curse_slave_effect");
			local master = this.new("scripts/skills/effects/pov_hexe_curse_master_effect");

			slave.setMaster(master);
			slave.setColor(color);
			_attacker.getSkills().add(slave);
			master.setSlave(slave);
			master.setColor(color);
			actor.getSkills().add(master);
			slave.activate();
			master.activate();

			this.m.canHex = false;
		}
	}
});
