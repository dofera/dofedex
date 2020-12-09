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
	function __set__size(§\t\x10§)
	{
		if(var2 < 0)
		{
			var2 = 0;
		}
		if(var2 > this._nMaxContainer)
		{
			var2 = this._nMaxContainer;
		}
		if(var2 != this._nContainerNumber)
		{
			this._nContainerNumber = var2;
			this.move(this._x,this._y,true);
		}
		return this.__get__size();
	}
	function __get__maxContainer()
	{
		return this._nMaxContainer;
	}
	function __set__maxContainer(§\t\x10§)
	{
		this._nMaxContainer = var2;
		if(this._nContainerNumber > var2)
		{
			this.size = var2;
		}
		return this.__get__maxContainer();
	}
	function __get__bounds()
	{
		return this._oBounds;
	}
	function __set__bounds(§\x1e\x1a\x1b§)
	{
		this._oBounds = var2;
		return this.__get__bounds();
	}
	function __get__snap()
	{
		return this._nSnap;
	}
	function __set__snap(§\t\x10§)
	{
		this._nSnap = var2;
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
		var var2 = new Object();
		var2.backgroundRenderer = "UI_BannerContainerBackground";
		var2.borderRenderer = "UI_BannerContainerBorder";
		var2.dragAndDrop = true;
		var2.enabled = true;
		var2.highlightFront = true;
		var2.highlightRenderer = "UI_BannerContainerHighLight";
		var2.margin = 1;
		var2.showLabel = false;
		var2.styleName = "InventoryGridContainer";
		switch(this._bVertical)
		{
			case true:
				this._mcDragOne._x = 3;
				this._mcDragOne._y = 3;
				this._mcDragTwo._x = 3;
				this._mcDragTwo._y = 18 + this._nContainerNumber * (25 + 3);
				this._mcDragTwo._width = var0 = 25;
				this._mcDragOne._width = var0;
				this._mcDragTwo._height = var0 = 12;
				this._mcDragOne._height = var0;
				this._mcDragOne.styleName = "VerticalDragOneMovableBarStylizedRectangle";
				this._mcDragTwo.styleName = "VerticalDragTwoMovableBarStylizedRectangle";
				this._mcContainers._x = 3;
				this._mcContainers._y = 18;
				var var3 = 0;
				while(var3 < this._nContainerNumber)
				{
					var2._y = (25 + 3) * var3;
					var var4 = this._mcContainers.attachMovie("Container","_ctr" + var3,var3,var2);
					var4.setSize(25,25);
					this._aContainers.push(var4);
					var3 = var3 + 1;
				}
				this._mcBackground.setSize(31,33 + this._nContainerNumber * (25 + 3));
				break;
			case false:
				this._mcDragOne._x = 3;
				this._mcDragOne._y = 3;
				this._mcDragTwo._x = 18 + this._nContainerNumber * (25 + 3);
				this._mcDragTwo._y = 3;
				this._mcDragTwo._width = var0 = 12;
				this._mcDragOne._width = var0;
				this._mcDragTwo._height = var0 = 25;
				this._mcDragOne._height = var0;
				this._mcDragOne.styleName = "HorizontalDragOneMovableBarStylizedRectangle";
				this._mcDragTwo.styleName = "HorizontalDragTwoMovableBarStylizedRectangle";
				this._mcContainers._x = 18;
				this._mcContainers._y = 3;
				var var5 = 0;
				while(var5 < this._nContainerNumber)
				{
					var2._x = (25 + 3) * var5;
					var var6 = this._mcContainers.attachMovie("Container","_ctr" + var5,var5,var2);
					var6.setSize(25,25);
					this._aContainers.push(var6);
					var5 = var5 + 1;
				}
				this._mcBackground.setSize(33 + this._nContainerNumber * (25 + 3),31);
		}
		this.dispatchEvent({type:"drawBar"});
	}
	function autoDetectBarOrientation(§\x1e\n\x04§, §\x1e\t\x18§)
	{
		var var4 = var3 - this._oBounds.top;
		var var5 = this._oBounds.bottom - var3;
		var var6 = var2 - this._oBounds.left;
		var var7 = this._oBounds.right - var2;
		var var8 = this._bVertical;
		var var9 = 1000000;
		if(var4 < this._nSnap)
		{
			if(var4 < var9)
			{
				var9 = var4;
				var8 = false;
			}
		}
		if(var5 < this._nSnap)
		{
			if(var5 < var9)
			{
				var9 = var5;
				var8 = false;
			}
		}
		if(var6 < this._nSnap)
		{
			if(var6 < var9)
			{
				var9 = var6;
				var8 = true;
			}
		}
		if(var7 < this._nSnap)
		{
			if(var7 < var9)
			{
				var9 = var7;
				var8 = true;
			}
		}
		if(var8 != undefined && this._bVertical != var8)
		{
			this._bVertical = var8;
			return true;
		}
		return false;
	}
	function snapBar()
	{
		var var2 = this._x;
		var var3 = this._y;
		var var4 = this.getBounds();
		var var5 = var3 + var4.yMin - this._oBounds.top;
		var var6 = this._oBounds.bottom - var3 - var4.yMax;
		var var7 = var2 + var4.xMin - this._oBounds.left;
		var var8 = this._oBounds.right - var2 - var4.xMax;
		if(var5 < this._nSnap)
		{
			var3 = this._oBounds.top - var4.yMin;
		}
		if(var6 < this._nSnap)
		{
			var3 = this._oBounds.bottom - var4.yMax;
		}
		if(var7 < this._nSnap)
		{
			var2 = this._oBounds.left - var4.xMin;
		}
		if(var8 < this._nSnap)
		{
			var2 = this._oBounds.right - var4.xMax;
		}
		this._y = var3;
		this._x = var2;
	}
	function destroy()
	{
		Mouse.removeListener(this);
	}
	function move(§\x1e\n\x04§, §\x1e\t\x18§, §\x19\x1c§)
	{
		if(var4 || this.autoDetectBarOrientation(var2,var3))
		{
			this.drawBar();
		}
		this._x = var2;
		this._y = var3;
		this.snapBar();
	}
	function setOptions(§\x0b\x14§, §\x1e\x15\n§, §\x1d\x03§, §\x1e\x11\x1c§, §\x13\x14§)
	{
		this._nMaxContainer = var2;
		this._nSnap = var3;
		this._oBounds = var4;
		this._nContainerNumber = var5;
		if(var6.v != undefined)
		{
			this._bVertical = var6.v;
		}
		this.move(var6.x,var6.y,true);
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
	function onShortcut(§\x1e\x12\x02§)
	{
		var var3 = 0;
		while(var3 < this._nContainerNumber)
		{
			if(var2 == "MOVABLEBAR_SH" + var3)
			{
				this._aContainers[var3].notInChat = true;
				this._aContainers[var3].emulateClick();
				return false;
			}
			var3 = var3 + 1;
		}
		return true;
	}
}
