this.pov_belly_full_of_mead_event <- this.inherit("scripts/events/event", {
	m = {
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.pov_belly_full_of_mead";
		this.m.Title = "During camp...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/belly_full_of_mead.png[/img]{You find %other% by the campfire, flask in hand, half-lost in the golden haze of surplus mead. %Their_other% posture is relaxed, feet outstretched toward the dying embers, eyes glazed with the gentle warmth of alcohol. %They_other% notices you approaching, lifts the flask slightly, and slurs: %SPEECH_ON% Hey, come joi— %SPEECH_OFF% The invitation trails off mid-word, swept aside by a sudden burst of enthusiasm. Without missing a beat, %they_other% launches into a ramble about the craft of fermentation, %their_other% old hobby apparently. %SPEECH_ON% See, it\'s all in the balance. Honey, yeah, but not too much. Gotta let the yeast breathe, you know? People rush it. Gotta respect the time. Mead\'s like... like a story... you don\'t rush a good story...%SPEECH_OFF% %They_other% drifts deeper into technicalities, gesturing loosely with the flask as if %they_other%\'s giving a lecture to the firewood. \n\n You let %them_other% be, quietly stepping away to let %them_other% enjoy the moment uninterrupted. As you leave, a thought drifts through your mind and lingers with a smirk...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "\"I\'d be a lot warmer and a lot happier with a bellyful of mead...\"",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());

				_event.m.OtherGuy.improveMood(0.5, "Enjoyed some mead...");
				_event.m.OtherGuy.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));

				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
					text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
				});

				this.List.push({
					id = 10,
					icon = "skills/status_effect_61.png",
					text = _event.m.OtherGuy.getName() + " became drunk! "
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local other_candidates = [];
		local stash = this.World.Assets.getStash().getItems();
		local candidates_items = []; //Not actual candidate, I just check if party has >= 3

		foreach( bro in brothers )
		{
			other_candidates.push(bro);
		}

		foreach( item in stash )
		{
			if (item != null)
			{
				if (item.getID() == "supplies.mead" || item.getID() == "supplies.preserved_mead")
				{
					candidates_items.push(item);					
				}
			}
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		if (candidates_items.len() < 2)
		{
			return;
		}


		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = 50;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{

	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"other",
			this.m.OtherGuy.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy.getGender(), "other");
	}

	function onClear()
	{
		this.m.OtherGuy = null;
	}

});

