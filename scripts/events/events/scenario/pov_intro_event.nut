this.pov_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_intro.png[/img] You have finally arrived in this strange, untamed land. Fueled by ambition and dreams, you\'ve ensured that your past is far behind you. Only you know the trials and sins that mark your life, but one thing is clear: this land holds the opportunity you\'ve been searching for. \n\n Savages in the north, the undead clawing their way back to life, noble houses locked in endless feuds, religious conflict brewing, whispers of orcish hordes uniting, unspeakable horrors stalking the wilds, and now a new threat, mutants, making their appearance. This is a land of peril and chaos, a mercenary\'s paradise, and the perfect place for someone with your unique abilities. \n\nYou set forth on [color=" + this.Const.UI.Color.povEvent + "]the Path of the Vatt\'ghern[/color], determined to establish your own Order. Distrusted by the common folk, yet undeterred, you know that greatness is within reach. Your knowledge of alchemy and war will be your greatest weapon in the days to come.\n\n Fortune has brought you a few promising recruits: [color=" + this.Const.UI.Color.povEvent + "]%bs2%[/color] and [color=" + this.Const.UI.Color.povEvent + "]%bs3%[/color]. In a recent battle, with your guidance, they proved their worth by holding their ground against a mighty beast. They have earned your respect, and perhaps, one day, they might endure the Trial themselves... \n\nThe bard, however, is another story entirely. How he came to be with you - and how he has survived this long - remains a mystery. His endless chatter and questionable talents are a source of irritation, but somehow his antics keep morale high among the others. For now, that\'s enough to spare him from dismissal...",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "New Challenges Await!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Path of the Vatt\'ghern";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bs1",
			brothers[0].getNameOnly()
		]);
		_vars.push([
			"bs2",
			brothers[1].getNameOnly()
		]);
		_vars.push([
			"bs3",
			brothers[2].getNameOnly()
		]);
	}

	function onClear()
	{
	}

});

