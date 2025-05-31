mod_PoV.Hooks.NewCampaignMenuModule_createDIV = NewCampaignMenuModule.prototype.createDIV;
NewCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
	mod_PoV.Hooks.NewCampaignMenuModule_createDIV.call(this, _parentDiv);
	this.mDifficultyLegendaryLabel.html('Death March');
}

/*var povCreateDIV = NewCampaignMenuModule.prototype.createDIV; // Note: the var must be unique as the var itself is a global var, you don't want to overwrite something from other mods
NewCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
povCreateDIV.call(this, _parentDiv); // to call the original
this.mDifficultyLegendaryLabel.html('Your new name')
}*/
