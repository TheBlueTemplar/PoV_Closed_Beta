::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building", function( q ) {
	
	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 96,
				P = 2.2,
				S = "special/pov_silvering_kit"
			},
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment);
	}

});