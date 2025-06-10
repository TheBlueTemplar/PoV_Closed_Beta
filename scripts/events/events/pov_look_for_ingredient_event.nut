this.pov_look_for_ingredient_event <- this.inherit("scripts/events/event", {
	m = {
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.pov_look_for_ingredient";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{The town\'s back alleys twist like gutted snakes, the air thick with the stench of rotting straw and piss-soaked mud. You ask after the anatomist in hushed tones, met with uneasy glances and hurried denials. Finally, a beggar points a knotted finger toward a sunken door, its frame blackened by years of smoke and secrecy. A rusted iron bell hangs beside it—one pull, and the door creaks open just enough for a sliver of candlelight to escape.\n\nInside, the apothecary\'s den reeks of preserving salts and something fouler—a metallic tang that clings to the back of your throat. Shelves groan under jars of pickled organs, their murky fluids catching the dim candlelight. At the center of the room, a figure clad in a long, waxed coat and a beaked mask turns toward you, gloved hands resting on a table strewn with scalpels, bone saws, and vials of unnamable substances.%SPEECH_ON% You seek something. An ingredient, yes? One of those… delicate components not easily found in the wilds or pried from common merchants\' hands. I can provide it. But knowledge demands sacrifice. A trade must be made—flesh for flesh. One of your men, willingly given, to endure my… investigations. I assure you, no lasting harm will come to him. But the process? Ah. Pain is the toll of understanding. %SPEECH_OFF% The anatomist tilts his head, the glass lenses of his mask reflecting the flickering flame. A long silence stretches as he waits for your answer.}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "[b]I would rather not get anything...[/b]",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Options.push({
						Text = "The Shimmering Ashes",
						function getResult( _event )
						{
							return "ash";
						}
					});
				this.Options.push({
						Text = "An Unhold\'s Heart",
						function getResult( _event )
						{
							return "heart";
						}
					});
				this.Options.push({
						Text = "A Third Eye",
						function getResult( _event )
						{
							return "eye";
						}
					});
				this.Options.push({
						Text = "Some Sulfurous Rocks",
						function getResult( _event )
						{
							return "rock";
						}
					});
				this.Options.push({
						Text = "[More Options ► ► ►]",
						function getResult( _event )
						{
							return "B";
						}
					});
			}

		});

		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{The town\'s back alleys twist like gutted snakes, the air thick with the stench of rotting straw and piss-soaked mud. You ask after the anatomist in hushed tones, met with uneasy glances and hurried denials. Finally, a beggar points a knotted finger toward a sunken door, its frame blackened by years of smoke and secrecy. A rusted iron bell hangs beside it—one pull, and the door creaks open just enough for a sliver of candlelight to escape.\n\nInside, the apothecary\'s den reeks of preserving salts and something fouler—a metallic tang that clings to the back of your throat. Shelves groan under jars of pickled organs, their murky fluids catching the dim candlelight. At the center of the room, a figure clad in a long, waxed coat and a beaked mask turns toward you, gloved hands resting on a table strewn with scalpels, bone saws, and vials of unnamable substances.%SPEECH_ON% You seek something. An ingredient, yes? One of those… delicate components not easily found in the wilds or pried from common merchants\' hands. I can provide it. But knowledge demands sacrifice. A trade must be made—flesh for flesh. One of your men, willingly given, to endure my… investigations. I assure you, no lasting harm will come to him. But the process? Ah. Pain is the toll of understanding. %SPEECH_OFF% The anatomist tilts his head, the glass lenses of his mask reflecting the flickering flame. A long silence stretches as he waits for your answer.}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I would rather not get anything...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Options.push({
						Text = "A Poison Gland",
						function getResult( _event )
						{
							return "poison";
						}
					});
				this.Options.push({
						Text = "An Adrenaline Gland",
						function getResult( _event )
						{
							return "adrenaline";
						}
					});
				this.Options.push({
						Text = "A Nachzehrer\'s Brain",
						function getResult( _event )
						{
							return "brain";
						}
					});
				this.Options.push({
						Text = "[◄ ◄ ◄ Previous Options]",
						function getResult( _event )
						{
							return "A";
						}
					});
			}

		});
		// Event text and Function that adds desired item and does the rest of event, to avoid bloatt

		local eventText = "The company gathers in the den\'s dim backroom, the alchemist\'s request hanging heavy in the air. No man volunteers. With grim resignation, you cut straws - the shortest drawn by %other%, who meets his fate with a soldier\'s stoicism. The anatomist\'s workshop smells of vinegar and burnt hair. He motions %other% toward an iron-framed table, its leather straps worn shiny from use. As the door closes behind you, the last thing you see is the gleam of surgical steel in candlelight.\n\n Three hours pass before %other% reappears, moving stiffly but under his own power. He wordlessly presses a glass phial into your hand - the precious ingredient, now slick with sweat. %SPEECH_ON% Fascinating circulatory system! You breed them tough in the mercenary trade. %SPEECH_OFF% %other% spits in the dirt as you leave. He\'ll recover in time, but none of the men ask what happened behind that door. Some questions are better left unanswered.";
		local eventResult = function(_event,_item)
		{
			this.Characters.push(_event.m.OtherGuy.getImagePath());
			local newItem = this.new(_item);

			this.World.Assets.getStash().add(newItem);
			_event.m.OtherGuy.addHeavyInjury();
			local injury = _event.m.OtherGuy.addInjury(this.Const.Injury.PiercingBody);
			_event.m.OtherGuy.worsenMood(2.0, "Was Experimented On");

			this.List.push({
				id = 10,
				icon = "ui/items/" + newItem.getIcon(),
				text = "You get " + this.Const.Strings.getArticle(newItem.getName()) + newItem.getName()
			});
			this.List.push({
				id = 10,
				icon = "ui/icons/days_wounded.png",
				text = _event.m.OtherGuy.getName() + " suffers serious wounds"
			});
			this.List.push({
				id = 10,
				icon = injury.getIcon(),
				text = _event.m.OtherGuy.getName() + " suffers " + injury.getNameOnly()
			});
			this.List.push({
				id = 10,
				icon = this.Const.MoodStateIcon[_event.m.OtherGuy.getMoodState()],
				text = _event.m.OtherGuy.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy.getMoodState()]
			});
		}

		// Actual Event Options (They Use The stuff from above)

		this.m.Screens.push({
			ID = "ash",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/vampire_dust_item");
			}
		});

		this.m.Screens.push({
			ID = "heart",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/unhold_heart_item");
			}
		});

		this.m.Screens.push({
			ID = "eye",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/third_eye_item");
			}
		});

		this.m.Screens.push({
			ID = "rock",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/sulfurous_rocks_item");
			}
		});

		this.m.Screens.push({
			ID = "poison",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{The anatomist seems surprised. %SPEECH_ON% What? This is what you want? I\'m sure you could find this easily, but as you wish...%SPEECH_OFF%"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/poison_gland_item");
			}
		});
		
		this.m.Screens.push({
			ID = "adrenaline",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{The anatomist seems surprised. %SPEECH_ON% What? This is what you want? I\'m sure you could find this easily, but as you wish...%SPEECH_OFF%"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/adrenaline_gland_item");
			}
		});
		
		this.m.Screens.push({
			ID = "brain",
			Text = "[img]gfx/ui/events/pov_anatomist_over_tools.png[/img]{The anatomist seems surprised. %SPEECH_ON% What? This is what you want? I\'m sure you could find this easily, but as you wish...%SPEECH_OFF%"+eventText+"}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hope this was worth it...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				eventResult(_event,"scripts/items/misc/ghoul_brain_item");
			}
		});
	}

	function onUpdateScore()
	{
		// Happens if: Is near town, town has taxidermist or alchemist, has more than 3 bros and over 30 days

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!town.hasBuilding("building.taxidermist") && !town.hasBuilding("building.taxidermist_oriental") && !town.hasBuilding("building.alchemist"))
		{
			return;
		}
		
		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.lucky") && !bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				other_candidates.push(bro);
			}
		}

		/*if (other_candidates.len() == null)
		{
			return;
		}

		if (brothers.len() <= 3)
		{
			return;
		}

		if (this.World.getTime().Days <= 30)
		{
			return;
		}*/

		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		//this.m.Score = 10;
		this.m.Score = 9999;
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
	}

	function onClear()
	{
		this.m.OtherGuy = null;
	}

});

