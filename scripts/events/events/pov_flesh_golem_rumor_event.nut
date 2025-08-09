this.pov_flesh_golem_rumor_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.pov_flesh_golem_rumor";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_square_speech.png[/img]{ You approach the square to see what the commotion is about. A well-dressed, armored figure stands at the center, voice steady, though their eyes betray a flicker of unease. A crowd has gathered, all drawn by whispers carried on the wind, whispers of a new horror.%SPEECH_ON%A threat has been sighted. A foul breed of abomination now roams the land — things made of grafted flesh, sewn limb to limb, moaning and screaming with every twisted step. They carry with them the stink of rot, and worse — they do not walk alone. Deranged minds lead them, men who speak to bones and wear madness like a crown. If you value your life, steer well clear.%SPEECH_OFF%Gasps ripple through the crowd. Mothers clutch their children. Old men shake their heads, muttering prayers. But you… you are left with a different impression...}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s Interesting!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// Skibidi Gyatt kind of event!
			}

		});
	}

	function onUpdateScore()
	{

		if (this.World.getTime().Days <= 30)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

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

		if (!nearTown)
		{
			return;
		}

		//this.m.Score = 5;
		this.m.Score = 999;
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

