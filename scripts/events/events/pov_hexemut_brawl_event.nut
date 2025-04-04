this.pov_hexemut_brawl_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_brawl";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]{While you were sitting by the fire, enjoying a rare moment of peace, raised voices shatter the calm. At first, it seems like the usual camp squabble - tired men, short tempers - but then you see the center of it all. %vattghern%, as always, has drawn a crowd.\n\nIt started harmlessly enough. A joke here, a friendly pat on the back there - men naturally gravitate toward %vattghern%, seeking their presence, their approval. But admiration is a fickle thing, and what was once camaraderie has turned into something else. Someone felt slighted. Another grew jealous. Heated words turned to shoves, and before you can step in, the camp erupts into a full-blown brawl.\n\n By the time you and a few others manage to break it up, most are left nursing bruises, but nothing a night\'s rest won\'t mend. %vattghern%, however, took the worst of it - being the center of attention has its price. Bloodied, battered, but still standing, they wipe a streak of red from their chin and glance around, their usual magnetism now a source of quiet unease.%SPEECH_ON% Didn\'t think admiration had this much bite, good to know I can get a rise out of them.%SPEECH_OFF%Giving an angry glance at the smirking Vatt\'ghern, you sigh. Their presence brings fortune, but it also brings trouble. Best to keep an eye on things.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Admiration comes at a price.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.vattghernHexe.worsenMood(0.5, "Admiration comes at a price");
				//_event.m.vattghernHexe.addInjury(this.Const.Injury.BluntBody);
				_event.m.vattghernHexe.addHeavyInjury();
				// ADD MOOD AND INJURY THING HERE

				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.vattghernHexe.getName() + " suffers serious wounds"
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vattghernHexe.getName() + this.Const.MoodStateEvent[_event.m.vattghernHexe.getMoodState()]
				});

				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (!bro.getSkills().hasSkill("effects.hexe_mutagen"))
					{
						if (this.Math.rand(1, 100) <= 20)
						{
							bro.improveMood(0.5, "Feels uneasy after a brawl");

							if (bro.getMoodState() > this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}

						if (this.Math.rand(1, 100) <= 70)
						{

							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + " suffers light wounds"
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		local partySize = brothers.len();

		// Set a minimum party size for this to happen (I dont want to)
		/*if (brothers.len() < 10)
		{
			return;
		}*/
		
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
			{
				vattghern_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernHexe = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.Score = this.Math.round(5 + (partySize / 2));
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
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
	}

});

