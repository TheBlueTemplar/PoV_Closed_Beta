// New System
::TLW.CorpseDrop <-
{
	getCorpseDrop = function (_actor, _corpse)
	{
		local chance = _corpse.BaseDropChance;
		local difficultyModifier = [1.15, 1, 0.9, 0.8][::World.Assets.getCombatDifficulty()];
		chance *= difficultyModifier;
		//chance = 100; //For Testing Only

		return [chance, _corpse.Script];
	}
}