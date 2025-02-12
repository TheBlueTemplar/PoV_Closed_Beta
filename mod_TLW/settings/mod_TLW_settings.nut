//god bless Taro for this

::TLW.Enemies <-
{
	Alp = {
		Chance = 20.0,
	}
	LegendDemonAlp = {
		Chance = 50.0,
	}
	LegendDemonHound = {
		Chance = 30.0,
	}
	Direwolf = {
		Chance = 15.0,
	}
	LegendWhiteDirewolf = {
		Chance = 30.0,
	}
	Ghost = {
		Chance = 30.0,
	}
	LegendBanshee = {
		Chance = 40.0,
	}
	Ghoul = {
		Chance = 15.0,
	}
	LegendSkinGhoul = {
		Chance = 30.0,
	}
	Goblin = {
		Chance = 15.0,
	}
	GoblinShaman = {
		Chance = 30.0,
	}
	GoblinLeader = {
		Chance = 40.0,
	}
	Hexe = {
		Chance = 30.0,
	}
	LegendHexeLeader = {
		Chance = 50.0,
	}
	Hyena = {
		Chance = 15.0,
	}
	SandGolem = {
		Chance = 20.0,
	}
	Lindwurm = {
		Chance = 80.0,
	}
	LegendStollwurm = {
		Chance = 100.0,
	}
	LegendMummy = {
		Chance = 20.0,
	}
	OrcYoung = {
		Chance = 10.0,
	}
	OrcWarrior = {
		Chance = 20.0,
	}
	OrcBerserker = {
		Chance = 20.0,
	}
	OrcBehemoth = {
		Chance = 40.0,
	}
	OrcWarlord = {
		Chance = 40.0,
	}
	Schrat = {
		Chance = 30.0,
	}
	LegendGreenwoodSchrat = {
		Chance = 50.0,
	}
	Serpent = {
		Chance = 20.0,
	}
	Skeleton = {
		Chance = 15.0,
	}
	SkeletonPriest = {
		Chance = 40.0,
	}
	SkeletonBoss = {
		Chance = 100.0,
	}
	Spider = {
		Chance = 15.0,
	}
	LegendRedbackSpider = {
		Chance = 50.0,
	}
	Unhold = {
		Chance = 25.0,
	}
	UnholdFrost = {
		Chance = 30.0,
	}
	UnholdBog = {
		Chance = 30.0,
	}
	LegendRockUnhold = {
		Chance = 50.0,
	}
	Vampire = {
		Chance = 25.0,
	}
	LegendVampireLord = {
		Chance = 50.0,
	}
	Zombie = {
		Chance = 10.0,
	}
	ZombieKnight = {
		Chance = 25.0,
	}
	ZombieNecromancer = {
		Chance = 25.0,
	}
	BasiliskDrone = {
		Chance = 25.0,
	}
	BasiliskSentry = {
		Chance = 40.0,
	}
};

local settingsPage = ::TLW.Mod.ModSettings.addPage("Corpse Drop Chance");
local keyInc = 0;
local ref = ::TLW.SettingsDefs;
local refStack = [];

local function reduce(_arr, _key) //bruh, implementing functions for outdated libs, hope that new patch will updated them, but i doubt it
{
	if (_arr.len() == 0)
		return _key;
	local ret = "";
	foreach (entry in _arr)
	{
		ret += entry[1] + ".";
	}
	return ret.slice(0, ret.len() - 1) + "." + _key;
}

local createSettings;
createSettings = function(_container) //idk wtf i was doing, but this works, so who am i do judge?
{
	foreach(key, value in _container)
	{
		if (!(key.tostring() in ref))
			continue;
		local keyID =  reduce(refStack, key);
		local keyClosure = key;
		local inner = ref[key.tostring()];
		switch (typeof value){
			case "float":
				local setting = settingsPage.addStringSetting(keyID, value.tostring(), inner.SettingsName, inner.SettingsDescription);
				setting.addAfterChangeCallback(@(_value) _container[keyClosure] = this.getValue().tofloat());
				break;
			case "table":
				settingsPage.addDivider( "divider2_" + keyID);
				settingsPage.addTitle( "section_" + keyID, inner.SettingsName);
				refStack.push([ref, key]);
				ref = inner;
				createSettings(value);
				ref = refStack.pop()[0];
			default:
				break;
		}
	}
}
createSettings(::TLW);
delete ::TLW.SettingsDefs;
refStack = null;