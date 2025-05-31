::TLW.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			// Removed after the suggestion of some guy
			/*{
				R = 95,
				P = 15.0,
				S = "misc/anatomist/pov_witcher_potion_item"
			},*/
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_unhold_mutagen_item"
			},
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_strain_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_spider_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_skeleton_mutagen_item"
			},
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_serpent_mutagen_item"
			},
			{
				R = 98,
				P = 55.0,
				S = "misc/anatomist/pov_schrat_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_orc_mutagen_item"
			},
			{
				R = 98,
				P = 55.0,
				S = "misc/anatomist/pov_vampire_mutagen_item"
			},
			{
				R = 98,
				P = 55.0,
				S = "misc/anatomist/pov_lindwurm_mutagen_item"
			},
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_sandgolem_mutagen_item"
			},
			{
				R = 98,
				P = 55.0,
				S = "misc/anatomist/pov_hexe_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_goblin_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_ghoul_mutagen_item"
			},
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_ghost_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_direwolf_mutagen_item"
			},
			{
				R = 97,
				P = 50.0,
				S = "misc/anatomist/pov_basilisk_mutagen_item"
			},
			{
				R = 96,
				P = 45.0,
				S = "misc/anatomist/pov_alp_mutagen_item"
			},
			{
				R = 98,
				P = 1.0,
				S = "misc/anatomist/pov_beautiful_potion_item" //those are called by the script path, not ID
				//meme item
			},
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}

});