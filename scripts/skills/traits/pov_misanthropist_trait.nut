this.pov_misanthropist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		KillsSatisfied = false,
		KillsToSatisfy = 100,
		HumanKills = 0
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_misanthropist";
		this.m.Name = "Misanthropist";
		this.m.Icon = "ui/traits/pov_misanthropist.png";
		this.m.Description = "%name% seems like your average mercenary. But this one does not kill only for coin, but also for blood. Noone knows how this came to be, but an eerie [color=" + this.Const.UI.Color.NegativeValue + "]grin[/color] appears whenever he slays a human enemy, his smile widening ever so slightly, his eyes glinting at the sight of a life being taken. \n\n Sometimes at night, this individual can be heard mumbling the number of enemies killed, with increasing satisfaction...";
		this.m.IsSerialized = true;
	}



	function getTooltip()
	{
		local result = [
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
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Resolve when in a battle against humans"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+4[/color] Melee Skill when in a battle against humans"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+4[/color] Ranged Skill when in a battle against humans"
			}
		];

		//local kills = this.getContainer().getActor().getLifetimeStats().Kills;
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/kills.png",
			text = "This character boasts [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.HumanKills + "[/color] human lives that he personally \"collected\"."
		});

		return result;

	}


	function onCombatStarted()
	{
		if (this.m.HumanKills >= this.m.KillsToSatisfy)
		{
			this.m.KillsSatisfied = true;
		}
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingHumans = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (enemy.getFlags().has("human"))
			{
				fightingHumans = true;
				break;
			}
		}

		if (fightingHumans)
		{
			// Buffs
			_properties.Bravery += 5;
			_properties.MeleeSkill += 4;
			_properties.RangedSkill += 4;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_targetEntity.getXPValue() > 0 && _targetEntity.getFlags().has("human"))
		{
			this.m.HumanKills += 1;
		}
		if (this.m.HumanKills >= this.m.KillsToSatisfy && this.m.KillsSatisfied == false)
		{
			local actor = this.getContainer().getActor();
			this.m.KillsSatisfied = true;
			this.Sound.play("sounds/combat/rage_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			local effect = this.getContainer().getActor().getSkills().getSkillByID("effects.killing_frenzy");
			this.Tactical.spawnIconEffect("passive_01", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			if (effect != null)
			{
				effect.reset();
			}
			else
			{
				this.getContainer().add(this.new("scripts/skills/effects/killing_frenzy_effect"));
			}
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " becomes enraged!");
		}
	}

	/*function onCombatFinished()
	{
		
	}*/

	function onSerialize( _out )
	{
		this.character_trait.onSerialize(_out);
		_out.writeU16(this.m.HumanKills);
		_out.writeBool(this.m.KillsSatisfied);
	}

	function onDeserialize( _in )
	{
		this.character_trait.onDeserialize(_in);
		this.m.HumanKills = _in.readU16();
		this.m.KillsSatisfied = _in.readBool();
	}


});

