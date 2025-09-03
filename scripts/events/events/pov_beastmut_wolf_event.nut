this.pov_beastmut_wolf_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernBeast = null
	},
	function create()
	{
		this.m.ID = "event.pov_beastmut_wolf";
		this.m.Title = "During camp...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_find_wolf.png[/img]{The night is quiet save for the crackle of the campfire and the low murmur of tired men. Then, a sound cuts through it... a long, haunting howl rolling over the hills. The company stiffens, hands drifting toward weapons, but no threat comes. Instead, it is %vattghern% who steps out of the shadows, grinning as though nothing is amiss.\n\nBehind them pads a wolf, its coat ragged and its eyes gleaming with a feral light. The beast moves with wary grace, but does not strike, instead, it settles at %vattghern%\'s side, as if the two had known each other for years.%SPEECH_ON% Easy now, lads. This one\'s no enemy. Name\'s Blaidd, and he\'s part of the company now.%SPEECH_OFF%The men exchange uneasy glances, muttering prayers or curses under their breath. Still, none dare step forward as the wolf sits by the fire, its fangs flashing in the firelight, a silent promise of loyalty.\n\nYou sigh, knowing resistance is pointless. Another mouth to feed, another risk to bear, but a useful set of fangs...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s some interesting company.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/wolf_item");
				item.m.Name = "Bleidd";
				this.World.Assets.getStash().add(item);

				_event.m.vattghernBeast.improveMood(0.5, "Found a new friend");

				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You get " + item.getName()
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernBeast.getMoodState()],
					text = _event.m.vattghernBeast.getName() + this.Const.MoodStateEvent[_event.m.vattghernBeast.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.pov_direwolf_mutagen") || bro.getSkills().hasSkill("effects.pov_direwolf_mutagen_upgraded"))
			{
				vattghern_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernBeast = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.Score = 15;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"vattghern",
			this.m.vattghernBeast.getName()
		]);
	}

	function onClear()
	{
		this.m.vattghernBeast = null;
	}

});

