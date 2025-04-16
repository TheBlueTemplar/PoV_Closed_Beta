this.pov_enemy_mutation_unhold <- this.inherit("scripts/skills/skill", {
	m = {
		//TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_unhold";
		this.m.Name = "[color=#034207]Unhold\'s Vigor[/color]";
		this.m.Description = "This enemy has some properties of an unhold! This restricts their damage output, if their hp is lower than maximum.";
		this.m.Icon = "skills/pov_troll_mutant.png";
		this.m.IconMini = "pov_mini_troll_mutant";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This eneny has some properties of an unhold! This restricts their damage output, if their hp is lower than maximum.";
	}

	function getTooltip()
	{
		local penalty = this.Math.floor(100 - (getHpDmgPen() * 100));
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] hitpoint bonus and regenerates [color=" + this.Const.UI.Color.PositiveValue + "]15[/color] hp per turn"
			},
			{
			    id = 11,
			    type = "text",
			    icon = "ui/icons/fatigue.png",
			    text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]"+penalty+"[/color] % less damage due to missing health."
			}

		];
		return ret;
	}

	function onAdded() 
	{
		local actor = this.getContainer().getActor();
		if (!::MSU.isKindOf(actor, "player")) 
		{
			actor.m.OnDeathLootTable.push(::TLW.MutagenDrop.getMutagenDrop(actor, ::TLW.Mutation.Unhold));
	  	}
	}

	function getHpDmgPen()
	{
			local actor = this.getContainer().getActor();
			local maxHp = actor.getHitpointsMax();
			local Hp = actor.getHitpoints();
			local currentHpPercent = (Hp * 100) / maxHp;
			local missingHpPercent = 100 - currentHpPercent;

			// 50% less damage on 1% health, 25% less dmg on 50% health
			local damagePenalty = this.Math.maxf(0, missingHpPercent / 2) * 0.01; 

			if (damagePenalty >= 1)
			{	
				// This is me being paranoic xd
				damagePenalty = 1;
			}

			local finalDamageMult = 1 - damagePenalty;

			return finalDamageMult;
	}

	function onUpdate(_properties)
	{
		_properties.HitpointsMult *= 1.30;
	}

	function onTurnStart()
	{
		// REGEN 15 HP PER TURN
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(healthMissing, 15);

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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		local isValidRanged = item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && (item.isWeaponType(this.Const.Items.WeaponType.Throwing) || item.isWeaponType(this.Const.Items.WeaponType.Bow));
		if (!_skill.isRanged() || (isValidRanged && item.isItemType(this.Const.Items.ItemType.Weapon)))
		{
			_properties.DamageTotalMult *= getHpDmgPen();
		}
	}

	/*function isHidden()
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
	}*/

});
