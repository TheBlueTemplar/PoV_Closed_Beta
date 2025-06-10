::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_building", function ( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 75,
				P = 1.0,
				S = "weapons/pov_whip_mace"
			}
		]);
		_list.extend([
			{
				R = 97,
				P = 2.0,
				S = "weapons/named/pov_whip_mace_named"
			}
		]);
		_list.extend([
			{
				R = 97,
				P = 2.0,
				S = "special/pov_silvering_kit"
			},
		]);
		__original( _list, _stash, _priceMult, _allowDamagedEquipment);
	}

});