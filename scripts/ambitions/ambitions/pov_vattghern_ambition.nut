this.pov_vattghern_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.pov_vattghern";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "I have heard tales of the mythical \'Vatt\'ghern\'... \nIf we could find a way, having one would be a great boon to the company!";
		this.m.RewardTooltip = "You\'ll be awarded a unique Vatt'ghern medallion!";
		this.m.UIText = "Have one man with the \'Vatt'ghern\' trait";
		this.m.TooltipText = "Have at least one man with the \'Vatt'ghern\' trait. Getting one requires a time consuming, complicated and dangerous process. You will need to gather various monster materials to create the perilous \'Trial of the Grasses\' potion, and then make sure that someone healthy and experienced gets it. You\'ll also need space enough in your inventory for a new item.";
		this.m.SuccessText = "[img]gfx/ui/events/pov_mysterious_vattghern.png[/img] You were hesitant when %sergeantbrother% first spoke of becoming a Vatt'ghern. After all, who would willingly submit themselves to the Trial of the Grasses - a process that leaves most dead and the rest forever changed? Yet %sergeantbrother% was undeterred, his resolve forged of steel and tempered by years of hardship. \n\nAt first, his training seemed ordinary enough - long days with the blade, extended hunts in the wilds, and grueling endurance exercises. But soon, his efforts took a darker turn. He sought poisons to build resistance, demanded sparring sessions until his body could barely stand, and endured hunger, cold, and sleepless nights as though testing the limits of human endurance.\n\n%sergeantbrother% spoke little of his motives, yet the look in his eyes spoke volumes - a man possessed, chasing strength and power at any cost. The brothers watched with a mix of admiration and unease.\n\nThe day of his trial came, and what followed was a horror the others would not soon forget. The screams of a man being broken from the inside echoed through the camp for days. When the cries finally ceased, and %sergeantbrother% emerged, he was not the same man who had entered.\n\nNow, %sergeantbrother% moves with a predatory grace, his eyes alight with a clarity that unnerves even the bravest among you. He says little of the ordeal, but when asked, he only smirks and says, %SPEECH_ON% You can't forge a blade without fire. %SPEECH_OFF%The brothers may whisper in hushed tones of the inhuman strength he now wields, but none can deny that %sergeantbrotherfull% has become something more than mortal...";
		this.m.SuccessButtonText = "I hope all this was worth it.";
	}

	function onUpdateScore()
	{

		// Disable/Enable this one for debugging
		//CHECK IF THIS ONE WORKS
		local brothers = this.World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				return;
			}
		}

		// Disable/Enable this one for debugging
		if (this.World.Ambitions.getDone() < 4)
		{
			return;
		}

		// Disable/Enable this one for debugging
		if (this.World.getTime().Days <= 25)
		{
			return;
		}

		this.m.Score = 3 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return false;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				return true;
			}
		}

		return false;
	}

	function onReward()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;
		local bestSergeant;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher"))
			{
				if (bro.getCurrentProperties().getBravery() > highestBravery)
				{
					bestSergeant = bro;
					highestBravery = bro.getCurrentProperties().getBravery();
				}
			}
		}

		if (bestSergeant != null)
		{
			bestSergeant.setTitle("the Vatt'ghern");
			this.m.SuccessList.push({
				id = 90,
				icon = "ui/icons/special.png",
				text = bestSergeant.getNameOnly() + " is now known as " + bestSergeant.getName()
			});
		}

		local item = this.new("scripts/items/accessory/pov_vattghern_medallion_item");
		this.World.Assets.getStash().add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;
		local bestSergeant;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.pov_witcher") && bro.getCurrentProperties().getBravery() > highestBravery)
			{
				bestSergeant = bro;
				highestBravery = bro.getCurrentProperties().getBravery();
			}
		}

		_vars.push([
			"sergeantbrother",
			bestSergeant.getNameOnly()
		]);
		_vars.push([
			"sergeantbrotherfull",
			bestSergeant.getName()
		]);
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

