this.pov_hexemut_vs_crusader_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null,
		crusader = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_vs_crusader";
		this.m.Title = "During camp...";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_crusader_vs_figure.png[/img]{The sound of shouting wakes you, harsh voices cracking like whips in the night air. By the time you reach the source, the fight is over, gear scattered, blood on the dirt, and two figures pulled apart by the others.\n\nYou find %crusader% seated alone, bloodied and breathing hard. %Their_crusader% armor is dented, one eye swelling shut. But %their_crusader% voice is steady.%SPEECH_ON%I struck first. I\'ll admit it. I saw the look, that Hexe\'s stain, coiled like a serpent in %vattghern%\'s soul. I struck, and was answered. I think I landed a blow... but not enough. Still, it\'s not my place to pass judgment, not while they fight under your banner. I\'ll let it go.%SPEECH_OFF% They don\'t ask for a bandage, only silence. You leave %them_crusader% there, but as you walk away, a thought sticks with you... how did %crusader%, who spoke so often of smiting evil, suddenly decide to let it go? You\'re not sure what unsettles you more: the fight... or how it ended.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "This is getting out of hand...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghernHexe.getImagePath());
				this.Characters.push(_event.m.crusader.getImagePath());

				_event.m.vattghernHexe.addHeavyInjury();
				_event.m.vattghernHexe.worsenMood(1.0, "Dissatisfied after a fight");

				_event.m.crusader.addHeavyInjury();
				//_event.m.crusader.getSkills().add(this.new("scripts/skills/effects/pov_exhausted_effect"));
				_event.m.crusader.worsenMood(1.0, "Dissatisfied after a fight");

				
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.vattghernHexe.getName() + " suffers serious wounds"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.crusader.getName() + " suffers serious wounds"
				});	
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.vattghernHexe.getName() + this.Const.MoodStateEvent[_event.m.vattghernHexe.getMoodState()]
				});
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.vattghernHexe.getMoodState()],
					text = _event.m.crusader.getName() + this.Const.MoodStateEvent[_event.m.crusader.getMoodState()]
				});	
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		local crusader_candidates = [];
		
		foreach( bro in brothers )
		{
			

			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen") && bro.getBackground().getID() != "background.legend_crusader" && bro.getBackground().getID() != "background.crusader")
			{
				vattghern_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.crusader" || bro.getBackground().getID() == "background.legend_crusader")
			{
				crusader_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0 || crusader_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernHexe = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.crusader = crusader_candidates[this.Math.rand(0, crusader_candidates.len() - 1)];
		this.m.Score = 20;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{

	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"vattghern",
			this.m.vattghernHexe.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vattghernHexe.getGender(), "vattghern");
		_vars.push([
			"crusader",
			this.m.crusader.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.crusader.getGender(), "crusader");
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
		this.m.crusader = null;
	}

});

