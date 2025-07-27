this.pov_brother_loses_nyctophobia_event <- this.inherit("scripts/events/event", {
	m = {
		vattghern = null
	},
	function create()
	{
		this.m.ID = "event.pov_brother_loses_nyctophobia";
		this.m.Title = "During the night, in camp...";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_lose_nyctophobia.png[/img]{You find %vattghern% sitting at the very edge of camp, where the firelight fades and shadows gather thickly. It\'s strange — not long ago, the man would barely leave the tents at night without a torch clutched tight in his hand. Now he sits there calmly, staring into the darkness as though it were an old friend.\n\n You approach quietly, half-expecting him to flinch or retreat, but he does neither. Instead, he glances over his shoulder with a half-smile, one corner of his mouth twitching in amusement.%SPEECH_ON% Strange, isn\'t it? I used to fear the dark. Now... it feels like home.%SPEECH_OFF% He turns his gaze back to the night, eyes sharp, almost glowing faintly in the moonlight — a lingering gift of the mutagen.%SPEECH_ON% I thought the dark was hiding monsters. I was wrong. The dark hides me.%SPEECH_OFF% There\'s a lightness in his voice, a kind of fierce pride that wasn\'t there before. You can\'t help but smirk at the realization: %vattghern% hasn\'t just conquered his fear — he\'s embraced the night itself. As you leave him there, a half-joking thought crosses your mind: perhaps all he\'s missing now is a cloak and a cowl...}" 
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good to know that my men don\'t fear the night...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				// fallback
				/*if (_event.m.vattghern == null)
				{
					return;
				}*/

				this.Characters.push(_event.m.vattghern.getImagePath());
				
				local traitOld = _event.m.vattghern.getSkills().getSkillByID("trait.pov_nyctophobia");
				_event.m.vattghern.getSkills().remove(traitOld);

				local resolve_boost = this.Math.rand(1, 2);
				_event.m.vattghern.getBaseProperties().Bravery += resolve_boost;
				_event.m.vattghern.getSkills().update();

				this.List.push({
					id = 10,
					icon = traitOld.getIcon(),
					text = _event.m.vattghern.getName() + " is no longer afraid of the night..."
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.vattghern.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
				});

				_event.m.vattghern.improveMood(1.0, "I am the night");

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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local pussy_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_nyctophobia"))
			{
				if (bro.getSkills().hasSkill("effects.pov_skeleton_mutagen") || bro.getSkills().hasSkill("effects.pov_ghost_mutagen") || bro.getSkills().hasSkill("effects.pov_alp_mutagen") || bro.getSkills().hasSkill("effects.pov_direwolf_mutagen") || bro.getSkills().hasSkill("effects.pov_vampire_mutagen") || bro.getCurrentProperties().Bravery > 70)
				{
					pussy_candidates.push(bro);
				}
			}
		}

		if (pussy_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghern = pussy_candidates[this.Math.rand(0, pussy_candidates.len() - 1)];
		this.m.Score = 77;
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
	}

	function onClear()
	{
		this.m.vattghern = null;
	}

});

