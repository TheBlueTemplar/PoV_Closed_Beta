/////////////////////////////////////////////////////////////////////
// 				Author: The Blue Templar & Excalibird		   	   //
// 			Not to be used elsewhere or tampered with, 2025.       //
/////////////////////////////////////////////////////////////////////

::TLW.HooksMod.hook("scripts/items/weapons/weapon", function( q )
{
	q.m.Silver <- false;

	q.setSilvered <- function ()
	{
		this.m.Silver = true;
		local condition_modifier = 0.8;
		this.m.ConditionMax = ::Math.floor(this.m.ConditionMax * condition_modifier);
		this.m.Condition = ::Math.floor(this.m.Condition * condition_modifier);
		this.m.Name = "Silver " + this.m.Name
		this.m.Value = this.m.Value * 1.15;
	}

	q.updateSilvered <- function ()
	{
		this.m.Value = this.m.Value * 1.15
		if (!isNamed() && this.m.Silver) //named(or legendary) check, if not true - we are in a normal weapon and should edit those values, as they get serialized only in named stuff
		{
			local condition_modifier = 0.8
			this.m.ConditionMax = ::Math.floor(this.m.ConditionMax * condition_modifier)
			this.m.Name = "Silver " + this.m.Name
		}
	}

	q.isSilvered <- function ()
	{
		return this.m.Silver;
	}

	q.onSerialize = @(__original) function ( _out )
    {
        __original ( _out );
        _out.writeBool(this.m.Silver);
    }

    q.onDeserialize = @(__original) function ( _in )
    {
    	__original ( _in );
    	this.m.Silver = _in.readBool();
		this.updateSilvered()
    }
});

::TLW.HooksMod.hookTree("scripts/items/weapons/weapon", function( q )
{
	q.getTooltip = @(__original) function ()
	{
  	local result = __original();
  		if (this.m.Silver)
				{
				result.push({
					id = 22,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Deal [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Damage to enemy beasts. Gain [color=" + this.Const.UI.Color.PositiveValue + "]half[/color] of this bonus against Mutants, and the Undead. Also, Deal [color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Damage to enemy humans and other humanoids."
				});
				}
  	return result;
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
	__original( _skill, _targetEntity, _properties )
		if (!this.m.Silver || _targetEntity == null)
			return
		else
        {
			//local faction = this.Const.EntityType.getDefaultFaction(_targetEntity.getType())
            // for anybody reverse engineering this mod, I apologise for this big ass line, but also get fucked idiot >:)
            // Templar here, I am the sad....
			if(this.Const.EntityType.getDefaultFaction(_targetEntity.getType()) == this.Const.FactionType.Beasts)
			{
				_properties.DamageTotalMult *= 1.15;
			}else if(_targetEntity.getFlags().has("undead") || _targetEntity.getFlags().has("mutant"))
			{
				_properties.DamageTotalMult *= 1.08;
			}else
			{
				_properties.DamageTotalMult *= 0.95;
			}
		}
	}
});


