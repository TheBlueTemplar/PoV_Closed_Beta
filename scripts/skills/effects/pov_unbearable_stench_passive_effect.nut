this.pov_unbearable_stench_passive_effect <- this.inherit("scripts/skills/skill", {
	m = {
		isActive = false,
		triPhaseA = 0.00,
		triPhaseB = 0.00,
		triPhaseC = 0.00,
		triPhaseD = 0.00,
		triPhaseE = 0.00
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

	triggerRender = function()
	{
		if (!this.m.isActive) return;

	    local actor = this.getContainer().getActor();
	    if (actor == null || !actor.hasSprite("pov_back_socket2")) return;

	    local spr = actor.getSprite("pov_back_socket2");
	    local t = this.Time.getVirtualTimeF();

	    // Triangle wave helper (0→1→0), using only simple math
	    function triWave(speed, phase)
	    {
	        local v = (t * speed + phase) % 2.0;	// 0..2
	        return v < 1.0 ? v : (2.0 - v);		// 0..1..0
	    }

	    // --- Slower, “heavy” breathing: ~0.90 ↔ 1.00 ---
	    // (pungent = not wildly expanding, just a thick swell)
	    local scaleBase = 0.90;
	    local scaleAmp  = 0.10;                 // total swing = 0.10
	    spr.Scale = scaleBase + triWave(0.30,this.m.triPhaseA) * scaleAmp;

	    // --- Mild, slow rotation: ±4° ---
	    spr.Rotation = (-4.0 + triWave(0.15,this.m.triPhaseB) * 8.0); 

	    // --- Drift: slow sideways (-3..+5px), strong upward waft (−14..−6px) ---
	    // Horizontal drift (slow, subtle)
	    local ox = -3.0 + triWave(0.15,this.m.triPhaseC) * 8.0;

	    // Vertical drift biased upward: we map 0..1 to -20..-12
	    local oy = -20.0 + triWave(0.30,this.m.triPhaseD) * 8.0;

	    actor.setSpriteOffset("pov_back_socket2", this.createVec(ox, oy));

	    // Fade in/out loop using triWave
		local alphaMin = 90;	// more transparent at the trough
		local alphaMax = 255;	// fully opaque at the peak
		spr.Alpha = alphaMin + triWave(0.35, this.m.triPhaseE) * (alphaMax - alphaMin);

	    // Optional: slight saturation wobble (slow, subtle)
	    spr.Saturation = 0.2 + triWave(0.25, this.m.triPhaseE) * 0.4;   // 1.0..1.3
	}

	function onAdded()
	{
		// Ramdomization of multiple different actors with same animation
		this.m.triPhaseA = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseB = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseC = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseD = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseE = this.Math.rand(0,150) * 0.01; // 0..1.5

		local actor = this.getContainer().getActor();
		if (actor.hasSprite("pov_back_socket2"))
		{
			local stench_glow_sprite = actor.getSprite("pov_back_socket2");
			stench_glow_sprite.setBrush("pov_foul_stench");
			stench_glow_sprite.Color = this.createColor("#7a3e02"); 
			stench_glow_sprite.Saturation = 0.8;
			stench_glow_sprite.Scale = 1.00;
			//stench_glow_sprite.varySaturation(0.1);
			stench_glow_sprite.varyColor(0.05, 0.05, 0.05);
			stench_glow_sprite.Visible = true;

			actor.setRenderCallbackEnabled(true);
			actor.setAlwaysApplySpriteOffset(true);
			this.m.isActive = true;
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

				actor.setRenderCallbackEnabled(true);
				actor.setAlwaysApplySpriteOffset(true);
				this.m.isActive = true;
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
