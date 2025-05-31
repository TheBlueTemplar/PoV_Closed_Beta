::TLW.HooksMod.hook("scripts/skills/actives/adrenaline_skill", function ( q ) {

	q.onUse = @(__original) function(_user, _targetTile)
	{
		if (_user.getSkills().hasSkill("effects.pov_pain"))
		{
			_user.getSkills().removeByID("effects.pov_pain");
		}
		__original(_user, _targetTile);
	}
});	

//dont know how this will work with legends' hook, but should be okay, maybe
//bless u pot, used this shet for sth else