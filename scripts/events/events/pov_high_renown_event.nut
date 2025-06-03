this.pov_high_renown_event <- this.inherit("scripts/events/event", {
	m = {
		Specialist = null
	},
	function create()
	{
		this.m.ID = "event.pov_high_renown_event";
		this.m.Title = "Noise in the Camp...";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_camp_happy.png[/img]{The noise catches your ear first - laughter, clanking mugs, the unmistakable sound of boots stomping in rhythm. You approach the main campfire to find your men gathered close, flames flickering across eager faces. Someone\'s carved a crude crest into a log and is holding it up like a royal banner. Stories are flying exaggerated tales of monsters slain, dangers braved, and victories won.\n\n They\'re icelebrating. Not for coin, not for food — but for fame. Your party\'s name is spreading, and for once, everyone seems to feel it.You cross your arms, watching the revelry. Spirits are high. Morale is solid. Still… a little push wouldn\'t hurt. You consider what you could do to lift the mood even further…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Give an Inspiring Speech!",
					function getResult( _event )
					{
						return "Speech";
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local food = this.World.Assets.getFood();
				foreach( bro in brothers )
				{
					
				}

				if (food > brothers.len() * 8)
				{
					this.Options.push({
						Text = "\"Food and Drinks for Everyone!\"",
						function getResult( _event )
						{
							return "Extra Rations";
						}

					});
				}

				if (this.World.Assets.getMoney() > brothers.len() * 750)
				{
					this.Options.push({
						Text = "Let\'s hand out some good money!",
						function getResult( _event )
						{
							return "Wage Bonus";
						}

					});
				}

				if (_event.m.Specialist != null && this.World.Assets.getMedicine() >= brothers.len() * 3)
				{
					this.Options.push({
						Text = "You, %Specialist%, take some meds and work your magic...",
						function getResult( _event )
						{
							return "Happy Hour";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Speech",
			Text = "[img]gfx/ui/events/pov_camp_happy.png[/img]{You raise your hand, and slowly the noise dies down. All eyes turn to you, curious, expectant. You step closer to the fire, its warmth brushing your face as you begin to speak. You don\'t shout, don\'t puff your chest. Instead, your voice is steady, thoughtful. \n\n You remind them of where it all began — that first job that barely paid for bread, the nights spent under leaking tarps, the close calls that could\'ve ended it all before it even started. You speak of green recruits who hadn\'t yet held steel with steady hands, of patchwork armor and borrowed blades. \n\n And then, you bring them forward — through the trials, the battles, the losses. Through the beast-hunts, the cursed towns, the midnight escapes. You speak of the strength they\'ve earned, the names they\'ve made for themselves, and the fear they now strike in others. \n\n The fire crackles as you pause. No grand theatrics, no empty bravado — just a quiet truth shared among those who\'ve lived it. Someone raises a mug. Then another. A cheer builds — not wild, but proud... \n\n The kind born of blood and memory.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Tonight, you reminded them why they march behind you.",
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
						bro.improveMood(0.5, "Moved by your Speech");
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
			ID = "Extra Rations",
			Text = "[img]gfx/ui/events/pov_camp_happy.png[/img]{You clap your hands and call out over the chatter — not to quiet it, but to guide it. You give the signal to open the reserves, the ones kept aside for harder days or fortunate turns. What follows is a flurry of motion: bags unrolled, bundles opened, bottles passed hand to hand. The fire is stirred higher, and the scent of warm food begins to roll through camp, rich and comforting.\n\n You watch as spirits lift even further. Smiles grow wider, backs straighten, laughter deepens. A few take to humming a tune, and before long, someone adds a beat with an old pot or scabbard. Tales start flying — the kind that stretch the truth just enough to make heroes out of fools and legends out of luck. \n\n You do\'t speak. You do\'t need to. Today, yo\'ve given them a well deserved rest.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What a feast that was!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local food = this.World.Assets.getFoodItems();
				for( local i = 0; i < 2; i = ++i )
				{
					local idx = this.Math.rand(0, food.len() - 1);
					local item = food[idx];

					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You lose " + item.getName()
					});

					this.World.Assets.getStash().remove(item);
					food.remove(idx);
				}

				this.World.Assets.updateFood();

				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 65)
					{
						bro.improveMood(1.5, "Had quite the feast!");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}

					if (this.Math.rand(1, 100) <= 15)
					{

						local injury = bro.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));;
						this.List.push({
							id = 10,
							icon = "skills/status_effect_61.png",
							text = bro.getName() + " became drunk! "
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Wage Bonus",
			Text = "[img]gfx/ui/events/pov_camp_happy.png[/img]{You step forward with a small pouch in hand and a grin that draws every gaze your way. No words needed — the jingle of coin speaks well enough. One by one, you pass out a few extra coins to each of them, watching their eyes light up with surprise and satisfaction. The mood sharpens with cheer; laughter grows louder, men slap each other on the back, already dreaming of what the\'ll spend it on when they next reach a town. \n\n But not all join the mirth so easily. \n\n A few remain by the edges of the firelight, quiet, thoughtful. They nod in appreciation, but don\'t pocket the coin right away. For them, the clink of metal is a reminder — of debts, of loss, of the world\'s weight. They had hoped, perhaps just for this night, to forget it all. \n\n Still, the gesture is welcomed. Even if joy doesn\'t reach every face, you\'ve bought the company a little warmth — and that\'s enough.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Now le\'s see how they spend it!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local bonus = -1 * (brothers.len() * 200);
				this.World.Assets.addMoney(bonus);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You hand out " + bonus + " Gold"
				});

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(1.0, "Happy for a hefty bonus!");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					} else if (this.Math.rand(1, 100) <= 10)
					{
						bro.worsenMood(0.5, "I would rather not think of money for a bit...");
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
			ID = "Happy Hour",
			Text = "[img]gfx/ui/events/pov_camp_happy.png[/img]{As the laughter swells around the fire, you quietly pull %Specialist% aside. With a knowing glance, you ask if the company\'s medical supplies might be put to... alternative use — just for tonight. \n\nThe alchemist doesn\'t need much convincing. A few tinctures are repurposed, a few powders measured out with care, and before long, the mood around campfire explodes into near delirium. Colors seem richer, songs louder, and the shadows of the night dance with strange, almost mythic joy.\n\n For hours, the company celebrates with wild abandon — a roaring, laughing, spinning kind of joy that chases away every ache and shadow. By morning, a few men are still reeling, some barely able to stand from the excess. But none complain. \n\n The air hangs heavy with stories yet to be told, and the company\'s spirit burns brighter than ever.}",
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
				local medsCost = -1 * (brothers.len() * 2)
				this.World.Assets.addMedicine(medsCost);

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "You lose " + medsCost + " Medicine"
				});

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 80)
					{
						bro.improveMood(2.0, "Had an unforgettable party (doesn\'t remember shit)");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}

					if (this.Math.rand(1, 100) <= 15)
					{
						bro.getSkills().add(this.new("scripts/skills/effects_world/exhausted_effect"));

						this.List.push({
							id = 10,
							icon = "skills/status_effect_62.png",
							text = bro.getName() + " became exhausted! "
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_Specialist = [];

		if (brothers.len() <= 5)
		{
			return;
		}

		if (this.World.getTime().Days <= 30)
		{
			return;
		}
		
		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}
		

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_alchemist")
			{
				candidates_Specialist.push(bro);
			} 
		}

		if (candidates_Specialist.len() != 0)
		{
			this.m.Specialist = candidates_Specialist[this.Math.rand(0, candidates_Specialist.len() - 1)];
		}

		this.m.Score = 5 + brothers.len();
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
	}

	function onClear()
	{
		this.m.Specialist = null;
	}

});

