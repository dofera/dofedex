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
			var loc2 = _global.API.ui.getUIComponent("Banner");
			if(loc2 == undefined)
			{
				return null;
			}
			var loc3 = loc2.showCircleXtra("helper",true);
			return loc3.content;
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
	function showStars(nCount)
	{
		var loc3 = 0;
		while(loc3 < dofus.graphics.gapi.controls.Helper.MAX_STARS_DISPLAYED)
		{
			this.getStar(loc3 + 1)._visible = nCount > loc3;
			loc3 = loc3 + 1;
		}
		this._nStarsDisplayed = nCount;
	}
	function getStar(loc2)
	{
		return this["_mcStar" + loc2];
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
	function addAnimationToQueue(loc2)
	{
		this._aAnimationQueue.push(loc2);
		if(!this._bIsPlaying)
		{
			this.playNextAnimation();
		}
	}
	function playNextAnimation()
	{
		if(this._aAnimationQueue.length > 0)
		{
			var loc2 = String(this._aAnimationQueue.shift());
			this._sLastAnimation = loc2;
			this._mcBoon.gotoAndPlay(loc2);
		}
		else
		{
			if((var loc0 = this._sLastAnimation) === "hide")
			{
				var loc3 = _global.API.ui.getUIComponent("Banner");
				loc3.showCircleXtra("artwork",true,{bMask:true});
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
