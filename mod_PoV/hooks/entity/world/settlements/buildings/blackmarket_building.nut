::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/blackmarket_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			// Removed after the suggestion of some guy
			/*{
				R = 95,
				P = 15.0,
				S = "misc/anatomist/pov_witcher_potion_item"
			},*/
			// VATTGHERN MUTAGENS
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_unhold_mutagen_item"
			},
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_strain_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_spider_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_skeleton_mutagen_item"
			},
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_serpent_mutagen_item"
			},
			{
				R = 99,
				P = 65.0,
				S = "misc/anatomist/pov_schrat_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_orc_mutagen_item"
			},
			{
				R = 99,
				P = 65.0,
				S = "misc/anatomist/pov_vampire_mutagen_item"
			},
			{
				R = 99,
				P = 65.0,
				S = "misc/anatomist/pov_lindwurm_mutagen_item"
			},
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_sandgolem_mutagen_item"
			},
			{
				R = 99,
				P = 55.0,
				S = "misc/anatomist/pov_hexe_mutagen_item"
			},
			{
				R = 99,
				P = 55.0,
				S = "misc/anatomist/pov_goblin_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_ghoul_mutagen_item"
			},
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_ghost_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_direwolf_mutagen_item"
			},  
			{
				R = 99,
				P = 60.0,
				S = "misc/anatomist/pov_basilisk_mutagen_item"
			},
			{
				R = 97,
				P = 55.0,
				S = "misc/anatomist/pov_alp_mutagen_item"
			},
			{
				R = 99,
				P = 2.0,
				S = "misc/anatomist/pov_beautiful_potion_item" //those are called by the script path, not ID
				//meme item
			},
			// TOG ITEMS
			{
				R = 98,
				P = 5.0,
				S = "scripts/items/misc/vampire_dust_item"
			},
			{
				R = 97,
				P = 5.0,
				S = "scripts/items/misc/unhold_heart_item"
			},
			{
				R = 98,
				P = 5.0,
				S = "scripts/items/misc/third_eye_item"
			},
			{
				R = 99,
				P = 3.0,
				S = "scripts/items/misc/sulfurous_rocks_item"
			},
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment);
	}

});