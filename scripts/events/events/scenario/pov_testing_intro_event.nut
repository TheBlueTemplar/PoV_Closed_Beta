this.pov_testing_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_testing_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_testing_intro.png[/img] Welcome to the testing scenario of PoV! This scenario was originally meant for my personal use, to test out items and such, but why not make it public for all of you to mess around and enoy? \n\n In your inventory, you will find all new items I added in the mod, as well as all the different mutagens. Feel free to play around, but just keep in mind that this scenario is meant for testing very specific things, so don't come to me talking about balance issues if you make an uber strong 10 mutation witcher! \n\n [color=" + this.Const.UI.Color.PositiveValue + "]Thank you for participating in the Testing![/color]",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Testing and Fun Await!",
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
		this.m.Title = "Welcome to the PoV Beta!";
	}

	function onPrepareVariables( _vars )
	{

	}

	function onClear()
	{
	}

});

