this.pov_mutant_scaling_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_mutant_scaling";
		this.m.Title = "Things are getting interesting...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_psychopath_event.png[/img]{As you are pondering on the latest events, there is one thought that you cannot let go of. The latest fights have left you with a weird sensation. As the world around you gets progressively more dangerous. Large crises, tougher monsters, more mutants... It is as if life itself is revolting, and you have no idea against what. The only thing you can put your trust in is your own strength and wit. And maybe your company. \n\n [color=" + this.Const.UI.Color.povEvent + "]After this point, and then for approximately every 70 days, enemies will become more difficult to deal with. Enemy Mutations will appear more often (can be disabled in options), and enemies added by PoV will get progressively stronger. Prepare accordingly.[/color]}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I am Ready...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// What are you looking for...? HUH?
			}

		});
	}

	function onUpdateScore()
	{
		if (::TLW.EnableEnemyMutation == false || ::TLW.EnemyMutationScaling == false)
		{
			return;
		}

		if (this.World.getTime().Days <= ::TLW.Scaling.A.Day)
		{
			return;
		}

		this.m.Score = 9999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{

	}

	function onClear()
	{

	}

});

