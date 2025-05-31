this.pov_vattghern_crafts_poison_event <- this.inherit("scripts/events/event", {
	m = {
		vattghern = null
	},
	function create()
	{
		this.m.ID = "event.pov_vattghern_crafts_poison";
		this.m.Title = "During camp...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_vattghern_potion.png[/img]{You\'re doing your usual rounds when you spot %vattghern% hunched near the edge of camp, half-hidden behind a rock. His back is to you, movements strange—almost twitchy. Curious, you step closer. He doesn\'t notice at first. You catch a glimpse of something glistening between his fingers—dark, viscous, and dripping slowly into a small glass vial. You clear your throat. He freezes, turning slowly. %SPEECH_ON% It\'s spider venom, he mutters. Fresh. Don\'t waste it. %SPEECH_OFF% He holds the vial out with a reluctant grunt, like a child caught with his hand in a trapper\'s pouch. You take it, unsure whether to thank him for it. You glance him up and down. His eyes are unfocused, pupils thin as needles. The back of his neck twitches once, sharply. Then you notice something... off. %SPEECH_ON% Is this... cord coming out of your pants? %SPEECH_OFF% He looks at you. Slowly. Expression blank. %SPEECH_ON% Don\'t ask too many questions. %SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I Won\'t...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghern.getImagePath());
				local item = this.new("scripts/items/accessory/pov_vattghern_poison_item");
				local secondItem = this.new("scripts/items/misc/spider_silk_item");
				// Add two of the poison flasks
				this.World.Assets.getStash().add(item);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + secondItem.getIcon(),
					text = "You gain " + secondItem.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_vattghern = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.pov_spider_mutagen"))
			{
				candidates_vattghern.push(bro);
			}
		}

		if (candidates_vattghern.len() == 0)
		{
			return;
		}

		this.m.vattghern = candidates_vattghern[this.Math.rand(0, candidates_vattghern.len() - 1)];
		this.m.Score = 10;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"vattghern",
			this.m.vattghern != null ? this.m.vattghern.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.vattghern = null;
	}

});

