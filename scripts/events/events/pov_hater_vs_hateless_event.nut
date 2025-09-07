this.pov_hater_vs_hateless_event <- this.inherit("scripts/events/event", {
	m = {
		hater = null,
		hateless = null
	},
	function create()
	{
		this.m.ID = "event.pov_hater_vs_hateless";
		this.m.Title = "During camp...";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/pov_psycho_vs_cannibal.png[/img]{The campfire crackles, shadows flickering against the worn faces of %hater% and %hateless%. You\'re nearby, pretending not to listen, but their voices cut through the night like a knife. %SPEECH_ON% ...Is there something I don\'t hate? Why? I\'ll tell you why! I hate beasts for their savage and reckless fury, tearing through the weak without mercy. Undead? They\'re nothing but cursed shells, a mockery of life, and their stench sickens me. Greenskins? Brutish, savage, with no honor! They tear apart kin and stranger alike. Mutants? Twisted abominations, broken by nature\'s own hand. Nobles? Spoiled vermin, hiding behind silk and lies while others bleed. And the rest of the plebs? A cruel, greedy lot. I hate them all, without exception.%SPEECH_OFF% %hateless% listens quietly, %their_hateless% eyes narrowing. When the tirade ends, a dark shadow crosses %their_hateless% face, a new fire kindles in %their_hateless% heart. %They_hateless% nod in agreement, muttering something under breath, something hateful, something new. %hater% notices and grins wide, satisfied. %SPEECH_ON%See? That\'s the spirit. Hate is the purest kind of love.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "As long as %their_hateless% hate is pointed at the enemy...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.hater.getImagePath());

				local resolve_boost = 1;
				_event.m.hater.getBaseProperties().Bravery += resolve_boost;
				_event.m.hater.getSkills().update();

				this.Characters.push(_event.m.hateless.getImagePath());
				local traitList = ["scripts/skills/traits/hate_undead_trait","scripts/skills/traits/hate_greenskins_trait","scripts/skills/traits/hate_beasts_trait","scripts/skills/traits/pov_hate_mutants_trait","scripts/skills/traits/pov_misanthropist_trait","scripts/skills/traits/legend_hate_nobles_trait"];
				//Remove hate mutants trait from possible rolls, if no mutants exist
				if(::TLW.EnableEnemyMutation == false)
				{
					traitList.remove(traitList.find("scripts/skills/traits/pov_hate_mutants_trait"));
				}

				local traitNew = this.new(traitList[this.Math.rand(0, traitList.len() - 1)]);
				_event.m.hateless.getSkills().add(traitNew);

				this.List.push({
					id = 10,
					icon = traitNew.getIcon(),
					text = _event.m.hateless.getName() + " gets the " + traitNew.getName() + " trait"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/bravery.png",
					text = _event.m.hater.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] Resolve"
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local hater_candidates = [];
		local hateless_candidates = [];
		
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_hate_everything"))
			{
				hater_candidates.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.pov_hate_everything") && !bro.getSkills().hasSkill("trait.hate_undead") && !bro.getSkills().hasSkill("trait.hate_greenskins") && !bro.getSkills().hasSkill("trait.hate_beasts") && !bro.getSkills().hasSkill("trait.pov_hate_mutants") && !bro.getSkills().hasSkill("trait.legend_hate_nobles") && !bro.getSkills().hasSkill("trait.pov_misanthropist") && !bro.getSkills().hasSkill("trait.legend_peaceful"))
			{
				hateless_candidates.push(bro);
			}
		}

		if (hater_candidates.len() == 0 || hateless_candidates.len() == 0)
		{
			return;
		}

		this.m.hater = hater_candidates[this.Math.rand(0, hater_candidates.len() - 1)];
		this.m.hateless = hateless_candidates[this.Math.rand(0, hateless_candidates.len() - 1)];
		this.m.Score = 1 + 5 * hateless_candidates.len();
		//this.m.Score = 9999;
	}

	function onPrepare()
	{

	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hater",
			this.m.hater.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.hater.getGender(), "hater");
		_vars.push([
			"hateless",
			this.m.hateless.getName()
		]);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.hateless.getGender(), "hateless");
	}

	function onClear()
	{
		this.m.hater = null;
		this.m.hateless = null;
	}

});

