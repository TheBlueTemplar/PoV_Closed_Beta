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