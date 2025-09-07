this.pov_hexemut_vs_seductive_event <- this.inherit("scripts/events/event", {
	m = {
		vattghernHexe = null,
		seductive = null
	},
	function create()
	{
		this.m.ID = "event.pov_hexemut_vs_seductive";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_camp_figures.png[/img]{You find %seductive% and %vattghern% sitting by the fire. With the way things usually go around %vattghern%, you brace for another clash: harsh words, blood drawn, trust frayed. But not tonight. Their talk is soft, fluid. Friendly, even. You linger, confused, as %vattghern% laughs — genuinely — at something %seductive% says. It ends as simply as it began, with %seductive% rising, brushing off %their_seductive% cloak, and turning toward camp.\n\n As %they_seductive% passes by, you feel it. A shift. Not in air or sound, but in %them_seductive%.\n\n There was always charm in %seductive%, a smile too practiced, a voice that carried just enough warmth. But now, there\'s something deeper. A presence. As though something unseen is watching from behind %their_seductive% eyes, guiding %their_seductive% steps, coaxing others to lean closer without realizing why.\n\n%They_seductive% say nothing to you. %They_seductive% don\'t need to. You glance back at %vattghern%, who sits in stillness. Calm. No tension in the jaw. No fire in the eyes. Whatever happened between them wasn\'t alarming. It was... pleasant.\n\n And that\'s what troubles you.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s gonna be fun...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.vattghernHexe.getImagePath());

				local resolve_boost = 1;
				_event.m.vattghernHexe.getBaseProperties().Bravery += resolve_boost;
				_event.m.vattghernHexe.getSkills().update();

				this.Characters.push(_event.m.seductive.getImagePath());

				local traitOld = _event.m.seductive.getSkills().getSkillByID("trait.legend_seductive");
				local traitNew = this.new("scripts/skills/traits/pov_seductive_trait");
				_event.m.seductive.getSkills().remove(traitOld);
				_event.m.seductive.getSkills().add(traitNew);

				this.List.push({
					id = 10,
					icon = traitOld.getIcon(),
					text = _event.m.seductive.getName() + " is no longer just Seductive..."
				});

				this.List.push({
					id = 10,
					icon = traitNew.getIcon(),
					text = "but is now Irresistably Alluring!"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/bravery.png",
					text = _event.m.vattghernHexe.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local vattghern_candidates = [];
		local seductive_candidates = [];
		
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
			{
				vattghern_candidates.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.legend_seductive") && !bro.getSkills().hasSkill("effects.pov_hexe_mutagen"))
			{
				seductive_candidates.push(bro);
			}
		}

		if (vattghern_candidates.len() == 0 || seductive_candidates.len() == 0)
		{
			return;
		}

		this.m.vattghernHexe = vattghern_candidates[this.Math.rand(0, vattghern_candidates.len() - 1)];
		this.m.seductive = seductive_candidates[this.Math.rand(0, seductive_candidates.len() - 1)];
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
			"seductive",
			this.m.seductive.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.seductive.getGender(), "seductive");
	}

	function onClear()
	{
		this.m.vattghernHexe = null;
		this.m.seductive = null;
	}

});

