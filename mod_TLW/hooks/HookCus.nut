::TLW.getItemPath <- function (item)   // takes item path string as parameter
    {
        local ItemPath = ::TLW.ItemPath;

        foreach(key, value in ItemPath.Path) // iterates over the item path table
        {
            if (value == item) //compares the value of current iteration over the table to the parameter that doCorpseDrop function takes(item path)
            {
                local path = ::TLW.Enemies[key].Chance // forms the desired setting ID by taking the key(those are set accordingly in the defs and item_paths) that corresponds to the checked value
                ::TLW.Mod.Debug.printLog("Found the right key-value pair: " + key + " - " + value)
                ::TLW.Mod.Debug.printLog("Returned setting: " + path)
                return path;
            }
            //this.logInfo("Iterating ItemPath, key-value pair is: " + key + " - " + value) //prints this shit all over the log, not cool, printLog with some flag is better
            ::TLW.Mod.Debug.printLog("Iterating ItemPath, key-value pair is: " + key + " - " + value);
        }
        return null;
    }

::TLW.doCorpseDrop <-  function(_killer, _tile, item) {
    if ((_tile != null && _killer == null) || (_killer != null && _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals))
    {
            local chance = ::TLW.getItemPath(item);
            local rand = this.Math.rand(1.0, 100.0);

            ::TLW.Mod.Debug.printLog("Rolling for corpse: " + rand + " vs " + chance);

            if (rand <= chance)
            {
                local loot = this.new(item);
                loot.drop(_tile);
            }
    }
}