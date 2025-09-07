this.pov_sandgolem_in_hole_event <- this.inherit("scripts/events/event", {
	m = {
		Beastslayer = null
	},
	function create()
	{
		this.m.ID = "event.pov_sandgolem_in_hole";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_sandgolem_hole.png[/img]{You come across a sight pretty familiar to you - a man mauled to death, bloodied, on the side of the road. thanks to a nearbly blood trail, it is quite easy to notice that he was fleeing from a nearby hole in the ground. \n\n By cautiously approaching it and taking a quick look, you immediately notice that among the bloddied grass, tucked into a small rocky hole, lies a large, orange jagged rock. To your surprise, this is an ifrit, away from its southern lands. You can assume that the man you saw earlier tried to capture it for uknown reasons, or it may have been idle curiosity at play. \n\n Regardless, you notice that this elemental is still alive. You decide to...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Get in there and kill that thing!",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getAmmo() >= 25)
				{
					this.Options.push({
						Text = "Keep your distance and shoot it!",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				if (_event.m.Beastslayer != null)
				{
					this.Options.push({
						Text = "%beastslayer%, you\'re an expert on these things. Deal with it!",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "Not worth out time, we\'re leaving!",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});

		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/pov_sandgolem_hole.png[/img]{Among your men, there was a pause at the beginning, but the elemental was quickly overwhelmed and dealt with. Despite that thing being alone and cornered, it was not to be underestimated, as it did put up a decent fight, using the narrow space to its advantage.\n\n You are now left with a few scars and its remains, which you get into your cart, hoping that they might be of some use.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s get back on the road.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local newItem = this.new("scripts/items/misc/corpse/pov_corpse_sandgolem_item");
				this.World.Assets.getStash().add(newItem);
				this.List.push({
					id = 10,
					icon = "ui/items/" + newItem.getIcon(),
					text = "You get " + this.Const.Strings.getArticle(newItem.getName()) + newItem.getName()
				});
				
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
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

		});

		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/pov_sandgolem_hole.png[/img]{Shooting a rock? How did you think that would go?\n\n After a few shots, you have barely made a minor dent at the still motionless ifrit. After deciding to stop wasting the company\'s ammunition, your next command is:}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Get in there and kill that thing!",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				local lossRoll = -1 * this.Math.rand(5,10);
				this.World.Assets.addAmmo(lossRoll);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_ammo.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]"+lossRoll+"[/color] Ammunition"
					}
				];

				if (_event.m.Beastslayer != null)
				{
					this.Options.push({
						Text = "%beastslayer%, you\'re an expert on these things. Deal with it!",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "Not Worth out time, we\'re leaving!",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/pov_sandgolem_hole.png[/img]{Nodding, %beastslayer% the beast slayer walks up to the hole and stares in. It does not take %them_beastslayer% long to figure out how to lure the ifrit out of its hiding place. With a well timed dodge, followed by a precise strike, the elemental quickly crumbled. The rest of the company, having watched the entire scene, erupts into a vigorous celebration.\n\n You notice the beastslayer approaching the remains, quickly pocketing something, and then gathering everything else into a piece of cloth. %They_beastslayer% turns to you, grinning.  %SPEECH_ON%Here, I\'ts remains, might find some use for them%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good job, %beastslayer%!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beastslayer.getImagePath());

				_event.m.Beastslayer.getBaseProperties().Initiative += 1;
				_event.m.Beastslayer.getSkills().update();

				local newItem = this.new("scripts/items/misc/corpse/pov_corpse_sandgolem_item");
				this.World.Assets.getStash().add(newItem);

				_event.m.Beastslayer.improveMood(0.5, "Got to show off");

				this.List.push({
					id = 10,
					icon = "ui/items/" + newItem.getIcon(),
					text = "You get " + this.Const.Strings.getArticle(newItem.getName()) + newItem.getName()
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Beastslayer.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]1[/color] Initiative"
				});
				if (_event.m.Beastslayer.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Beastslayer.getMoodState()],
						text = _event.m.Beastslayer.getName() + this.Const.MoodStateEvent[_event.m.Beastslayer.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().Days < 30)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Desert)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_beastslayer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_beastslayer.push(bro);
			}
		}

		if (candidates_beastslayer.len() != 0)
		{
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}

		this.m.Score = 15 + candidates_beastslayer.len();
		//this.m.Score = 9999; // debug
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"beastslayer",
			this.m.Beastslayer ? this.m.Beastslayer.getNameOnly() : ""
		]);
		if (this.m.Beastslayer != null)
		{
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Beastslayer.getGender(), "beastslayer");
		}
	}

	function onClear()
	{
		this.m.Beastslayer = null;
	}

});

