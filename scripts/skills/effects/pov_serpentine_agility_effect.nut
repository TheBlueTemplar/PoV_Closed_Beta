this.pov_serpentine_agility_effect <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_serpentine_agility";
		this.m.Name = "[color="+ ::Const.UI.Color.povEnemyEffect + "]Serpentine Agility[/color]";
		this.m.Description = "Great agility allows one to excel at dodgeing attacks, especially when focuesed against one enemy.\n\n On the other hand, focus against multiple opponents becomes harder, leading to the diminishing of these affects, as well as the creation of openings during combat.";
		this.m.Icon = "skills/pov_serpent.png";
		this.m.IconMini = "pov_mini_serpent";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Great agility allows one to excel at dodgeing attacks, especially when focuesed against one enemy.\n\n On the other hand, focus against multiple opponents becomes harder, leading to the diminishing of these affects, as well as the creation of openings during combat.";
	}

	function getPenalty()
	{
		local actor = this.m.Container.getActor();
		local surroundedAmount = actor.getSurroundedCount();
		local penalty = surroundedAmount * 4;
		return penalty;
	}

	function getBonus()
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
		local nearbyEnemies = 0;

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
			++nearbyEnemies;
		}

		if (nearbyEnemies > 1)
		{
			return 0;
		}
		if (nearbyEnemies == 1)
		{
			return 10;
		}
		else
		{
			return 0;
		}
	}

	function getTooltip()
	{
		local initiative = this.Math.floor(this.getContainer().getActor().getInitiative() * 0.10);
		if (initiative < 0) {initiative = 0;}
		local bonus = this.getBonus();
		local surrAmount = this.getPenalty();
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
			    icon = "ui/icons/ranged_skill.png",
			    text = "Currently has +[color=" + this.Const.UI.Color.PositiveValue + "]"+bonus+"[/color] Melee Defense, and +[color=" + this.Const.UI.Color.PositiveValue + "]"+bonus/2+"[/color] Ranged Defense (Bonuses active when engaged with exactly [color=" + this.Const.UI.Color.NegativeValue + "]one[/color] enemy)."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/initiative.png",
			    text = "Currently Gain +[color=" + this.Const.UI.Color.PositiveValue + "]"+initiative+"[/color] to all defences, due to initiative."
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/melee_defense.png",
			    text = "Currently Loses [color=" + this.Const.UI.Color.NegativeValue + "]"+surrAmount+"[/color] Melee Defense, due to being surroudned."
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus / 2;
		//_properties.SurroundedDefense -= 3;
		local surrAmount = this.getPenalty();
		_properties.MeleeDefense += - surrAmount;

	}

	function onAfterUpdate( _properties )
	{
		local initiative = this.Math.floor(this.getContainer().getActor().getInitiative() * 0.10);
		_properties.MeleeDefense += this.Math.max(0, initiative);
		_properties.RangedDefense += this.Math.max(0, initiative);
	}

});
