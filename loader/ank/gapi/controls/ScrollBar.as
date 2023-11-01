class ank.gapi.controls.ScrollBar extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ScrollBar";
	static var SCROLL_INTERVAL = 40;
	function ScrollBar()
	{
		super();
	}
	function __set__min(var2)
	{
		this._nMin = var2;
		return this.__get__min();
	}
	function __get__min()
	{
		return this._nMin;
	}
	function __set__max(var2)
	{
		this._nMax = var2;
		return this.__get__max();
	}
	function __get__max()
	{
		return this._nMax;
	}
	function __set__page(var2)
	{
		this._nPage = var2;
		return this.__get__page();
	}
	function __get__page()
	{
		return this._nPage;
	}
	function __set__scrollTarget(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		this._tTarget = typeof var2 != "string"?var2:this._parent[var2];
		if(this.addEventListener != undefined)
		{
			this.addTargetListener();
		}
		this._tTarget.removeListener(this);
		this._tTarget.addListener(this);
		this.addToQueue({object:this,method:this.addTargetListener});
		if(this._sSnapTo != undefined && this._sSnapTo != "none")
		{
			this.addToQueue({object:this,method:this.snapToTextField});
		}
		return this.__get__scrollTarget();
	}
	function __get__scrollTarget()
	{
		return this._tTarget;
	}
	function __set__snapTo(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		this._sSnapTo = var2;
		if(this._tTarget != undefined)
		{
			if(this.addEventListener != undefined)
			{
				this.snapToTextField();
			}
			else
			{
				this.addToQueue({object:this,method:this.snapToTextField});
			}
		}
		return this.__get__snapTo();
	}
	function __set__scrollPosition(var2)
	{
		if(var2 > this._nMax)
		{
			var2 = this._nMax;
		}
		if(var2 < this._nMin)
		{
			var2 = this._nMin;
		}
		var var3 = var2 * (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) / (this._nMax - this._nMin) + this._mcHolder.track_mc._y;
		this.moveThumb(var3);
		return this.__get__scrollPosition();
	}
	function __get__scrollPosition()
	{
		return Math.round((this._mcHolder.thumb_mc._y - this._mcHolder.track_mc._y) / (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) * (this._nMax - this._nMin));
	}
	function __set__horizontal(var2)
	{
		this._bHorizontal = var2;
		this.arrange();
		return this.__get__horizontal();
	}
	function setSize(var2)
	{
		super.setSize(null,var3);
	}
	function setScrollProperties(var2, var3, var4)
	{
		this._nPage = var2;
		this._nMin = Math.max(var3,0);
		this._nMax = Math.max(var4,0);
		this.resizeThumb();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ScrollBar.CLASS_NAME);
		if(this._nMin == undefined)
		{
			this._nMin = 0;
		}
		if(this._nMax == undefined)
		{
			this._nMax = 100;
		}
		if(this._nPage == undefined)
		{
			this._nPage = 10;
		}
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcHolder",10);
		var var2 = this._mcHolder.attachMovie("ScrollBarTrack","track_mc",10);
		var var3 = this._mcHolder.attachMovie("ScrollBarUpArrow","upArrow_mc",20);
		var var4 = this._mcHolder.attachMovie("ScrollBarDownArrow","downArrow_mc",30);
		var var5 = this._mcHolder.attachMovie("ScrollBarThumb","thumb_mc",40);
		var3.onRollOver = var4.onRollOver = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = true;
			this.down_mc._visible = false;
		};
		var3.onRollOut = var4.onRollOut = function()
		{
			this.up_mc._visible = true;
			this.over_mc._visible = false;
			this.down_mc._visible = false;
		};
		var3.onPress = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = false;
			this.down_mc._visible = true;
			this.interval = _global.setInterval(this._parent._parent,"addToScrollPosition",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,-1);
		};
		var4.onPress = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = false;
			this.down_mc._visible = true;
			this.interval = _global.setInterval(this._parent._parent,"addToScrollPosition",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,1);
		};
		var3.onRelease = var4.onRelease = function()
		{
			this.onRollOver();
			_global.clearInterval(this.interval);
		};
		var3.onReleaseOutside = var4.onReleaseOutside = function()
		{
			this.onRelease();
			this.onRollOut();
		};
		var5.onRollOver = function()
		{
		};
		var5.onRollOut = function()
		{
		};
		var5.onPress = function()
		{
			this._parent._parent._nDragOffset = - this._ymouse;
			this.dispatchInterval = _global.setInterval(this._parent._parent,"dispatchScrollEvent",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL);
			this.scrollInterval = _global.setInterval(this._parent._parent,"scrollThumb",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,null,true);
		};
		var5.onRelease = function()
		{
			_global.clearInterval(this.scrollInterval);
			_global.clearInterval(this.dispatchInterval);
		};
		var5.onReleaseOutside = function()
		{
			this.onRelease();
			this.onRollOut();
		};
		var2.onPress = function()
		{
			var var2 = this._parent._ymouse;
			var var3 = this._parent._parent._nPage;
			if(var2 < this._parent.thumb_mc._y)
			{
				var3 = - var3;
			}
			this._parent._parent.addToScrollPosition(var3);
		};
	}
	function draw()
	{
		var var2 = this.getStyle();
		var var3 = this._mcHolder.downArrow_mc;
		this.setMovieClipColor(var3.up_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.up_mc.arrow_mc,var2.sbarrowcolor);
		this.setMovieClipColor(var3.down_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.down_mc.arrow_mc,var2.sbarrowcolor);
		this.setMovieClipColor(var3.over_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.over_mc.arrow_mc,var2.sbarrowcolor);
		var3 = this._mcHolder.upArrow_mc;
		this.setMovieClipColor(var3.up_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.up_mc.arrow_mc,var2.sbarrowcolor);
		this.setMovieClipColor(var3.down_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.down_mc.arrow_mc,var2.sbarrowcolor);
		this.setMovieClipColor(var3.over_mc.bg_mc,var2.sbarrowbgcolor);
		this.setMovieClipColor(var3.over_mc.arrow_mc,var2.sbarrowcolor);
		for(var k in this._mcHolder.thumb_mc)
		{
			this.setMovieClipColor(this._mcHolder.thumb_mc[k],var2.sbthumbcolor);
		}
		this.setMovieClipColor(this._mcHolder.track_mc,var2.sbtrackcolor);
	}
	function size()
	{
		super.size();
		this._nSize = this.__height;
		this.arrange();
		if(this.scrollTarget != undefined)
		{
			this.setScrollPropertiesToTarget();
		}
	}
	function arrange()
	{
		if(this._nSize == undefined)
		{
			return undefined;
		}
		if(this._bHorizontal)
		{
			this._rotation = -90;
		}
		this._mcHolder.track_mc._height = Math.max(this._nSize - this._mcHolder.upArrow_mc._height - this._mcHolder.downArrow_mc._height,0);
		this._mcHolder.track_mc._y = this._mcHolder.upArrow_mc._height;
		this._mcHolder.downArrow_mc._y = this._mcHolder.track_mc._y + this._mcHolder.track_mc._height;
		this._mcHolder.thumb_mc._y = this._mcHolder.track_mc._y;
		this.setScrollProperties(this._nPage,this._nMin,this._nMax);
	}
	function resizeThumb()
	{
		if(this._nMax != this._nMin && this._nPage != 0)
		{
			this._mcHolder.thumb_mc.height = Math.min(Math.abs(this._nPage / (this._nMax - this._nMin)),1) * this._mcHolder.track_mc._height;
			this._mcHolder.thumb_mc._y = this._mcHolder.upArrow_mc._height;
			if(this._mcHolder.thumb_mc._height > this._mcHolder.track_mc._height)
			{
				this._mcHolder.thumb_mc._visible = false;
			}
			else
			{
				this._mcHolder.thumb_mc._visible = true;
			}
		}
		else
		{
			this._mcHolder.thumb_mc._visible = false;
		}
	}
	function addToScrollPosition(var2)
	{
		this.scrollPosition = this.scrollPosition + var2;
	}
	function scrollThumb(var2, var3)
	{
		if(var3)
		{
			this.moveThumb(this._mcHolder._ymouse + this._nDragOffset);
		}
		else
		{
			this.moveThumb(this._mcHolder.thumb_mc._y + var2);
		}
		_global.updateAfterEvent();
	}
	function moveThumb(nY)
	{
		this._mcHolder.thumb_mc._y = nY;
		if(this._mcHolder.thumb_mc._y < this._mcHolder.upArrow_mc._height)
		{
			this._mcHolder.thumb_mc._y = this._mcHolder.upArrow_mc._height;
		}
		else if(this._mcHolder.thumb_mc._y > this._mcHolder.downArrow_mc._y - this._mcHolder.thumb_mc._height)
		{
			this._mcHolder.thumb_mc._y = this._mcHolder.downArrow_mc._y - this._mcHolder.thumb_mc._height;
		}
		this.dispatchScrollEvent();
	}
	function dispatchScrollEvent()
	{
		if(this._mcHolder.thumb_mc._y != this._nPrevScrollPosition)
		{
			this._nPrevScrollPosition = Math.max(this._mcHolder.upArrow_mc._height,this._mcHolder.thumb_mc._y);
			this.dispatchEvent({type:"scroll",target:this});
		}
	}
	function snapToTextField()
	{
		if(this._sSnapTo == "right")
		{
			this._x = this._tTarget._x + this._tTarget._width - this._width;
			this._y = this._tTarget._y;
			this._tTarget._width = this._tTarget._width - this._width;
			this.height = this._tTarget._height;
			this.setScrollPropertiesToTarget();
		}
	}
	function addTargetListener()
	{
		this.removeEventListener("scroll",this._oListener);
		this._oListener = new Object();
		this._oListener.target = this._tTarget;
		this._oListener.parent = this;
		this._oListener.scroll = function(var2)
		{
			this.target.scroll = this.target.maxscroll * (this.parent.scrollPosition / Math.abs(this.parent._nMax - this.parent._nMin));
		};
		this.addEventListener("scroll",this._oListener);
		this.setScrollPropertiesToTarget();
	}
	function setScrollPropertiesToTarget()
	{
		if(this._tTarget == undefined)
		{
			this.setScrollProperties(this._nPage,this._nMin,this._nMax);
		}
		else
		{
			var var2 = !_global.isNaN(Number(this._tTarget.maxscroll))?this._tTarget.maxscroll:1;
			var var3 = !_global.isNaN(Number(this._tTarget._height))?this._tTarget._height:0;
			var var4 = !_global.isNaN(Number(this._tTarget.textHeight))?this._tTarget.textHeight:1;
			var var5 = 0.9 * var3 / var4 * var2;
			this.setScrollProperties(var5,0,var2);
		}
	}
	function onChanged()
	{
		this.setScrollPropertiesToTarget();
		this.scrollPosition = this._tTarget.scroll;
	}
	function onScroller()
	{
		this.scrollPosition = this._tTarget.scroll;
	}
}
