this.pov_hexemut_vs_druid_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null,
		druid = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_vs_druid";
		this.m.Title = "During camp...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_druid.png[/img]{You find %druid% crouched at the edge of the camp, hunched over a mess of herbs, charred sticks, and faintly glowing runes scratched into the earth. Sweat beads on %their_druid% brow despite the chill. %They_druid% doesn\'t look up as you approach, hands moving with tense precision, lips muttering words older than stone.%SPEECH_ON%It\'s that cursed presence, %vattghern%. I don\'t care what form %they_vattghern% takes, nor what banner %they_vattghern% stands under. That sort of twisted magic doesn\'t fade, it stains. It clings. You may not see it, but I feel it. And I\'ll not leave this camp unguarded while it lurks so close.%SPEECH_OFF% You watch as %they_druid% places another charm into the dirt, the etching glowing briefly before dimming like cooling iron. The work is slow, the rituals draining. By the time you leave %them_druid% to their efforts, %druid% looks pale, breath heavy, hands trembling from the strain. Still, %their_druid% eyes never waver from their task. \n\n The wards will hold. But at a cost.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "If you think this\'ll work...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghernHexe.getImagePath());
				this.Characters.push(_event.m.druid.getImagePath());

				_event.m.vattghernHexe.worsenMood(1.0, "Has a strange feeling...");

				_event.m.druid.getSkills().add(this.new("scripts/skills/effects_world/exhausted_effect"));
				_event.m.druid.getSkills().add(this.new("scripts/skills/effects/pov_exhausted_effect"));
				_event.m.druid.worsenMood(1.0, "Exhausted from preparing defensive runes");

				
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vattghernHexe.getName() + this.Const.MoodStateEvent[_event.m.vattghernHexe.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.druid.getName() + this.Const.MoodStateEvent[_event.m.druid.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.druid.getName() + " became exhausted! "
				});	
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.druid.getName() + " became mentally exhausted! "
				});			
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		local druid_candidates = [];
		
		foreach( bro in brothers )
		{
			

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen") && bro.getBackground().getID() != "background.legend_druid")
			{
				vattghern_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.legend_druid")
			{
				druid_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0 || druid_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernHexe = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.druid = druid_candidates[this.Math.rand(0, druid_candidates.len() - 1)];
		this.m.Score = 20;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{

	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"vattghern",
			this.m.vattghernHexe.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vattghernHexe.getGender(), "vattghern");
		_vars.push([
			"druid",
			this.m.druid.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.druid.getGender(), "druid");
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
		this.m.druid = null;
	}

});

