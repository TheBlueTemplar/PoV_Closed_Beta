this.pov_testing_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.pov_testing";
		this.m.Name = "POV Testing";
		this.m.Description = "[p=c][img]gfx/ui/events/pov_testing_vattghern.png[/img][/p][p]A scenario meant for internal testing, modified for use by the playtesters. Playing this origin is meant to be for testing very specific things like \'can x mutagen do the y thing \'.\n\n[color=#bcad8c]Filthy Rich:[/color] You begin rich with resources and money, starting with 20000 gold and almost maxed out meds, tools and ammo. \n\n [color=#bcad8c]Reputable:[/color] Despite doing nothing, you start with 1000 reputation, pretty close to professional. Wow! \n\n [color=#bcad8c]Mutationmaxxing:[/color] You have each off the mutation potions with you, including 3 Trial of the grasses potions, as well as any other new items I added to the mod. \n\n [color=#bcad8c] Not recommended for a \'normal\' playthrough! [/color][/p]";
		this.m.Difficulty = 4;
		this.m.Order = 39;
		this.m.IsFixedLook = true;
		this.m.StartingBusinessReputation = 1000;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function isValid()
	{
		return this.Const.DLC.Unhold;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 6; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(2.0, "Happy to be testing stuff out!");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
			i = i;
			i = i;
		}

		local bros = roster.getAll();

		bros[0].setStartValuesEx([
			"legend_herbalist_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% is an old witcher from the School of the Wolf, possibly the last of his kind.  He possesses secret knowledge for crafting mutagens.";
		//bros[0].setName("Vesemir");
		bros[0].setTitle("The Vatt'ghern");
		bros[0].setPlaceInFormation(4);
		bros[0].getBaseProperties().Hitpoints += 30;
		bros[0].getBaseProperties().MeleeSkill += 10;
		bros[0].getBaseProperties().MeleeDefense += 10;
		bros[0].getBaseProperties().RangedDefense += 5;
		bros[0].getSkills().add(this.new("scripts/skills/traits/pov_vattghern_trait"));
		bros[0].getFlags().increment("pov_ActiveMutations");
		bros[0].getSkills().add(this.new("scripts/skills/traits/old_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_field_triage"));
		bros[0].m.PerkPoints = 7;
		bros[0].m.LevelUps = 7;
		bros[0].m.Level = 8;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		//items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/pov_witcher_longsword"));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_gambeson_wolf"));
		items.equip(this.new("scripts/items/accessory/pov_vattghern_medallion_item"));
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Initiative] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 3;


		bros[1].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[1].getBackground().m.RawDescription = "A young whelp from the city, %name% got a start by becoming a prime target for experimentation!.";
		bros[1].setName("Poor Fella");
		bros[1].setTitle("The Lab Rat");
		bros[1].setPlaceInFormation(3);
		bros[1].getBaseProperties().MeleeSkill += 5;
		bros[1].getBaseProperties().RangedSkill += 5;
		bros[1].getBaseProperties().RangedDefense += 4;
		bros[1].getBaseProperties().MeleeDefense += 4;
		//bros[1].addLightInjury();
		//bros[1].addInjury(this.Const.Injury.Brawl);
		bros[1].m.PerkPoints = 5;
		bros[1].m.LevelUps = 5;
		bros[1].m.Level = 6;

		bros[2].setStartValuesEx([
			"legend_assassin_background"
		]);
		bros[2].getBackground().m.RawDescription = "A young assassin, %name% started by reading books. It is the study and preparation that will give the edge in battle.";
		//bros[2].setName("Lambert");
		bros[2].setPlaceInFormation(5);
		bros[2].getBaseProperties().MeleeSkill += 4;
		bros[2].getBaseProperties().Initiative += 4;
		//bros[2].addLightInjury();
		//bros[2].addInjury(this.Const.Injury.Brawl);
		bros[2].m.PerkPoints = 5;
		bros[2].m.LevelUps = 5;
		bros[2].m.Level = 6;

		// THIS IS A TESTING SLOT, PLACE WHATEVER BACKGROUND YOU WANT HERE
		bros[3].setStartValuesEx([
			"beggar_background"
		]);
		bros[3].getBackground().m.RawDescription = "What is this poor sod even doing here??";
		bros[3].setName("Broski");
		bros[4].setTitle("The Transformer");
		bros[3].setPlaceInFormation(14);
		bros[3].addLightInjury();
		bros[3].addInjury(this.Const.Injury.Brawl);
		bros[3].m.PerkPoints = 0;
		bros[3].m.LevelUps = 0;
		bros[3].m.Level = 1;

		bros[4].setStartValuesEx([
			"minstrel_background"
		]);
		bros[4].getBackground().m.RawDescription = "A truly flamboyant figure, %name% insisted in joining your order to record all of your feats and achievements. Not to mention that they are not really welcome to their home anymore, for undisclosed reasons of course. \n\n \'Nothing to concern your lordship, just a minor misunderstanding\' is all you can get. Not that you care.";
		bros[4].setName("Officinale");
		bros[4].setTitle("The Viscount");
		//bros[3].setBackgroundType(this.Const.BackgroundType.Female); FAIL XD
		bros[4].setPlaceInFormation(12);
		bros[4].getSkills().add(this.new("scripts/skills/traits/cocky_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/legend_seductive_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bros[4].getBaseProperties().Bravery += 15;
		bros[4].getBaseProperties().RangedDefense += 5;
		bros[4].addLightInjury();
		//bros[3].addInjury(this.Const.Injury.Brawl);
		bros[4].m.PerkPoints = 0;
		bros[4].m.LevelUps = 0;
		bros[4].m.Level = 1;

		bros[5].setStartValuesEx([
			"legend_vala_background"
		]);
		bros[5].getBackground().m.RawDescription = "Greek Original Giagia, has magic powers";

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Flags.set("HasLegendCampCrafting", true);
		// ADD SOME SUPPLIES
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_fish_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/goat_cheese_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		// ADD VATTGHERN MUTATION POTIONS AND STUFF TO HEAL THE INJURY
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/special/fountain_of_youth_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/special/fountain_of_youth_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/special/fountain_of_youth_item"));
		// ALL MOD'S NEW WEAPONS AND ITEMS
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/pov_whip_mace"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/named/pov_whip_mace_named"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/pov_witcher_longsword"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/pov_vattghern_medallion_item"));
		// ALL MOD'S MUTAGENS
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_alp_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_direwolf_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghost_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghoul_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_goblin_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_hexe_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_lindwurm_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_vampire_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_orc_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_schrat_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_skeleton_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_spider_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_unhold_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_strain_mutagen_item"));
		// NEWLY ADDED MUTATIONS
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_basilisk_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_sandgolem_mutagen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_serpent_mutagen_item"));
		// ALL MOD'S CORPSES
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_alp_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_alp2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_basilisk_drone_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_basilisk_sentry_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_direwolf_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_direwolf2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_ghost_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_ghost2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_ghoul_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_goblin1_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_goblin2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_goblin3_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_hexen_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_hexen2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_hyena_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_sandgolem_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_lindwurm_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_lindwurm2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_mummy_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_necro_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_orc_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_orc2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_orc3_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_schrat_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_schrat2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_serpent_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_skeleton_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_skeleton3_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_spider_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_spider2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_unhold_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_unhold2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_unhold4_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_vampire_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_vampire2_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_zombie_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_zombie2_item"));
		// VALA TESTING
		this.World.Assets.getStash().add(this.new("scripts/items/trade/uncut_gems_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/uncut_gems_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/uncut_gems_item"));
		// MISC/MEME STUFF
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_beautiful_potion_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_donkey_mutagen_item"));
		// NEWLY ADDED CORPSES
		/*
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_basilisk_drone_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/pov_corpse_basilisk_sentry_item"));
		*/
		// ALL INGREDIENTS FOR CRAFTING THE ToG
		/*
		this.World.Assets.getStash().add(this.new("scripts/items/misc/third_eye_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/acidic_saliva_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/poison_gland_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/unhold_heart_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/adrenaline_gland_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/vampire_dust_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/ghoul_brain_item"));
		*/
		// ORC MUTAGEN TESTING
		//this.World.Assets.getStash().add(this.new("scripts/items/weapons/greenskins/orc_cleaver"));

		this.World.Assets.getStash().resize(300);
		this.World.Assets.m.Money = 20000;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts * 3;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine * 3;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 3;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
			{
				break;
			}

			i = ++i;
			i = i;
			i = i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 3), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 3), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(11);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.pov_testing_scenario_intro");
		}, null);
	}





	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.FootprintVision = 1.5;
//		this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		if (this.World.State.getPlayer() != null)	//fallback for movespeed multiplier
		{
			this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		}
	}



});

