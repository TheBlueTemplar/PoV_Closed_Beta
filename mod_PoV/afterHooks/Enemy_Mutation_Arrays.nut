// Enemy Mutation Subsets - First ones of each category are the mostly used ones, others are specialties
// !!! Are automatically updated, but its best to tailor if adding new mutations! !!!
// South is about southern biome (-no. 1,10), North about barbarian, snow biome (-no. 6,8)
// Vars n Objects used in these arrays are defined in Enemy_Mutations.nut, at bottom

::logInfo("PoV Enemy Mutation Arrays Loaded");
// Tanky Versions, for enemies that benefit most from survivability
::TLW.EnemyMut.Tank <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Spider,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Rot);
::TLW.EnemyMut.TankSouth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Spider,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Rot);
::TLW.EnemyMut.TankNorth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Spider,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Rot);
// "Swarm" Versions, for enemies that can benefit both from tankyness, and utility (but not direct power)
::TLW.EnemyMut.Swarm <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.SwarmSouth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.SwarmNorth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
// Melee Versions, Dont have ranged only buffs (goblin, mostly)
::TLW.EnemyMut.Melee <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.MeleeSouth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.MeleeNorth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Goblin);
// Ranged Versions, Dont have melee only buffs
::TLW.EnemyMut.Ranged <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Rot);
::TLW.EnemyMut.RangedSouth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Rot);
::TLW.EnemyMut.RangedNorth <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Rot);
// Undead Versions, More Curated Per Undead Type (some are tanky, some swarm, some also attack!)
::TLW.EnemyMut.MummyGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Skeleton,::TLW.EnemyMut.Alp);
::TLW.EnemyMut.ZombieGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Skeleton);
::TLW.EnemyMut.VampireGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Skeleton);
::TLW.EnemyMut.SkeletonGroup <- ::TLW.EnemyMut.Only(::TLW.EnemyMut.Orc,::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Schrat,::TLW.EnemyMut.Hexe);
// Greenskins (two types here, melee and ranged pretty much) (Cant have greenskin muts duh)
::TLW.EnemyMut.GoblinGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.OrcGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Orc,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
// Beast Versions, All are individual (tailored to each beast) (base: - 11,12,their own)
::TLW.EnemyMut.UnholdGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Unhold);
::TLW.EnemyMut.SpiderGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Spider);
::TLW.EnemyMut.LindwurmGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Lindwurm);
::TLW.EnemyMut.SerpentGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Serpent);
::TLW.EnemyMut.GhoulGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Ghoul);
::TLW.EnemyMut.BasiliskGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Basilisk);
::TLW.EnemyMut.DirewolfGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.SchratGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Vampire,::TLW.EnemyMut.Spider,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin, ::TLW.EnemyMut.Schrat,::TLW.EnemyMut.Rot);
::TLW.EnemyMut.HyenaGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin);
::TLW.EnemyMut.SpiderGroup <- ::TLW.EnemyMut.AllExcept(::TLW.EnemyMut.Direwolf,::TLW.EnemyMut.Goblin,::TLW.EnemyMut.Schrat,::TLW.EnemyMut.Alp);
::TLW.EnemyMut.AlpGroup <- ::TLW.EnemyMut.Only(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Lindwurm,::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Schrat,::TLW.EnemyMut.Hexe);
::TLW.EnemyMut.HexeGroup <- ::TLW.EnemyMut.Only(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Sandgolem,::TLW.EnemyMut.Serpent,::TLW.EnemyMut.Schrat,::TLW.EnemyMut.Skeleton,::TLW.EnemyMut.Alp);
::TLW.EnemyMut.SandgolemGroup <- ::TLW.EnemyMut.Only(::TLW.EnemyMut.Unhold,::TLW.EnemyMut.Orc,::TLW.EnemyMut.Ghost,::TLW.EnemyMut.Ghoul,::TLW.EnemyMut.Basilisk,::TLW.EnemyMut.Hexe);
/*
Mutations References (with typical use tags (range,class,area))
Tank = + Survivability (Hp,Armor,Def,Resistance,etc.)
Dmg = + Damage Potential (direct or indirect)
Supp = + Utility (Effects, Buffs/Debuffs)

	1:	unhold 		(all,		tank,		north)
    2:	vampire 	(melee,		tank,		all)
    3: 	spider 		(all,		supp,		all)
    4: 	orc 		(melee,		dmg,		all)
    5: 	lindwurm 	(melee,		supp,		all)
    6: 	sandgolem 	(all,		tank,		south)
    7: 	ghost 		(all,		dmg,		all)
    8: 	serpent 	(all,		tank,		south)
    9: 	ghoul 		(melee,		dmg,		all)
    10: basilisk 	(all,		dmg,		north)
    11: direwolf 	(all,		"tank",		all)
    12: goblin 		(range,		dmg,		all)
    13: schrat 		(all,		tank,		all)
    14: skeleton 	(all,		tank,		all)
    15: alp 		(range/all,	tank,		all)
    16: hexe 		(all,		dmg/supp,	all)

How to Call em above

    ::TLW.EnemyMut.Unhold
	::TLW.EnemyMut.Vampire
	::TLW.EnemyMut.Spider
	::TLW.EnemyMut.Orc
	::TLW.EnemyMut.Lindwurm
	::TLW.EnemyMut.Sandgolem
	::TLW.EnemyMut.Ghost
	::TLW.EnemyMut.Serpent
	::TLW.EnemyMut.Ghoul
	::TLW.EnemyMut.Basilisk
	::TLW.EnemyMut.Direwolf
	::TLW.EnemyMut.Goblin
	::TLW.EnemyMut.Schrat
	::TLW.EnemyMut.Skeleton
	::TLW.EnemyMut.Alp
	::TLW.EnemyMut.Hexe

Typical Combos

    Full Tank: [1, 6, 8, 13, 14, 15, 16] (kinda like the "base" effects too)
    Ranged: [1, 3, 6, 8, 10, 11, 12, 13, 14, 15, 16]
    Melee: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16]
    Weak Swarm: [1, 3, 4, 5, 6, 8, 9, 13, 14, 15, 16] (tank/melee combo)

*/