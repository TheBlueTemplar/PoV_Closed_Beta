this.pov_many_corpses_event <- this.inherit("scripts/events/event", {
	m = {
		Specialist = null,
		Item = null,
		Rando1 = null,
		Rando2 = null
	},
	function create()
	{
		this.m.ID = "event.pov_many_corpses";
		this.m.Title = "During Camp...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_corpse_cart_full.png[/img]{The stench hits you before the complaints do. A hot wind carries with it the unmistakable perfume of death: rot, blood, and something far worse that defies any description you\'d want to dwell on. You follow the murmurs through camp until you find a cluster of your men gathered around the cart. They don\'t look angry, not yet, but they\'re certainly bothered. %Rando1% steps forward, covering his nose with a rag that\'s doing little good. %SPEECH_ON%Captain, with all due respect, we can\'t keep dragging this filth around. The flies are thicker than the stew, and I swear something moved under the tarp.%SPEECH_OFF% %Rando2% chimes in from the back, trying to fan the air with his hat.%SPEECH_ON%I\'d rather march naked through a swamp than sleep another night next to that reeking pile. We\'re mercenaries, not undertakers! %SPEECH_OFF% You look at the cart. It groans under the weight of monster corpses — broken limbs twisted the wrong way, hides slashed open to reveal glistening organs, and grotesque heads with eyes still wide and staring. One carcass twitches, just once, as if the nerves haven\'t yet accepted death. Useful for mutagens and trophies, perhaps… but to most, it\'s just rot in a wooden box. You consider your options as the group watches...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We need them, so we keep them, the men will manage.",
					function getResult( _event )
					{
						return "Keep Them";
					}

				},
				{
					Text = "Fine, throw them all away, lest we end up with more.",
					function getResult( _event )
					{
						return "Dispose Them";
					}

				},
				{
					Text = "We shall find the few most stinky ones, and only throw them away. We keep the rest",
					function getResult( _event )
					{
						return "Dispose Some";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Specialist != null)
				{
					this.Options.push({
						Text = "You, %Specialist%, you deal with corpses a lot, any ideas?",
						function getResult( _event )
						{
							return "Specialist";
						}

					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 30)
					{
						bro.worsenMood(0.5, "Annoyed by the corpse\'s stench");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Keep Them",
			Text = "[img]gfx/ui/events/pov_corpse_cart_full.png[/img]{You shake your head. %SPEECH_ON%We\'re keeping them. If you can\'t stomach the smell, walk further upwind.%SPEECH_OFF% The  men exchange glances, some of disbelief, some of quiet fury, some others just don\'t care enough. One of them opens his mouth to argue, then thinks better of it and walks off with a muttered curse. The other lingers just a moment longer, nose wrinkled, eyes narrowed, before spitting into the dirt and following. The rot remains, so does the tension. \n\n And every breeze carries a reminder of your decision.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "They\'ll forget about it soon.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 60)
					{
						bro.worsenMood(1.0, "Angered that the stench will remain");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Dispose Them",
			Text = "[img]gfx/ui/events/pov_corpse_cart_empty.png[/img]{You sigh and give the order. %SPEECH_ON%Fine. Burn them. Bury them. Dump them. I don\'t care how. Just get rid of the lot.%SPEECH_OFF% The change in the camp is almost immediate. The stench begins to lift, replaced by smoke or silence, depending on the method. The men speak more freely again. Meals are shared without grimaces. Laughter, hesitant at first, returns in small doses. \n\n You think to yourself that whatever those monster corpses were worth in coin, you seem to have bought back for morale instead. At least that\'s what you hope.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Now that is done with.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();
				local inventory = this.World.Assets.getStash();
				local corpses = [];

				foreach( item in stash )
				{
					if (item != null)
					{
						foreach(corpse in ::TLW.CorpsesID)
						if (item.getID() == corpse)
						{
							corpses.push(item);				
						}
					}
				}

				for (local i = 0; i < corpses.len(); i = ++i)
				{
					inventory.removeByID(corpses[i].getID());
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 40)
					{
						bro.improveMood(0.5, "Happy that the stench is gone");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}

				this.List.push({
					id = 10,
					icon = "",
					text = "All corpses were disposed"
				});
			}

		});
		this.m.Screens.push({
			ID = "Dispose Some",
			Text = "[img]gfx/ui/events/pov_corpse_cart_half.png[/img]{You nod slowly and give a half-concession. %SPEECH_ON%We keep what\'s still good. The rest: get rid of it before it walks off on its own!%SPEECH_OFF% A few grumbles ripple through the camp, but orders are orders. The men set about the task with sour faces and cloths tied over their mouths. The worst of the corpses - the bloated, the leaking, the half-melted - are dragged away to a gully and burned without ceremony. The flames do little to mask the stench, but at least it no longer clings to the tents. \n\n The men don\'t exactly cheer, but they stop muttering as much, and supper no longer tastes like spoiled meat by association. A compromise, one that leaves both sanity and spoils somewhat intact.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope that\'s the last of it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();
				local inventory = this.World.Assets.getStash();
				local corpses = [];

				foreach( item in stash )
				{
					if (item != null)
					{
						foreach(corpse in ::TLW.CorpsesID)
						if (item.getID() == corpse)
						{
							corpses.push(item);				
						}
					}
				}

				local roll = 0;
				for (local i = 0; i < corpses.len()/3; i = ++i)
				{
					roll = this.Math.rand(0,corpses.len() - 1);
					//corpses.remove(corpses.find(roll));
					inventory.removeByID(corpses[roll].getID());
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(0.5, "Happy that the stench is gone");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				
				this.List.push({
					id = 10,
					icon = "",
					text = "Some corpses were disposed"
				});
			}

		});
		this.m.Screens.push({
			ID = "Specialist",
			Text = "[img]gfx/ui/events/pov_corpse_cart_full.png[/img]{The stench hangs over the camp like a curse, thick enough to taste. Muttering is turning to complaints, and complaints to unrest. You eye the bloated cart and then glance over at %Specialist%, who\'s calmly eating near the edge of camp, unbothered, as always. %SPEECH_ON%You\'ve dealt with worse. Got anything for the smell?%SPEECH_OFF% %Specialist% looks up, shrugs, and wipes %their_Specialist% hands on their tunic.%SPEECH_ON% Aye. There\'s a few tricks of my trade. Herbs, ash, bit of pitch, and vinegar if we have it. Won\'t make it pleasant, but it\'ll make it tolerable.%SPEECH_OFF% You give the order. Soon enough, %Specialist% is making rounds with bundles of pungent herbs and a thick, smoky paste, dabbing it across the worst parts of the cart and muttering something under their breath. By sundown, the difference is clear... the smell\'s not gone, but it no longer curls the stomach. The mood in camp lifts. A few even crack jokes again. \n\nNo corpses lost. No arguments. Just one strange soul with strange skills, doing what they do best.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good job, %Specialist%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 30)
					{
						bro.improveMood(0.5, "Happy that the stench is mostly gone");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}

				this.Characters.push(_event.m.Specialist.getImagePath());
				_event.m.Specialist.improveMood(1.0, "Happy for saving the stinky day");

				if (_event.m.Specialist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Specialist.getMoodState()],
						text = _event.m.Specialist.getName() + this.Const.MoodStateEvent[_event.m.Specialist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local stash = this.World.Assets.getStash().getItems();
		local candidates_items = [];

		foreach( item in stash )
		{
			if (item != null)
			{
				foreach(corpse in ::TLW.CorpsesID)
				if (item.getID() == corpse)
				{
					candidates_items.push(item);				
				}
			}
		}

		if (candidates_items.len() <= 12)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_Specialist = [];
		local other_candidates = [];

		if (brothers.len() < 4)
		{
			return;
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_taxidermist" || bro.getBackground().getID() == "background.legend_alchemist" || bro.getBackground().getID() == "background.gravedigger")
			{
				candidates_Specialist.push(bro);
			} 
			
			other_candidates.push(bro);
		}

		if (candidates_Specialist.len() != 0)
		{
			this.m.Specialist = candidates_Specialist[this.Math.rand(0, candidates_Specialist.len() - 1)];
		}

		this.m.Rando1 = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];4
		other_candidates.remove(other_candidates.find(this.m.Rando1));
		this.m.Rando2 = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];

		this.m.Score = 2 + candidates_items.len();
		//this.m.Score = 99999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"Specialist",
			this.m.Specialist != null ? this.m.Specialist.getName() : ""
		]);
		if (this.m.Specialist != null)
		{
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Specialist.getGender(), "Specialist");
		}
		_vars.push([
			"Rando1",
			this.m.Rando1.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Rando1.getGender(), "Rando1");
		_vars.push([
			"Rando2",
			this.m.Rando2.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Rando2.getGender(), "Rando2");
	}

	function onClear()
	{
		this.m.Specialist = null;
	}

});

