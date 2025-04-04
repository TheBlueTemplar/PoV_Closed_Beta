this.pov_hexe_charm_ally_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_charm";
		this.m.Name = "Charmed"; //probably should change cos there is already vanillas "Charmed", but it will not bork anything with the same name, its not something important(like ID, which should be unique obv)
		this.m.Description = "Should improve allys stats and make them prio target.";	//make something up urself
		this.m.Icon = "skills/status_effect_85.png";
		this.m.IconMini = "status_effect_85_mini";
		this.m.Overlay = "status_effect_85";
		this.m.SoundOnUse = [		//dont know if this is needed or how it works
			"sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() //WIP, dont really know how to make tooltips look cool
	{
		local ret = this.skill.getTooltip();
		local turnsText = this.m.TurnsLeft > 0 ? (" Lasts [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turns.") : "";
		ret.push({			//dont know why i did this with ret.push, probably stole somewhere (^:
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Charmed, should receive some buffs, also attracts enemies." + turnsText, //should base this on them buffs, or make something up
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Resolve"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Melee Skill"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Ranged Skill"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Melee Defense"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Ranged Defense"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Initiative"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Fatigue Recovery per turn"
		});
		return ret;
	}


	function onAdded()
	{
	}

	function onUpdate(_properties) //idk how to make this interesting, so i guess ill just add some stats, but i think that you should make this more spicy, but easier said than done, as always
	{
		_properties.BraveryMult *= 1.15;
		_properties.MeleeSkillMult *= 1.05; //should tweak these, dont forget to update the tooltip
		_properties.RangedSkillMult *= 1.05;
		_properties.MeleeDefenseMult *= 1.10;
		_properties.RangedDefenseMult *= 1.10;
		_properties.Initiative *= 1.10;

		_properties.FatigueRecoveryRate += 3;

		_properties.TargetAttractionMult *= 2.5; //prio mult, probably too big
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});