//thanks Emo and Breaky, i stole ur code, sorry!

//::mods_hookExactClass("entity/tactical/enemies/alp", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_alp_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});


::TLW.HooksMod.hook("scripts/entity/tactical/enemies/alp", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_alp_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_demon_alp", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_alp2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_demon_alp", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_alp2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Legend Ghost Dog
//::mods_hookExactClass("entity/tactical/enemies/legend_demon_hound", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_demonhound_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_demon_hound", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_demonhound_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/direwolf", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_direwolf_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/direwolf", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_direwolf_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_white_direwolf", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_direwolf2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_white_direwolf", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_direwolf2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//Gheist
//::mods_hookExactClass("entity/tactical/enemies/ghost", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_ghost_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/ghost", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_ghost_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_banshee", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 40)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_ghost2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_banshee", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_ghost2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//Nachzehrer
//::mods_hookExactClass("entity/tactical/enemies/ghoul", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_ghoul_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/ghoul", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_ghoul_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_skin_ghoul", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_ghoul2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_skin_ghoul", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_ghoul2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Goblin Ambusher, Goblin Skirmisher, all generic
//::mods_hookExactClass("entity/tactical/goblin", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_goblin1_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/goblin", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_goblin1_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/goblin_shaman", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 40)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_goblin2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/goblin_shaman", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_goblin2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Goblin Overseer
//::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_goblin3_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/goblin_leader", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_goblin3_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/hexe", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_hexen_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/hexe", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_hexen_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_hexe_leader", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_hexen2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_hexe_leader", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_hexen2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/hyena", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_hyena_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/hyena", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_hyena_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/sand_golem", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_ifrit_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/sand_golem", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_ifrit_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/lindwurm", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 100)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_lindwurm_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/lindwurm", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_lindwurm_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 100)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_lindwurm2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_stollwurm", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_lindwurm2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//all enbalmed
//::mods_hookExactClass("entity/tactical/legend_mummy", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_mummy_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/legend_mummy", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_mummy_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/orc_young", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_orc_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});


//should do switchcases for those multitype enemies, but im all about absolute low effort
::TLW.HooksMod.hook("scripts/entity/tactical/enemies/orc_young", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_orc_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_orc2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/orc_warrior", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_orc2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});



//::mods_hookExactClass("entity/tactical/enemies/orc_berserker", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_orc2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/orc_berserker", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_orc2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_orc_behemoth", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_orc3_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_orc_behemoth", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_orc3_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/orc_warlord", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_orc3_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/orc_warlord", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_orc3_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/schrat", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_schrat_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/schrat", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_schrat_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/corpse_schrat_item", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_schrat2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_greenwood_schrat", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_schrat2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/serpent", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_serpent_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/serpent", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_serpent_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Ancient Legionary?, Ancient Auxilliary, honor guard, priest
//::mods_hookExactClass("entity/tactical/skeleton", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					if (this.Math.rand(1, 100) <= 30)
//					{
//						loot = this.new("scripts/items/misc/corpse_skeleton_item");
//						loot.drop(_tile);
//					}
//					if (this.isKindOf(this, "skeleton_boss"))
//					{
//						loot = this.new("scripts/items/emperor_skull_item");
//						loot.drop(_tile);
//					}
//
//
//
//					i = ++i;
//				}
//			}
//
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/skeleton", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_skeleton_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//// priest
//::mods_hookExactClass("entity/tactical/enemies/skeleton_priest", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_skeleton3_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_priest", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_skeleton3_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/skeleton", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					if (this.Math.rand(1, 100) <= 30)
//					{
//						loot = this.new("scripts/items/misc/corpse_skeleton_item");
//						loot.drop(_tile);
//					}
//					if (this.isKindOf(this, "skeleton_boss"))
//					{
//						loot = this.new("scripts/items/emperor_skull_item");
//						loot.drop(_tile);
//					}
//
//
//
//					i = ++i;
//				}
//			}
//
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_boss", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/emperor_skull_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/spider", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_spider_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/spider", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_spider_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_redback_spider", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_spider2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_redback_spider", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_spider2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/unhold", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					{
//					if (this.isKindOf(this, "unhold_frost"))
//					{
//						loot = this.new("scripts/items/misc/corpse_unhold2_item");
//					}
//					if (this.isKindOf(this, "unhold_bog"))
//					{
//						loot = this.new("scripts/items/misc/corpse_unhold3_item");
//					}
//					else
//					{
//						loot = this.new("scripts/items/misc/corpse_unhold_item");
//					}
//					}
//
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});


//make switchcase here too
::TLW.HooksMod.hook("scripts/entity/tactical/enemies/unhold", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_unhold_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/unhold_frost", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_unhold2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/unhold_bog", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_unhold3_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/legend_rock_unhold", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_unhold4_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_rock_unhold", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_unhold4_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Necrosavant
//::mods_hookExactClass("entity/tactical/enemies/vampire", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_vampire_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/vampire", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_vampire_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


////Necrosavant
//::mods_hookExactClass("entity/tactical/enemies/legend_vampire_lord", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 50)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_vampire2_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_vampire_lord", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_vampire2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/zombie", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					{
//					if (this.isKindOf(this, "zombie_knight"))
//					{
//						loot = this.new("scripts/items/misc/corpse_zombie2_item");
//					}
//					else
//					{
//						loot = this.new("scripts/items/misc/corpse_zombie_item");
//					}
//					}
//
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});


::TLW.HooksMod.hook("scripts/entity/tactical/enemies/zombie", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_zombie_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/zombie_knight", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_zombie2_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});


//::mods_hookExactClass("entity/tactical/enemies/necromancer", function (o)
//{
//    local onDeath = o.onDeath;
//    o.onDeath = function(_killer, _skill, _tile, _fatalityType)
//    {
//        onDeath(_killer, _skill, _tile, _fatalityType);
//        if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 30)
//			{
//				local n = 1;
//
//				for( local i = 0; i < n; i = i )
//				{
//					local loot;
//					loot = this.new("scripts/items/misc/corpse_necro_item");
//					loot.drop(_tile);
//					i = ++i;
//				}
//			}
//    }
//});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/necromancer", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_necro_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_basilisk_drone", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_basilisk_drone_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_basilisk_drone_low", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_basilisk_drone_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});

::TLW.HooksMod.hook("scripts/entity/tactical/enemies/legend_basilisk_sentry", function ( q )
{

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local item = "scripts/items/misc/corpse_basilisk_sentry_item";
		::TLW.doCorpseDrop(_killer, _tile, item);
	}

});
