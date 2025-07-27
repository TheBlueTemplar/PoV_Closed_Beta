this.pov_sickness2_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.pov_sickness2";
		this.m.Name = "Mutation Aftermath";
		this.m.Description = "This character has undergone a mutation. They are left in a horrible condition which will last for days, [color=" + this.Const.UI.Color.NegativeValue + "]and should avoid any and all fighting[/color]. \n\n While recovering, they will need to consume much more resources. \n\n This debuff is applied each time the Vatt\'ghern is mutated, but its duration is reduced each time a mutation happens.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_mutation_aftermath";
		this.m.Icon = "ui/injury/pov_injury_mutation_aftermath.png";
		this.m.IconMini = "pov_injury_mutation_aftermath_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 8;
		this.m.IsAlwaysInEffect = true;
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
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-70%[/color] Max Fatigue"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-70%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-70%[/color] Resolve"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-70%[/color] Melee Skill"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-70%[/color] Ranged Skill"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-60%[/color] Melee Defense"
			},
			{
				id = 17,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-60%[/color] Ranged Defense"
			},
			{
				id = 18,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-4[/color] Vision"
			},
			{
				id = 19,
				type = "text",
				icon = "ui/icons/asset_food.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+200%[/color] Food Consumption"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();
		local bro = this.getContainer().getActor();

		if (bro.isPlacedOnMap())
		{
			this.Sound.play("sounds/vomit_01.wav", this.Const.Sound.Volume.Actor, bro.getPos());
			local myTile = bro.getTile();
			local candidates = [];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local next = myTile.getNextTile(i);

					if (next.IsEmpty)
					{
						candidates.push(next);
					}
				}
			}

			if (candidates.len() == 0)
			{
				candidates.push(myTile);
			}

			myTile = candidates[this.Math.rand(0, candidates.len() - 1)];
			myTile.spawnDetail("detail_vomit");
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(bro) + " is now sick");
		}
	}

	function onTurnStart()
	{
		if (this.Math.rand(1, 100) <= 90)
		{
			return;
		}

		local bro = this.getContainer().getActor();
		this.Sound.play("sounds/vomit_01.wav", this.Const.Sound.Volume.Actor, bro.getPos());
		local myTile = bro.getTile();
		local candidates = [];

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local next = myTile.getNextTile(i);

				if (next.IsEmpty)
				{
					candidates.push(next);
				}
			}
		}

		if (candidates.len() == 0)
		{
			candidates.push(myTile);
		}

		myTile = candidates[this.Math.rand(0, candidates.len() - 1)];
		myTile.spawnDetail("detail_vomit");
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(bro) + " vomits");
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.HitpointsMult *= 0.50;
		_properties.BraveryMult *= 0.30;
		_properties.InitiativeMult *= 0.30;
		_properties.StaminaMult *= 0.30;
		_properties.MeleeSkill *= 0.30;
		_properties.RangedSkill *= 0.30;
		_properties.MeleeDefense *= 0.40;
		_properties.RangedDefense *= 0.40;
		_properties.Vision += -4;
		_properties.DailyFood += 2.0;
	}

});

