this.pov_misanthropist_becomes_psychopath_event <- this.inherit("scripts/events/event", {
	m = {
		psycho = null
	},
	function create()
	{
		this.m.ID = "event.pov_misanthropist_becomes_psychopath";
		this.m.Title = "During camp...";
		this.m.Cooldown = 5.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_psychopath_event.png[/img]{You find %psycho% off to the side, where the others have learned not to tread. The blood on %their_psycho% armor is still fresh, some of it %theirs_psycho%, most of it not. %They_psycho%\'s cleaning %their_psycho% blade slowly, methodically, with the kind of care a craftsman might show a beloved tool. But there\'s nothing gentle in %their_psycho% expression. Only a cold, focused rage that hasn\'t burned out. %SPEECH_ON% That was it. The hundredth. I felt it... when the last one fell, when the screaming stopped. Like a door swung open inside me. I used to hate them. Thought it made me bitter. Cursed. A freak. But I was wrong. %SPEECH_OFF% A grin tugs at %their_psycho% lips—thin and dangerous. %SPEECH_ON% That hate wasn\'t a flaw. It was potential. Waiting. And now? Now I see it clearly. Every kill... it didn\'t weigh on me. It fed me... I finally understand people for what they are: obstacles. Weak. Loud. Craven. Evil. And when they fall, I feel nothing but clarity. %SPEECH_OFF% You watch %them_psycho% as %they_psycho% keeps grinding %their_psycho% weapon, not with emotion, but purpose. Whatever boundary once held %them_psycho% back - the line between man and monster - it\'s gone now. And the thing that remains? It\'s no longer just a loner with hate in his heart. It\'s something colder. Sharper. A blade, finally honed.}" 
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I don\'t know what to think about this...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// fallback
				/*if (_event.m.psycho == null)
				{
					return;
				}*/

				this.Characters.push(_event.m.psycho.getImagePath());
				
				local traitOld = _event.m.psycho.getSkills().getSkillByID("trait.pov_misanthropist");
				local traitNew = this.new("scripts/skills/traits/pov_psychopath_trait");
				traitNew.m.HumanKills = traitOld.m.HumanKills;

				this.List.push({
					id = 10,
					icon = traitOld.getIcon(),
					text = _event.m.psycho.getName() + " is no longer just a misanthropist..."
				});

				this.List.push({
					id = 10,
					icon = traitNew.getIcon(),
					text = "but is now a psychopath!"
				});

				_event.m.psycho.getSkills().remove(traitOld);
				_event.m.psycho.getSkills().add(traitNew);

				_event.m.psycho.improveMood(1.0, "Seems uniquely happy");

				if (_event.m.psycho.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.psycho.getMoodState()],
						text = _event.m.psycho.getName() + this.Const.MoodStateEvent[_event.m.psycho.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		// MY VERSION
		local brothers = this.World.getPlayerRoster().getAll();
		local trait;
		local psychopath_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_misanthropist"))
			{
				trait = bro.getSkills().getSkillByID("trait.pov_misanthropist");
				if (trait.m.KillsSatisfied)
				{
					psychopath_candidates.push(bro);
				}
			}
		}

		if (psychopath_candidates.len())
		{
			this.m.psycho = psychopath_candidates[this.Math.rand(0, psychopath_candidates.len() - 1)];
			this.m.Score = 9999;
		}

		

		// CHOPEKS VERSION (STUDY IT)
		/*local candidates = ::World.getPlayerRoster().getAll().filter(function (idx, bro) 
		{
			if(!bro.getSkills().hasSkill("trait.pov_misanthropist"))
				return false;

			local trait = bro.getSkills().getSkillByID("trait.pov_misanthropist");
			return trait.m.KillsSatisfied;
		});

		if (candidates.len()) 
		{
		   this.m.psycho = candidates[::Math.rand(0, candidates.len() - 1)];
		   this.m.Score = 99999;
		}*/
	}

	function onPrepare()
	{
		
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"psycho",
			this.m.psycho.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.psycho.getGender(), "psycho");
	}

	function onClear()
	{
		this.m.psycho = null;
	}

});

