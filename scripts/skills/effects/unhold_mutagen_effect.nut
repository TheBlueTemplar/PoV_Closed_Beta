this.unhold_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.unhold_mutagen";
		this.m.Name = "Mutation: Unhold";
		this.m.Icon = "skills/troll.png";
		this.m.IconMini = "";
		this.m.Overlay = "troll";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Hyperactive Cell Growth[/color]: This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments.";
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
				icon = "ui/icons/health.png",
				text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]20[/color] hitpoints each turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] hitpoint bonus"
			}
			
		];
		return ret;
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();

		if (actor != null && !actor.isNull() && actor.isAlive())
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, 20);

		if (healthAdded <= 0)
		{
			return;
		}

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.spawnIconEffect("status_effect_79", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

	function onUpdate(_properties)
	{
		_properties.HitpointsMult *= 1.5;
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

