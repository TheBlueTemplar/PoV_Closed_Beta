this.pov_vampire_mutagen_item <- this.inherit("scripts/items/misc/anatomist/pov_anatomist2_potion_item", {
	m = {},
	function create()
	{
		this.pov_anatomist2_potion_item.create();
		this.m.ID = "misc.pov_vampire_mutagen";
		this.m.Name = "Potion of the Nightstalker";
		this.m.Description = "This mutagen pulses with the dark vitality of a necrosavant, binding the bearer to the eternal embrace of night. Under the cover of darkness, they transform into a relentless predator, their strength, speed, and reflexes sharpened by the shadows. Injuries become fleeting as the bearer draws vitality from the blood of their enemies, healing themselves with every strike against those who bleed. The night no longer holds any mysteries or hindrances, becoming their ultimate domain.\n\nHowever, this power is a double-edged sword. The bright light of day weakens them, dulling their senses and sapping their combat prowess, as if the sun itself conspired to drain their vitality. A gift of dark potency, this mutagen is ideal for those who thrive in the obscurity of night, but its curse ensures they must tread carefully under the unforgiving gaze of daylight.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/pov_potion_vampire.png";
		this.m.Value = 600;
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
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Mutates the body, causing severe sickness"
		});

		result.push({
			id = 65,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Must have Witcher Mutation and not already used this mutagen."
		});

		return result;
	}

	function onUse( _actor, _item = null )
	{
		return ::TLW.MutatePlayer.mutatePlayer(_actor, ::TLW.PlayerMutation.Vampire);
	}

});

