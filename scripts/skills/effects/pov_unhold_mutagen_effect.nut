this.pov_unhold_mutagen_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.pov_unhold_mutagen";
		this.m.Name = "Mutation: Unhold";
		this.m.Icon = "skills/pov_troll.png";
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
		return "[color=" + this.Const.UI.Color.PositiveValue + "]Hyperactive Cell Growth[/color]: This character\'s body has mutated to grow at an unnatural pace. The character has much more vitality, while in battle, this causes their wounds to close and heal within moments.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]Faltering Fury[/color]: This character\'s body focus on restoring its wounds sap strength from the character\'s attacks, with worsening effects, the more wounded the character is.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]Increased Appetite[/color]: The increased metabolism due to rapid cell growth lead to greatly increased appetite, not that the Vatt\'ghern minds the extra ration or two. Just don\'t let him get the mead!";
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
				text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]12[/color] hitpoints each turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "]35%[/color] hitpoint bonus"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Does [color=" + this.Const.UI.Color.NegativeValue + "]less[/color] damage equal to [color=" + this.Const.UI.Color.NegativeValue + "]half[/color] of missing health %."
			},
			{
				id = 19,
				type = "text",
				icon = "ui/icons/asset_food.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+100%[/color] Food Consumption"
			}
			
		];
		return ret;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

			// ADD UNHOLD MUTAGEN MISSING HP - LESS DMG EFFECT
			// Imagine this is a reverse Muscularity effect
			actor.getSkills().add(this.new("scripts/skills/effects/pov_missing_hp_dmg_effect"));
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
		// DEFINE HP HEALED
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, 10);

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
		// Buffs
		// Regen 10HP
		_properties.HitpointsMult *= 1.35;

		// Debuffs
		// Lower HP% = Less Dmg%
		_properties.DailyFood += 1.0;
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

