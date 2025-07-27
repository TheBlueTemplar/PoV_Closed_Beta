// New System
::TLW.CorpseDrop <-
{
	getCorpseDrop = function (_actor, _corpse)
	{
		local chance = _corpse.BaseDropChance;
		local difficultyModifier = [1.15, 1.05, 1, 0.85][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;
		//chance = 100; //For Testing Only

		::TLW.Mod.Debug.printLog("Rolling for Corpse || Chance: " + chance);
		return [chance, _corpse.Script];
	}
}