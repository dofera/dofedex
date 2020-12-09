class dofus.graphics.gapi.controls.Helper extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Helper";
	static var SINGLETON_INSTANCE = null;
	static var MAX_STARS_DISPLAYED = 5;
	function Helper()
	{
		super();
	}
	static function getCurrentHelper()
	{
		if(dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE == null || !(dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE instanceof dofus.graphics.gapi.controls.Helper))
		{
			var var2 = _global.API.ui.getUIComponent("Banner");
			if(var2 == undefined)
			{
				return null;
			}
			var var3 = var2.showCircleXtra("helper",true);
			return var3.content;
		}
		return dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.Helper.CLASS_NAME);
		dofus.graphics.gapi.controls.Helper.SINGLETON_INSTANCE = this;
		this._aAnimationQueue = new Array();
		this.addAnimationToQueue("show");
	}
	function createChildren()
	{
		this.hideAllStars();
	}
	function hideAllStars()
	{
		this.showStars(0);
	}
	function showStars(§\x07\b§)
	{
		var var3 = 0;
		while(var3 < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
		{
			this.getStar(var3 + 1)._visible = var2 > var3;
			var3 = var3 + 1;
		}
		this._nStarsDisplayed = var2;
	}
	function getStar(§\x05\x02§)
	{
		return this["_mcStar" + var2];
	}
	function addStar()
	{
		if(this._nStarsDisplayed < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
		{
			this.showStars(this._nStarsDisplayed + 1);
		}
	}
	function removeStar()
	{
		if(this._nStarsDisplayed > 0)
		{
			this.showStars(this._nStarsDisplayed - 1);
		}
	}
	function addAnimationToQueue(§\x1e\x15\x04§)
	{
		this._aAnimationQueue.push(var2);
		if(!this._bIsPlaying)
		{
			this.playNextAnimation();
		}
	}
	function playNextAnimation()
	{
		if(this._aAnimationQueue.length > 0)
		{
			var var2 = String(this._aAnimationQueue.shift());
			this._sLastAnimation = var2;
			this._mcBoon.gotoAndPlay(var2);
		}
		else
		{
			if((var var0 = this._sLastAnimation) === "hide")
			{
				var var3 = _global.API.ui.getUIComponent("Banner");
				var3.showCircleXtra("artwork",true,{bMask:true});
			}
			this._mcBoon.gotoAndStop("static");
		}
	}
	function onNewTip()
	{
		this.addStar();
		this.addAnimationToQueue("wave");
	}
	function onRemoveTip()
	{
		this.removeStar();
		if(this._nStarsDisplayed <= 0)
		{
			this._nStarsDisplayed = 0;
			this.addAnimationToQueue("hide");
		}
	}
	function onAnimationEnd()
	{
		this.playNextAnimation();
	}
}
