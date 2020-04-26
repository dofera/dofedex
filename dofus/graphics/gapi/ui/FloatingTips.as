class dofus.graphics.gapi.ui.FloatingTips extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "FloatingTips";
	static var MINIMUM_ALPHA_VALUE = 40;
	var _bDraggin = false;
	var _nOffsetX = 0;
	var _nOffsetY = 0;
	function FloatingTips()
	{
		super();
	}
	function __get__bounds()
	{
		return this._oBounds;
	}
	function __set__bounds(loc2)
	{
		this._oBounds = loc2;
		return this.__get__bounds();
	}
	function __get__snap()
	{
		return this._nSnap;
	}
	function __set__snap(loc2)
	{
		this._nSnap = loc2;
		return this.__get__snap();
	}
	function __get__tip()
	{
		return this._nTipID;
	}
	function __set__tip(loc2)
	{
		this._nTipID = loc2;
		this.refreshData();
		return this.__get__tip();
	}
	function __get__position()
	{
		return new com.ankamagames.types.(this._x,this._y);
	}
	function __set__position(loc2)
	{
		this._x = loc2.x;
		this._y = loc2.y;
		return this.__get__position();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.FloatingTips.CLASS_NAME);
		this._oBounds = {left:0,top:0,right:this.gapi.screenWidth,bottom:this.gapi.screenHeight};
		this._nSnap = 20;
	}
	function destroy()
	{
		Mouse.removeListener(this);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.refreshData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._taTipsContent.addEventListener("href",this);
		Mouse.addListener(this);
		this._winBackground.onPress = function()
		{
			myself.drag();
		};
		this._winBackground.onRelease = this._winBackground.onReleaseOutside = function()
		{
			myself.drop();
		};
		this._mcLearnMoreButton.onRelease = function()
		{
			myself.click({target:myself._mcLearnMoreButton});
		};
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("TIPS_WORD");
		this._lblLearnMore.text = this.api.lang.getText("LEARN_MORE");
	}
	function refreshData()
	{
		if(this._taTipsContent.text == undefined)
		{
			return undefined;
		}
		this._taTipsContent.text = "<p class=\'body\'>" + this.api.lang.getKnownledgeBaseTip(this._nTipID).c + "</p>";
	}
	function move(loc2, loc3)
	{
		this._x = loc2;
		this._y = loc3;
		this.snapWindow();
		this.api.kernel.OptionsManager.setOption("FloatingTipsCoord",new com.ankamagames.types.(this._x,this._y));
	}
	function snapWindow()
	{
		var loc2 = this._x;
		var loc3 = this._y;
		var loc4 = this.getBounds();
		var loc5 = loc3 + loc4.yMin - this._oBounds.top;
		var loc6 = this._oBounds.bottom - loc3 - loc4.yMax;
		var loc7 = loc2 + loc4.xMin - this._oBounds.left;
		var loc8 = this._oBounds.right - loc2 - loc4.xMax;
		if(loc5 < this._nSnap)
		{
			loc3 = this._oBounds.top - loc4.yMin;
		}
		if(loc6 < this._nSnap)
		{
			loc3 = this._oBounds.bottom - loc4.yMax;
		}
		if(loc7 < this._nSnap)
		{
			loc2 = this._oBounds.left - loc4.xMin;
		}
		if(loc8 < this._nSnap)
		{
			loc2 = this._oBounds.right - loc4.xMax;
		}
		this._y = loc3;
		this._x = loc2;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
				this.unloadThis();
				break;
			case "_mcLearnMoreButton":
				this.api.ui.loadUIComponent("KnownledgeBase","KnownledgeBase",{article:this.api.lang.getKnownledgeBaseTip(this._nTipID).l});
		}
	}
	function drag()
	{
		this._nOffsetX = _root._xmouse - this._x;
		this._nOffsetY = _root._ymouse - this._y;
		this._bDraggin = true;
	}
	function drop()
	{
		this._bDraggin = false;
	}
	function onMouseMove()
	{
		if(this._bDraggin)
		{
			this.move(_root._xmouse - this._nOffsetX,_root._ymouse - this._nOffsetY);
		}
	}
	function href(loc2)
	{
		this.api.kernel.TipsManager.onLink(loc2);
	}
}
