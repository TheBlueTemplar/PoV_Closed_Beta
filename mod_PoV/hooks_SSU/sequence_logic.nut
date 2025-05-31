local checkSequence = ::Mod_Sellswords.checkSequence;

::Mod_Sellswords.checkSequence = function (_actor, _flag) 
{
    if (_actor.getFlags().getAsInt("pov_ActiveMutations") >= 1)
    {
        _actor.getItems().transferToStash(::World.Assets.getStash());
        _actor.getSkills().onDeath(::Const.FatalityType.Suicide);
        ::Legends.addFallen(_actor, "Died to Conflicting Mutations");
        ::World.getPlayerRoster().remove(_actor);
        return;
    }
    checkSequence(_actor, _flag);
}


// MY METHOD (WRONG)
/*::TLW.HooksMod.hook("mod_sellswords/config/sequence_logic", function(q) {
	// Failed attempt for now
	q.checkSequence = @(__original) function (_actor, _flag)
	{

		if (_actor.getFlags().getAsInt("pov_ActiveMutations") >= 1)
		{
			_actor.getItems().transferToStash(this.World.Assets.getStash());
			_actor.getSkills().onDeath(this.Const.FatalityType.None);
			::Legends.addFallen(_actor, "The Vattghern mutations are not compatible with others. Bro learned this the hard way :(");
			this.World.getPlayerRoster().remove(_actor);
		}

		return __original(_actor, _flag);
	}

});*/