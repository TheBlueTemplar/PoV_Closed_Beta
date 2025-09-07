this.pov_vattghern_confidence_event <- this.inherit("scripts/events/event", {
	m = {
		vattghern = null
	},
	function create()
	{
		this.m.ID = "event.pov_vattghern_confidence";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_122.png[/img]You find %vattghern% standing near the training dummy, %their_vattghern% blade still lodged in the wooden post, %their_vattghern% chest rising and falling with steady breaths. Sweat glistens on %their_vattghern% brow, but the look on %their_vattghern% face is not one of exhaustion, it\'s pride. %Their_vattghern% movements are sharper, %their_vattghern% stance more precise, and there\'s a newfound strength in %their_vattghern% gaze that commands respect. %SPEECH_ON% Do you see this? Look at what I\'ve become. Every swing, every strike, it all feels... right now. Precise. Powerful. But this... this isn\'t just hard work. No. It\'s what came after the Trial of the Grasses. %SPEECH_OFF% %Their_vattghern% voice trails off for a moment, and a flicker of something darker crosses %their_vattghern% face.%SPEECH_ON% At first, I regretted it. Gods, how I regretted it. The pain... the horror... I hated what I\'d agreed to. What I\'d become. But now? Now I see it for what it was—a transformation. The trial broke me, yes, but it rebuilt me into this. Stronger. Faster. Different. %SPEECH_OFF% %They_vattghern% pulls the blade free from the dummy with a single smooth motion, %their_vattghern% confidence unmistakable. %SPEECH_ON% I don\'t regret it anymore. Not one bit. %SPEECH_OFF% As %they_vattghern% turns back to the training dummy, %their_vattghern% focus unshaken, you realize that the %person_vattghern% standing before you isn\'t just a warrior. %They_vattghern%\'s something more: a force to be reckoned with!}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It's good to have you on our side!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghern.getImagePath());
				local resolve_boost = this.Math.rand(2, 4);
				_event.m.vattghern.getBaseProperties().Bravery += resolve_boost;
				_event.m.vattghern.getSkills().update();
				local mskill_boost = this.Math.rand(1, 2);
				_event.m.vattghern.getBaseProperties().MeleeSkill += mskill_boost;
				_event.m.vattghern.getSkills().update();
				local init_boost = this.Math.rand(1, 3);
				_event.m.vattghern.getBaseProperties().Initiative += init_boost;
				_event.m.vattghern.getSkills().update();

				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.vattghern.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.vattghern.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + mskill_boost + "[/color] Melee Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.vattghern.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Initiative"
				});
				_event.m.vattghern.improveMood(1.5, "Is confident in their unique skillset");

				if (_event.m.vattghern.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.vattghern.getMoodState()],
						text = _event.m.vattghern.getName() + this.Const.MoodStateEvent[_event.m.vattghern.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				vattghern_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghern = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.Score = 10 * vattghern_candidates.len();
		//this.m.Score = 9999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"vattghern",
			this.m.vattghern.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.vattghern.getGender(), "vattghern");
	}

	function onClear()
	{
		this.m.vattghern = null;
	}

});

