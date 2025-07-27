/////////////////////////////////////////////////////////////////////
// 					Author: The Blue Templar 					   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

this.pov_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.pov_last_witchers";
		this.m.Name = "Path of the Vatt'ghern";
		this.m.Description = "[p=c][img]gfx/ui/events/pov_vattghern_origin.png[/img][/p][p] You are a Vatt\'ghern, a professional beastslayer who has come to these lands with the ambition of establishing a new School! The challenges are many, as most view you and your kin as mutants, thus it will be hard to earn the people\'s trust, except for those who also fight against vicious beasts...\n\n[color=#bcad8c]Vatt\'ghern on the Path:[/color] Start with an experienced Vatt\'ghern, who has all the knowledge of mutagen creation and corpse dissection and has also brought a few Trial of the Grasses potions along, along with some strong gear. \n\n[color=#bcad8c]Monster Hunters:[/color] Due to the expertise of your group, you can move faster on the map, and you can spot enemy tracks from further away. \n\n[color=#bcad8c]Mutants:[/color] Few people will trust you, and even fewer will want to deal with you. You start with significantly low reputation. Most recruits, excluding those who hate beasts or are experienced at beasthunting, will demand much more pay to work for you. On the other hand, beasthunting origins, including some rare ones, will appear more frequently. Finally, you will get 15% worse prices overall. \n\n[color=#bcad8c]Spoils Of The Hunt:[/color] 25% Chance for extra drops from monsters, due to your knowledge and techniques. \n\n[color=#bcad8c]This Origin is meant to be a \"headstart\" into PoV, easing the players into the mod by immediately granting access into some of its mid-late game mechanics. [/color][/p]";
		this.m.Difficulty = 2;
		this.m.Order = 40;
		this.m.IsFixedLook = true;
		this.m.StartingBusinessReputation = -400;
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

		for( local i = 0; i < 4; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			if (i == 3)
			{
				bro.improveMood(2.0, "Has \'slain\' a dangerous dragon!!!");
			}else
			{
				bro.improveMood(1.0, "Has slain a dangerous beast")
			}
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
		bros[0].getBackground().m.RawDescription = "%name% is an old Vatt'ghern hailing from faraway lands. Despite their apparent age, their unquenchd ambitious glare instills a grave sense of supernatural danger";
		//bros[0].setName("Vesemir");
		bros[0].setTitle("The Vatt'ghern");
		bros[0].setPlaceInFormation(4);
		bros[0].getBaseProperties().Hitpoints += 30;
		bros[0].getBaseProperties().MeleeSkill += 10;
		bros[0].getBaseProperties().RangedSkill += 5;
		bros[0].getBaseProperties().MeleeDefense += 10;
		bros[0].getBaseProperties().RangedDefense += 5;
		bros[0].getSkills().add(this.new("scripts/skills/traits/pov_vattghern_trait"));
		bros[0].getFlags().increment("pov_ActiveMutations");
		bros[0].getSkills().add(this.new("scripts/skills/traits/pov_old_vattghern_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_field_triage"));
		bros[0].m.PerkPoints = 5;
		bros[0].m.LevelUps = 5;
		bros[0].m.Level = 6;
		bros[0].m.LifetimeStats.Kills = 75;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/pov_witcher_longsword"));
		//local armor = ["scripts/items/legend_armor/cloth/legend_gambeson_wolf","scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"];
		//items.equip(this.new(armor));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_gambeson_wolf"));
		//items.equip(this.World.Assets.getStash("legend_direwolf_pelt_upgrade"));
		//items.equip(this.new("scripts/items/helmets/legend_noble_hood"));
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
		bros[1].getBackground().m.RawDescription = "Refusing to talk about their past, the only sure thing about %name% is their relentless hate for anything even resembling a beast";
		//bros[1].setName("Eskel");
		bros[1].setPlaceInFormation(3);
		bros[1].getBaseProperties().MeleeSkill += 5;
		bros[1].getBaseProperties().RangedSkill += 5;
		bros[1].getBaseProperties().RangedDefense += 4;
		bros[1].getBaseProperties().MeleeDefense += 4;
		bros[1].getSkills().add(this.new("scripts/skills/traits/hate_beasts_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
		bros[1].addLightInjury();
		bros[1].addInjury(this.Const.Injury.Brawl);
		bros[1].m.PerkPoints = 2;
		bros[1].m.LevelUps = 2;
		bros[1].m.Level = 3;

		bros[2].setStartValuesEx([
			"legend_assassin_background"
		]);
		bros[2].getBackground().m.RawDescription = "A young assassin, %name% started by reading books to become a healer and a scholar. It is only some truly horrifying events that led this refined mind and its knowledge to the art of murder";
		//bros[2].setName("Lambert");
		bros[2].setPlaceInFormation(5);
		bros[2].getBaseProperties().MeleeSkill += 4;
		bros[2].getBaseProperties().Initiative += 4;
		bros[2].getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bros[2].addLightInjury();
		bros[2].addInjury(this.Const.Injury.Brawl);
		bros[2].m.PerkPoints = 2;
		bros[2].m.LevelUps = 2;
		bros[2].m.Level = 3;

		bros[3].setStartValuesEx([
			"minstrel_background"
		]);
		bros[3].getBackground().m.RawDescription = "A truly flamboyant figure, %name% insisted in joining your order to record all of your feats and achievements. Not to mention that they are not really welcome to their home anymore, for undisclosed reasons of course. \n\n \'Nothing to concern your lordship, just a minor misunderstanding\' is all you can get. Not that you care.";
		bros[3].setName("Officinale");
		bros[3].setTitle("The Viscount");
		//bros[3].setBackgroundType(this.Const.BackgroundType.Female); FAIL XD
		bros[3].setPlaceInFormation(13);
		bros[2].getBaseProperties().Bravery += 15;
		bros[2].getBaseProperties().RangedDefense += 5;
		bros[3].getSkills().add(this.new("scripts/skills/traits/cocky_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/legend_seductive_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bros[3].addLightInjury();
		//bros[3].addInjury(this.Const.Injury.Brawl);
		bros[3].m.PerkPoints = 0;
		bros[3].m.LevelUps = 0;
		bros[3].m.Level = 1;

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Flags.set("HasLegendCampCrafting", true);
		// Starting Supplies
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_fish_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		// Starting Utility (+Leg.Sword, and Vattghern Medallion, equipped on the Vattghern)
		this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		this.World.Assets.getStash().add(this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade"));
		this.World.Assets.getStash().add(this.new("scripts/items/tools/throwing_net"));
		this.World.Assets.getStash().add(this.new("scripts/items/special/pov_silvering_kit"));
		// Starting Vattghern Items
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_witcher_potion_item"));
		// Add A Random Mutagen
		local roll = this.Math.rand(1,14);
		switch (roll) 
		{
			case 1: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_alp_mutagen_item")); break;
			case 2: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_direwolf_mutagen_item")); break;
			case 3: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghost_mutagen_item")); break;
			case 4: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_ghoul_mutagen_item")); break;
			case 5: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_goblin_mutagen_item")); break;
			case 6: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_hexe_mutagen_item")); break;
			case 7: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_lindwurm_mutagen_item")); break;
			case 8: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_vampire_mutagen_item")); break;
			case 9: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_orc_mutagen_item")); break;
			case 10: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_schrat_mutagen_item")); break;
			case 11: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_skeleton_mutagen_item")); break;
			case 12: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_spider_mutagen_item")); break;
			case 13: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_unhold_mutagen_item")); break;
			case 14: this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/pov_strain_mutagen_item")); break;
			default: ::TLW.Mod.Debug.printLog("No Mutation found to roll. Roll Number: " + roll);
		}
		// Starting Resource Modifiers
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 1.5);
		this.World.Assets.m.Medicine = this.Math.round(this.World.Assets.m.Medicine * 1.5);
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
			this.World.Events.fire("event.pov_scenario_intro");
		}, null);
	}


	function onGenerateBro(bro)
	{
		local r;
		r = this.Math.rand(0,6);
		if (bro.getBackground().getID() == "background.beast_slayer")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
			bro.getBaseProperties().DailyWageMult *= 0.75;
			bro.getSprite("socket").setBrush("bust_base_beasthunters");
			bro.getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
			bro.improveMood(1.5, "Hates beasts as much as you do");
		}
		else if (bro.getBackground().getID() == "background.legend_vala")
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.0);
			bro.getBaseProperties().DailyWageMult *= 0.0;
			bro.getSkills().add(this.new("scripts/skills/traits/legend_beastslayers_trait"));
			bro.improveMood(1.5, "Feels at one with nature");
		}
		else if (r == 0 || r == 1 || bro.getSkills().hasSkill("trait.hate_beasts"))
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.8);
			bro.getBaseProperties().DailyWageMult *= 0.8;
			if (!bro.getSkills().hasSkill("trait.hate_beasts"))
			{
				bro.getSkills().add(this.new("scripts/skills/traits/hate_beasts_trait"));
			}
			bro.improveMood(1.5, "Hates beasts as much as you do");
		}
		else
		{
			bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.35);
			bro.getBaseProperties().DailyWageMult *= 1.35;
			bro.worsenMood(2.0, "Has heard terrifying things about your kind...");
		}

		bro.getSkills().update();
	}


	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.FootprintVision = 1.5;
		this.World.Assets.m.BuyPriceMult = 1.15;
		this.World.Assets.m.SellPriceMult = 0.85;
		this.World.Assets.m.ExtraLootChance = 25;
//		this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		if (this.World.State.getPlayer() != null)	//fallback for movespeed multiplier
		{
			this.World.State.getPlayer().m.BaseMovementSpeed = 120;
		}
	}


	function onUpdateHiringRoster( _roster )
	{
		this.addBroToRoster(_roster, "beast_hunter_background", 7);
	}

});

