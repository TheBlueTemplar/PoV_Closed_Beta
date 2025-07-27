this.pov_rickroll_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_rickroll";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_rickroll.gif[/img]{ Never gonna give you up\n Never gonna let you down\nNever gonna run around and desert you\nNever gonna make you cry\nNever gonna say goodbye\nNever gonna tell a lie and hurt you}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "☺ ♥♥♥ ☺",
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
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() <= 3)
		{
			return;
		}

		if (this.World.getTime().Days <= 30)
		{
			return;
		}

		this.m.Score = 5;
		//this.m.Score = 9999;
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

