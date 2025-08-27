this.pov_unbearable_stench_passive_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.pov_unbearable_stench_passive";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Unbearable Stench[/color]";
		this.m.Description = "This entity emits an extremely uncomforting scent, which makes most nearby enemies shrink and cringe at a mere whiff";
		this.m.Icon = "skills/pov_foul_stench.png";
		this.m.IconMini = "pov_mini_foul_stench";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This entity emits an extremely uncomforting scent, which makes most nearby enemies shrink and cringe at a mere whiff. Undead eneities, and those not bothered by scent, are unaffected.";
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.hasSprite("pov_back_socket2"))
		{
			local stench_glow_sprite = actor.getSprite("pov_back_socket2");
			stench_glow_sprite.setBrush("pov_foul_stench");
			stench_glow_sprite.Color = this.createColor("#7a3e02"); 
			stench_glow_sprite.Saturation = 0.8;
			stench_glow_sprite.Scale = 0.95;
			//stench_glow_sprite.varySaturation(0.1);
			stench_glow_sprite.varyColor(0.05, 0.05, 0.05);
			stench_glow_sprite.Visible = true;
		}

		if (::MSU.isKindOf(actor, "player")) 
		{
			if (actor.hasSprite("pov_back_socket2"))
			{
				local stench_glow_sprite = actor.getSprite("pov_back_socket2");
				stench_glow_sprite.setBrush("pov_foul_stench");
				stench_glow_sprite.Color = this.createColor("#7a3e02"); 
				stench_glow_sprite.Saturation = 0.85;
				stench_glow_sprite.Scale = 0.85;
				//stench_glow_sprite.varySaturation(0.1);
				stench_glow_sprite.varyColor(0.05, 0.05, 0.05);
				stench_glow_sprite.Visible = true;
			}
	  	}
	}

	function giveDebuff()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return 0;
		}

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local myFaction = actor.getFaction();

		if (myTile == null)
		{
			return 0;
		}

		if (!("Entities" in this.Tactical))
		{
			return 0;
		}

		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local actors = this.Tactical.Entities.getAllInstancesAsArray();
		local bonus = 0;
		foreach( a in actors )
		{
			if (a == null)
			{
				continue;
			}

			if(!a.isPlacedOnMap())
			{
				continue;
			}

			if (a.getFaction() == myFaction)
			{
				continue;
			}

			if (a.getTile() == null)
			{
				continue;
			}

			if (a.getTile().getDistanceTo(myTile) != 1)
			{
				continue;
			}

			if (a.getFlags().has("undead") || a.getSkills().hasSkill("effects.pov_alp_mutagen") || a.getSkills().hasSkill("effects.pov_skeleton_mutagen") || a.getSkills().hasSkill("effects.pov_strain_mutagen") || a.getSkills().hasSkill("effects.pov_ghoul_mutagen") || a.getSkills().hasSkill("effects.pov_enemy_mutation_alp"))
			{
				continue;
			}

			a.getSkills().add(this.new("scripts/skills/effects/pov_stench_effect"));
		}

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
			    text = "Nearby enemies lose initiative, resolve, and melee damage, as well as take damage over time, due to this entity\'s unbearable stench and rot!"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		giveDebuff();
	}
});
