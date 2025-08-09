this.pov_hate_everything_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		Started = 0,
		Trait1 = null,
		Trait2 = null,
		DaysHad = 0,
		DayChanged = 0,
		DaysToChange = 2
		},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pov_hate_everything";
		this.m.Name = "Hates Everything";
		this.m.Icon = "ui/traits/pov_hate_everything.png";
		this.m.Description = "It is a curious question, whether there is something that %name% likes.";
		this.m.Excluded = [
			"trait.weasel",
			"trait.craven",
			"trait.dastard",
			"trait.fainthearted",
			"trait.pov_fear_mutants",
			"trait.pov_hate_mutants",
			"trait.pov_misanthropist",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.fear_greenskins",
			"trait.hate_greenskins",
			"trait.legend_fear_nobles",
			"trait.legend_hate_nobles",
			"trait.legend_peaceful"
		];
	}

	function changeTraits()
	{
		//Possible Hate Perks
		local traitList = ["scripts/skills/traits/hate_undead_trait","scripts/skills/traits/hate_greenskins_trait","scripts/skills/traits/hate_beasts_trait","scripts/skills/traits/pov_hate_mutants_trait","scripts/skills/traits/pov_misanthropist_trait","scripts/skills/traits/legend_hate_nobles_trait"];
		
		//Remove hate mutants trait from possible rolls, if, well, no mutants exist
		if(::TLW.EnableEnemyMutation == false)
		{
			traitList.remove(traitList.find("scripts/skills/traits/pov_hate_mutants_trait"));
		}

		local actor = this.getContainer().getActor();

		// Check if actor has already active perks
		// If yes, remove them, and make sure they don't roll again
		if (this.m.Trait1 != null && this.m.Trait2 != null)
		{
			local oldTrait1 = this.new(this.m.Trait1);
			local oldTrait2 = this.new(this.m.Trait2);
			//Debug
			::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Trying to Remove Old Traits:  " + oldTrait1.getName()+" and "+oldTrait1.getName());

			//Remove traits from actor and array, with fallback
			if (actor.getSkills().hasSkill(oldTrait1))
			{
				actor.getSkills().removeByID(oldTrait1.getID());
				traitList.remove(traitList.find(this.m.Trait1));
				::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Successfully Removed Trait 1");
			}
			
			if (actor.getSkills().hasSkill(oldTrait2))
			{
				actor.getSkills().removeByID(oldTrait2.getID());
				traitList.remove(traitList.find(this.m.Trait2));
				::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Successfully Removed Trait 2");
			}
		}

		//Add 2 Of These Perks to Actor
		//Pick two traits from the list, save them to m
		this.m.Trait1 = traitList[this.Math.rand(0, traitList.len() - 1)];
		traitList.remove(traitList.find(this.m.Trait1));
		this.m.Trait2 = traitList[this.Math.rand(0, traitList.len() - 1)];

		//Add these traits to the actor, if he does not have them already
		local trait1 = this.new(this.m.Trait1);
		local trait2 = this.new(this.m.Trait2);

		//Fallbacj uf actor has them already (normally, he should not)
		if (!actor.getSkills().hasSkill(trait1.getID()))
		{
			actor.getSkills().add(trait1);
		}
		if (!actor.getSkills().hasSkill(trait2.getID()))
		{
			actor.getSkills().add(trait2);
		}

		//Debug
		::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Days Passed Since Last Change: " + this.m.DaysHad);
		::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Added Trait 1: " + trait1.getName());
		::TLW.Mod.Debug.printLog("Checking Hate Everything Trait || Added Trait 2: " + trait2.getName());

		//Start Counting the Days / Reset Counting
		this.m.DayChanged = this.World.getTime().Days;
		this.m.DaysHad = this.World.getTime().Days - this.m.DayChanged;
	}
	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Does [color=" + this.Const.UI.Color.PositiveValue + "]+1%[/color] Damage against anything and everything."
			}
		];

		if (this.m.Trait1 != null && this.m.Trait2 != null)
		{
			local trait1 = this.new(this.m.Trait1);
			local trait2 = this.new(this.m.Trait2);

			result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Currently, has the [color=" + this.Const.UI.Color.PositiveValue + "]"+ trait1.getName() +"[/color] and [color=" + this.Const.UI.Color.PositiveValue + "]"+ trait2.getName() +"[/color] traits."
			});
			result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/mood_01.png",
				text = "In some days, this [color=" + this.Const.UI.Color.NegativeValue + "]hatred[/color] will target something else..."
			});
		}

		return result;
	}

	function onAdded()
	{
		if (this.m.Started == 0)
		{
			changeTraits();
			this.m.Started = 1;
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		//Buffs
		_properties.MeleeDamageMult *= 1.01;

		//Check for Current Day, if x (see m table above) Days pass, switch traits!
		local dayCheck = this.World.getTime().Days - this.m.DayChanged;
		if (dayCheck >= this.m.DaysToChange)
		{
			changeTraits();
		}

		if (!actor.isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}
	}

	function onSerialize( _out )
	{
		this.character_trait.onSerialize(_out);
		_out.writeU8(this.m.Started);
		_out.writeU16(this.m.DaysHad);
		_out.writeU16(this.m.DayChanged);
		_out.writeString(this.m.Trait1);
		_out.writeString(this.m.Trait2);
	}

	function onDeserialize( _in )
	{
		this.character_trait.onDeserialize(_in);
		this.m.Started = _in.readU8();
		this.m.DaysHad = _in.readU16();
		this.m.DayChanged = _in.readU16();
		this.m.Trait1 = _in.readString();
		this.m.Trait2 = _in.readString();
	}

});
