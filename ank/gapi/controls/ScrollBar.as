class ank.gapi.controls.ScrollBar extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ScrollBar";
	static var SCROLL_INTERVAL = 40;
	function ScrollBar()
	{
		super();
	}
	function __set__min(loc2)
	{
		this._nMin = loc2;
		return this.__get__min();
	}
	function __get__min()
	{
		return this._nMin;
	}
	function __set__max(loc2)
	{
		this._nMax = loc2;
		return this.__get__max();
	}
	function __get__max()
	{
		return this._nMax;
	}
	function __set__page(loc2)
	{
		this._nPage = loc2;
		return this.__get__page();
	}
	function __get__page()
	{
		return this._nPage;
	}
	function __set__scrollTarget(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this._tTarget = typeof loc2 != "string"?loc2:this._parent[loc2];
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
	function __set__snapTo(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this._sSnapTo = loc2;
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
	function __set__scrollPosition(loc2)
	{
		if(loc2 > this._nMax)
		{
			loc2 = this._nMax;
		}
		if(loc2 < this._nMin)
		{
			loc2 = this._nMin;
		}
		var loc3 = loc2 * (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) / (this._nMax - this._nMin) + this._mcHolder.track_mc._y;
		this.moveThumb(loc3);
		return this.__get__scrollPosition();
	}
	function __get__scrollPosition()
	{
		return Math.round((this._mcHolder.thumb_mc._y - this._mcHolder.track_mc._y) / (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) * (this._nMax - this._nMin));
	}
	function __set__horizontal(loc2)
	{
		this._bHorizontal = loc2;
		this.arrange();
		return this.__get__horizontal();
	}
	function setSize(loc2)
	{
		super.setSize(null,loc3);
	}
	function setScrollProperties(loc2, loc3, loc4)
	{
		this._nPage = loc2;
		this._nMin = Math.max(loc3,0);
		this._nMax = Math.max(loc4,0);
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
		var loc2 = this._mcHolder.attachMovie("ScrollBarTrack","track_mc",10);
		var loc3 = this._mcHolder.attachMovie("ScrollBarUpArrow","upArrow_mc",20);
		var loc4 = this._mcHolder.attachMovie("ScrollBarDownArrow","downArrow_mc",30);
		var loc5 = this._mcHolder.attachMovie("ScrollBarThumb","thumb_mc",40);
		loc3.onRollOver = loc4.onRollOver = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = true;
			this.down_mc._visible = false;
		};
		loc3.onRollOut = loc4.onRollOut = function()
		{
			this.up_mc._visible = true;
			this.over_mc._visible = false;
			this.down_mc._visible = false;
		};
		loc3.onPress = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = false;
			this.down_mc._visible = true;
			this.interval = _global.setInterval(this._parent._parent,"addToScrollPosition",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,-1);
		};
		loc4.onPress = function()
		{
			this.up_mc._visible = false;
			this.over_mc._visible = false;
			this.down_mc._visible = true;
			this.interval = _global.setInterval(this._parent._parent,"addToScrollPosition",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,1);
		};
		loc3.onRelease = loc4.onRelease = function()
		{
			this.onRollOver();
			_global.clearInterval(this.interval);
		};
		loc3.onReleaseOutside = loc4.onReleaseOutside = function()
		{
			this.onRelease();
			this.onRollOut();
		};
		loc5.onRollOver = function()
		{
		};
		loc5.onRollOut = function()
		{
		};
		loc5.onPress = function()
		{
			this._parent._parent._nDragOffset = - this._ymouse;
			this.dispatchInterval = _global.setInterval(this._parent._parent,"dispatchScrollEvent",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL);
			this.scrollInterval = _global.setInterval(this._parent._parent,"scrollThumb",ank.gapi.controls.ScrollBar.SCROLL_INTERVAL,null,true);
		};
		loc5.onRelease = function()
		{
			_global.clearInterval(this.scrollInterval);
			_global.clearInterval(this.dispatchInterval);
		};
		loc5.onReleaseOutside = function()
		{
			this.onRelease();
			this.onRollOut();
		};
		loc2.onPress = function()
		{
			var loc2 = this._parent._ymouse;
			var loc3 = this._parent._parent._nPage;
			if(loc2 < this._parent.thumb_mc._y)
			{
				loc3 = - loc3;
			}
			this._parent._parent.addToScrollPosition(loc3);
		};
	}
	function draw()
	{
		var loc2 = this.getStyle();
		var loc3 = this._mcHolder.downArrow_mc;
		this.setMovieClipColor(loc3.up_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.up_mc.arrow_mc,loc2.sbarrowcolor);
		this.setMovieClipColor(loc3.down_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.down_mc.arrow_mc,loc2.sbarrowcolor);
		this.setMovieClipColor(loc3.over_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.over_mc.arrow_mc,loc2.sbarrowcolor);
		loc3 = this._mcHolder.upArrow_mc;
		this.setMovieClipColor(loc3.up_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.up_mc.arrow_mc,loc2.sbarrowcolor);
		this.setMovieClipColor(loc3.down_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.down_mc.arrow_mc,loc2.sbarrowcolor);
		this.setMovieClipColor(loc3.over_mc.bg_mc,loc2.sbarrowbgcolor);
		this.setMovieClipColor(loc3.over_mc.arrow_mc,loc2.sbarrowcolor);
		for(var k in this._mcHolder.thumb_mc)
		{
			this.setMovieClipColor(this._mcHolder.thumb_mc[k],loc2.sbthumbcolor);
		}
		this.setMovieClipColor(this._mcHolder.track_mc,loc2.sbtrackcolor);
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
	function addToScrollPosition(loc2)
	{
		this.scrollPosition = this.scrollPosition + loc2;
	}
	function scrollThumb(loc2, loc3)
	{
		if(loc3)
		{
			this.moveThumb(this._mcHolder._ymouse + this._nDragOffset);
		}
		else
		{
			this.moveThumb(this._mcHolder.thumb_mc._y + loc2);
		}
		_global.updateAfterEvent();
	}
	function moveThumb(loc2)
	{
		this._mcHolder.thumb_mc._y = loc2;
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
		this._oListener.scroll = function(loc2)
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
			var loc2 = !_global.isNaN(Number(this._tTarget.maxscroll))?this._tTarget.maxscroll:1;
			var loc3 = !_global.isNaN(Number(this._tTarget._height))?this._tTarget._height:0;
			var loc4 = !_global.isNaN(Number(this._tTarget.textHeight))?this._tTarget.textHeight:1;
			var loc5 = 0.9 * loc3 / loc4 * loc2;
			this.setScrollProperties(loc5,0,loc2);
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
