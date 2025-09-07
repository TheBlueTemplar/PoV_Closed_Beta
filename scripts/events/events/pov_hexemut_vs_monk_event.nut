this.pov_hexemut_vs_monk_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null,
		monk = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_vs_monk";
		this.m.Title = "During camp...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_truth.png[/img]{You find %other% sitting alone, poking at the dirt with a stick. %They_other% glances up as you approach, lips pressing into a thin line. %SPEECH_ON% If you\'re looking for %vattghern% and %monk%, they\'re over there. Had some kind of... discussion. Honestly, I regret ever seeing it. %SPEECH_OFF% Following %their_other% gesture, you find %monk% seated stiffly by the campfire, staring into the flames. %vattghern% is nearby, wearing a smirk, though something about it seems hollow.\n\n It doesn\'t take much to piece things together. %monk%, ever steadfast in %their_monk% faith, had been pressing %vattghern% about the nature of %their_vattghern% mutation, insisting that it was beyond the bounds of what should be. %vattghern% laughed it off, throwing back riddles and questions, picking apart the monk\'s certainty like a weaver unraveling cloth. Finally, %monk%, determined to prove his faith unshaken, demanded to see - truly see - what the vattghern understood.\n\n And now here %they_monk% sits, utterly silent. \n\n For hours, %they_monk% has said nothing, neither praying nor arguing. Then, just as suddenly as the quiet fell, %they_monk% stands, dusts %themselves_monk% off, and goes about his duties as if nothing happened. No trembling hands, no whispered prayers for protection.\n\n Yet, when you meet %their_monk% gaze, something is missing. The fire, the fervor that once burned so brightly behind %their_monk% eyes...It has dimmed, just slightly, like a candle flickering against an unseen wind.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hopefully that\'s the last of it",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghernHexe.getImagePath());
				this.Characters.push(_event.m.monk.getImagePath());
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.vattghernHexe.worsenMood(0.5, "Had a clash of faith and truth");
				_event.m.OtherGuy.worsenMood(0.5, "Witnessed wicked magic");

				local resolve_pen = this.Math.rand(1, 3);
				_event.m.monk.getBaseProperties().Bravery -= resolve_pen;
				_event.m.monk.getSkills().update();
				_event.m.monk.worsenMood(1.0, "Feels weirdly...empty");

				
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vattghernHexe.getName() + this.Const.MoodStateEvent[_event.m.vattghernHexe.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
					text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.monk.getMoodState()],
					text = _event.m.monk.getName() + this.Const.MoodStateEvent[_event.m.monk.getMoodState()]
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.monk.getName() + " loses [color=" + this.Const.UI.Color.NegativeEventValue + "]" + resolve_pen + "[/color] Resolve"
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

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen") && bro.getBackground().getID() != "background.monk")
			{
				vattghern_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
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
		this.m.monk = vala_candidates[this.Math.rand(0, vala_candidates.len() - 1)];
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
			"monk",
			this.m.monk.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.monk.getGender(), "monk");
		_vars.push([
			"other",
			this.m.OtherGuy.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy.getGender(), "other");
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
		this.m.monk = null;
		this.m.OtherGuy = null;
	}

});

