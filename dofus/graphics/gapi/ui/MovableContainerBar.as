class dofus.graphics.gapi.ui.MovableContainerBar extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MovableContainerBar";
	function MovableContainerBar()
	{
		super();
	}
	function __get__containers()
	{
		return this._aContainers;
	}
	function __get__size()
	{
		return this._nContainerNumber;
	}
	function __set__size(loc2)
	{
		if(loc2 < 0)
		{
			loc2 = 0;
		}
		if(loc2 > this._nMaxContainer)
		{
			loc2 = this._nMaxContainer;
		}
		if(loc2 != this._nContainerNumber)
		{
			this._nContainerNumber = loc2;
			this.move(this._x,this._y,true);
		}
		return this.__get__size();
	}
	function __get__maxContainer()
	{
		return this._nMaxContainer;
	}
	function __set__maxContainer(loc2)
	{
		this._nMaxContainer = loc2;
		if(this._nContainerNumber > loc2)
		{
			this.size = loc2;
		}
		return this.__get__maxContainer();
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
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MovableContainerBar.CLASS_NAME);
		this._nContainerNumber = 1;
		this._nMaxContainer = 5;
		this._bVertical = false;
		this._oBounds = {left:0,top:0,right:800,bottom:600};
		this._nSnap = 20;
		this._nOffsetX = 0;
		this._nOffsetY = 0;
	}
	function createChildren()
	{
		Mouse.addListener(this);
		this._mcDragOne.onPress = this._mcDragTwo.onPress = function()
		{
			if(this._parent._bTimerEnable != true)
			{
				this._parent.onMouseMove = this._parent._onMouseMove;
				this._parent._nOffsetX = _root._xmouse - this._parent._x;
				this._parent._nOffsetY = _root._ymouse - this._parent._y;
			}
		};
		this._mcDragOne.onRelease = this._mcDragOne.onReleaseOutside = this._mcDragTwo.onRelease = this._mcDragTwo.onReleaseOutside = function()
		{
			if(this._parent._bTimerEnable != true)
			{
				this._parent.onMouseMove = undefined;
				this._parent._nOffsetX = 0;
				this._parent._nOffsetY = 0;
				this._parent.dispatchEvent({type:"drop"});
				this._parent._bTimerEnable = true;
				ank.utils.Timer.setTimer(this._parent,"movablecontainerbar",this._parent,this._parent.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY);
			}
			else
			{
				this._parent.onClickTimer();
				this._parent.dispatchEvent({type:"dblClick"});
			}
		};
		this._mcBackground.onRelease = function()
		{
		};
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function drawBar()
	{
		this._aContainers = new Array();
		this._mcContainers = this.createEmptyMovieClip("_mcContainers",1);
		var loc2 = new Object();
		loc2.backgroundRenderer = "UI_BannerContainerBackground";
		loc2.borderRenderer = "UI_BannerContainerBorder";
		loc2.dragAndDrop = true;
		loc2.enabled = true;
		loc2.highlightFront = true;
		loc2.highlightRenderer = "UI_BannerContainerHighLight";
		loc2.margin = 1;
		loc2.showLabel = false;
		loc2.styleName = "InventoryGridContainer";
		switch(this._bVertical)
		{
			case true:
				this._mcDragOne._x = 3;
				this._mcDragOne._y = 3;
				this._mcDragTwo._x = 3;
				this._mcDragTwo._y = 18 + this._nContainerNumber * (25 + 3);
				this._mcDragTwo._width = loc0 = 25;
				this._mcDragOne._width = loc0;
				this._mcDragTwo._height = loc0 = 12;
				this._mcDragOne._height = loc0;
				this._mcDragOne.styleName = "VerticalDragOneMovableBarStylizedRectangle";
				this._mcDragTwo.styleName = "VerticalDragTwoMovableBarStylizedRectangle";
				this._mcContainers._x = 3;
				this._mcContainers._y = 18;
				var loc3 = 0;
				while(loc3 < this._nContainerNumber)
				{
					loc2._y = (25 + 3) * loc3;
					var loc4 = this._mcContainers.attachMovie("Container","_ctr" + loc3,loc3,loc2);
					loc4.setSize(25,25);
					this._aContainers.push(loc4);
					loc3 = loc3 + 1;
				}
				this._mcBackground.setSize(31,33 + this._nContainerNumber * (25 + 3));
				break;
			case false:
				this._mcDragOne._x = 3;
				this._mcDragOne._y = 3;
				this._mcDragTwo._x = 18 + this._nContainerNumber * (25 + 3);
				this._mcDragTwo._y = 3;
				this._mcDragTwo._width = loc0 = 12;
				this._mcDragOne._width = loc0;
				this._mcDragTwo._height = loc0 = 25;
				this._mcDragOne._height = loc0;
				this._mcDragOne.styleName = "HorizontalDragOneMovableBarStylizedRectangle";
				this._mcDragTwo.styleName = "HorizontalDragTwoMovableBarStylizedRectangle";
				this._mcContainers._x = 18;
				this._mcContainers._y = 3;
				var loc5 = 0;
				while(loc5 < this._nContainerNumber)
				{
					loc2._x = (25 + 3) * loc5;
					var loc6 = this._mcContainers.attachMovie("Container","_ctr" + loc5,loc5,loc2);
					loc6.setSize(25,25);
					this._aContainers.push(loc6);
					loc5 = loc5 + 1;
				}
				this._mcBackground.setSize(33 + this._nContainerNumber * (25 + 3),31);
		}
		this.dispatchEvent({type:"drawBar"});
	}
	function autoDetectBarOrientation(loc2, loc3)
	{
		var loc4 = loc3 - this._oBounds.top;
		var loc5 = this._oBounds.bottom - loc3;
		var loc6 = loc2 - this._oBounds.left;
		var loc7 = this._oBounds.right - loc2;
		var loc8 = this._bVertical;
		var loc9 = 1000000;
		if(loc4 < this._nSnap)
		{
			if(loc4 < loc9)
			{
				loc9 = loc4;
				loc8 = false;
			}
		}
		if(loc5 < this._nSnap)
		{
			if(loc5 < loc9)
			{
				loc9 = loc5;
				loc8 = false;
			}
		}
		if(loc6 < this._nSnap)
		{
			if(loc6 < loc9)
			{
				loc9 = loc6;
				loc8 = true;
			}
		}
		if(loc7 < this._nSnap)
		{
			if(loc7 < loc9)
			{
				loc9 = loc7;
				loc8 = true;
			}
		}
		if(loc8 != undefined && this._bVertical != loc8)
		{
			this._bVertical = loc8;
			return true;
		}
		return false;
	}
	function snapBar()
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
	function destroy()
	{
		Mouse.removeListener(this);
	}
	function move(loc2, loc3, loc4)
	{
		if(this.autoDetectBarOrientation(loc2,loc3) || loc4)
		{
			this.drawBar();
		}
		this._x = loc2;
		this._y = loc3;
		this.snapBar();
	}
	function setOptions(loc2, loc3, loc4, loc5, loc6)
	{
		this._nMaxContainer = loc2;
		this._nSnap = loc3;
		this._oBounds = loc4;
		this._nContainerNumber = loc5;
		this.move(loc6.x,loc6.y,true);
	}
	function _onMouseMove()
	{
		this.move(_root._xmouse - this._nOffsetX,_root._ymouse - this._nOffsetY);
	}
	function onClickTimer()
	{
		ank.utils.Timer.removeTimer(this,"movablecontainerbar");
		this._bTimerEnable = false;
	}
	function onShortcut(loc2)
	{
		var loc3 = 0;
		while(loc3 < this._nContainerNumber)
		{
			if(loc2 == "MOVABLEBAR_SH" + loc3)
			{
				this._aContainers[loc3].notInChat = true;
				this._aContainers[loc3].emulateClick();
				return false;
			}
			loc3 = loc3 + 1;
		}
		return true;
	}
}
