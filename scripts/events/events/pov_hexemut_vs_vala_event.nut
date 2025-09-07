this.pov_hexemut_vs_vala_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null,
		vala = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_vs_vala";
		this.m.Title = "During camp...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_vala_recruitment.png[/img]{You realize after some time that %vattghern% and %vala% are nowhere to be seen. They\'re not by the fire, not among the men gambling, and not tending to any camp chores. Their absence lingers like a question unasked. You start looking for them, asking around until you find %other%, who barely looks up from %their_other% meal. %SPEECH_ON% Oh, those two? In their tents. Some magic nonsense. One tried something on the other, it didn\'t go well, and now they\'re both lying there like winded dogs. %SPEECH_OFF% That\'s all the explanation you get, but it\'s enough. You pull back the tent flap and step inside, greeted by the heavy stillness of lingering tension. %vala% sits with %their_vala% head in %their_vala% hands, while %vattghern% rests against the tent wall, arms crossed, expression unreadable. Whatever happened between them drained them both.\n\n %vala% exhales sharply. %SPEECH_ON% I only wanted to understand… but this magic makes no sense. It\'s twisted, like looking into a reflection that shifts when you aren\'t watching. %SPEECH_OFF% %vattghern% scoffs, %their_vattghern% voice low and measured.%SPEECH_ON% You shouldn\'t have looked at all. Be glad all you found was confusion. %SPEECH_OFF% It doesn\'t take much to see where this could lead. Two mystics pulling at the threads of each other\'s power, neither willing to back down. A recipe for disaster.\n\n You make no speech, no command—just a frown directed at %vala%. A warning without words. %They_vala% meets your gaze for a moment before looking away. With this, you know %they_vala% won\'t try this again.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Lets not do this again...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghernHexe.getImagePath());
				this.Characters.push(_event.m.vala.getImagePath());
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.vattghernHexe.getSkills().add(this.new("scripts/skills/effects/pov_exhausted_effect"));
				_event.m.vattghernHexe.worsenMood(1.0, "Exhausted from a magical contest");

				_event.m.vala.getSkills().add(this.new("scripts/skills/effects/pov_exhausted_effect"));
				_event.m.vala.worsenMood(1.0, "Exhausted from a magical contest");

				
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vattghernHexe.getName() + this.Const.MoodStateEvent[_event.m.vattghernHexe.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vala.getName() + this.Const.MoodStateEvent[_event.m.vala.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.vattghernHexe.getName() + " became mentally exhausted! "
				});
				this.List.push({
					id = 10,
					icon = "skills/status_effect_62.png",
					text = _event.m.vala.getName() + " became mentally exhausted! "
				});
				
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		local vala_candidates = [];
		local other_candidates = [];
		
		foreach( bro in brothers )
		{
			

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen") && bro.getBackground().getID() != "background.legend_vala")
			{
				vattghern_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.legend_vala")
			{
				vala_candidates.push(bro);
			}
			else
			{
				other_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0 || vala_candidates.len() == 0 || other_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernHexe = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.vala = vala_candidates[this.Math.rand(0, vala_candidates.len() - 1)];
		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
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
			"vala",
			this.m.vala.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vala.getGender(), "vala");
		_vars.push([
			"other",
			this.m.OtherGuy.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy.getGender(), "other");
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
		this.m.vala = null;
		this.m.OtherGuy = null;
	}

});

