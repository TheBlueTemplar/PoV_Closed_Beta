// Necro's stuff, study it
mod_PoV.Hooks.MainMenuScreen_notifyBackendOnShown = MainMenuScreen.prototype.notifyBackendOnShown;
MainMenuScreen.prototype.notifyBackendOnShown = function () {
    this.mOriginalBackgroundUrl = this.mBackgroundImage.attr("src");
    this.updatePOVBackgroundImage(true);
    mod_PoV.Hooks.MainMenuScreen_notifyBackendOnShown.call(this);
}

MainMenuScreen.prototype.updatePOVBackgroundImage = function (_isShow) {
    if (_isShow) {
        this.mBackgroundImage.attr("src", Path.GFX + "ui/screens/pov_title.png");
    } else if (this.mOriginalBackgroundUrl !== null && this.mOriginalBackgroundUrl !== undefined) {
        this.mBackgroundImage.attr("src", this.mOriginalBackgroundUrl);
    }
}

// Old Shet
/*mod_PoV.Hooks.MainMenuScreen_show = MainMenuScreen.prototype.show;
MainMenuScreen.prototype.show = function (_animate)
{
	mod_PoV.Hooks.MainMenuScreen_show.call(this, _animate);
    this.mBackgroundImage.attr("src", Path.GFX + "ui/screens/pov_title.png");
}*/
 

// Function I'm Hooking

/*MainMenuScreen.prototype.show = function (_animate) {
  this.mMainMenuModule.showMainMenu(false);

  var bg = ["08", "09", "10", "11"];

  this.mBackgroundImage.attr("src", Path.GFX + "ui/screens/rotu_title.png");
  this.mContainer.removeClass("display-none").addClass("display-block");

  if (_animate) {
    /*this.mBackgroundImage.velocity("finish", true).velocity({ scaleX: 1.3, scaleY: 1.3, translateX: 200.0, translateY: 50.0 },
		{
			duration: 0
		}).velocity("finish", true).velocity({ scaleX: 1.0, scaleY: 1.0, translateX: 0.0, translateY: 0.0 },
		{
			duration: 25000,
			easing: 'ease-out'
		});
  }

  this.notifyBackendOnShown();
};*/
