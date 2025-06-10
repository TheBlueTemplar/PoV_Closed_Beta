::TLW.HooksMod.hook("scripts/entity/tactical/actor", function ( q ) {

	q.onInit = @(__original) function()
	{
		// Add a new Sprite Layer
		local old_addSprite = this.addSprite;
		this.addSprite = function ( _layerID )
		{
			if (_layerID == "socket")
			{
				old_addSprite("pov_back_socket");
			}

			return old_addSprite(_layerID);
		};

		// If actor is a Vattghern, add a new, special bust layer!
		/*if (this.hasSprite("miniboss"))
		{
			local mutant_bust_sprite = this.getSprite("miniboss");
			mutant_bust_sprite.setBrush("pov_mutant_bust"); 
			mutant_bust_sprite.Saturation = 0.8;
			mutant_bust_sprite.Visible = true;
		}*/
		__original();
		//this.addSprite = old_addSprite;
	}

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		if (this.hasSprite("pov_back_socket"))
		{
			this.getSprite("pov_back_socket").Visible = false;
		}

		__original(_killer, _skill, _tile, _fatalityType);
	}
});