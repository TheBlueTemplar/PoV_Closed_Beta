this.pov_enemy_mutation_effect <- this.inherit("scripts/skills/skill", {
	m = {
		isActive = false,
		triPhaseA = 0.00,
		triPhaseB = 0.00,
		triPhaseC = 0.00
	},
	function create()
	{
		this.m.ID = "effects.pov_enemy_mutation_effect";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	triggerRender = function()
	{
		if (!this.m.isActive) return;

	    local actor = this.getContainer().getActor();
	    if (actor == null || !actor.hasSprite("pov_back_socket")) return;

	    local spr = actor.getSprite("pov_back_socket");
	    local t = this.Time.getVirtualTimeF();

	    // Triangle wave helper (0→1→0), using only simple mathr
	    function triWave(speed, phase)
	    {
	        local v = (t * speed + phase) % 2.0;	// 0..2
	        return v < 1.0 ? v : (2.0 - v);		// 0..1..0
	    }

	    // --- Slower, “heavy” breathing: ~0.70 ↔ 1.20 ---
	    // (pungent = not wildly expanding, just a thick swell)
	    local scaleBase = 0.70;
	    local scaleAmp  = 0.50;                 // total swing = 0.10
	    spr.Scale = scaleBase + triWave(0.35,this.m.triPhaseA) * scaleAmp;

	    // --- Mild, slow rotation: ±4° ---
	    spr.Rotation = (-4.0 + triWave(0.15,this.m.triPhaseB) * 8.0); 

	    // Fade in/out loop using triWave
		local alphaMin = 120;	// more transparent at the trough
		local alphaMax = 255;	// fully opaque at the peak
		spr.Alpha = alphaMin + triWave(0.40, this.m.triPhaseC) * (alphaMax - alphaMin);

	    // Optional: slight saturation wobble (slow, subtle)
	    spr.Saturation = 0.2 + triWave(0.25, this.m.triPhaseC) * 0.4;   // 1.0..1.3
	}

	function onAdded() 
	{
		// Ramdomization of multiple different actors with same animation
		this.m.triPhaseA = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseB = this.Math.rand(0,150) * 0.01; // 0..1.5
		this.m.triPhaseC = this.Math.rand(0,150) * 0.01; // 0..1.5

		local actor = this.getContainer().getActor();

		actor.setRenderCallbackEnabled(true);
		actor.setAlwaysApplySpriteOffset(true);
		this.m.isActive = true;
	}

	function onUpdate( _properties )
	{
		// Skibidi
	}

});
