this.pov_hexe_hex_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.pov_hex";
		this.m.Name = "Hex"; //probably should change cos there is already vanillas "Charmed", but it will not bork anything with the same name, its not something important(like ID, which should be unique obv)
		this.m.Description = "Target is hexed bla bla.";	//make something up urself
		this.m.Icon = "skills/status_effect_85.png";
		this.m.IconMini = "status_effect_85_mini";
		this.m.Overlay = "status_effect_85";
		this.m.SoundOnUse = [		//probably out of place
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
			icon = "ui/icons/special.png", //placeholders, idk any icons and def will not make my own
			text = "Hexed, takes more damage but bonks stuff harded." + turnsText, //should base this on debuffs, or make something up
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Takes [color=" + this.Const.UI.Color.PositiveValue + "]+33%[/color] more damage"
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Deals [color=" + this.Const.UI.Color.NegativeValue + "]+33%[/color] more damage"
		});
		return ret;
	}


	function onAdded()
	{
	}

	function onUpdate(_properties) //this should work, if not - try the onUpdateProperties function
	{
		_properties.DamageTotalMult *= 1.33; //holy shit, somebody gonna get absolutely fucked by orcs or some champion with big armor ignore bonus weapons, rip
		_properties.DamageReceivedTotalMult *= 1.33;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

//	function onUpdateProperties( _properties )
//	{
//		_properties.DamageTotalMult *= 1.33;
//		_properties.DamageReceivedTotalMult *= 1.33;
//	}

//	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )	//maybe will be useful later
//	{
//	}

});