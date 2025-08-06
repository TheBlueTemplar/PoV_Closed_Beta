::TLW.HooksMod.hook("scripts/ai/tactical/behaviors/ai_charge", function(q) 
{
	q.m.PossibleSkills.extend([
		"actives.pov_charge"
	]);
});