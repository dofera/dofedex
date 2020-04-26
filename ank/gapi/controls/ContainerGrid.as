class ank.gapi.controls.ContainerGrid extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ContainerGrid";
	var _nVisibleRowCount = 3;
	var _nVisibleColumnCount = 3;
	var _nRowCount = 1;
	var _bInvalidateLayout = false;
	var _bScrollBar = true;
	var _bSelectable = true;
	var _nScrollPosition = 0;
	var _nStyleMargin = 0;
	function ContainerGrid()
	{
		super();
	}
	function __set__selectable(loc2)
	{
		this._bSelectable = loc2;
		return this.__get__selectable();
	}
	function __get__selectable()
	{
		return this._bSelectable;
	}
	function __set__visibleRowCount(loc2)
	{
		this._nVisibleRowCount = loc2;
		return this.__get__visibleRowCount();
	}
	function __get__visibleRowCount()
	{
		return this._nVisibleRowCount;
	}
	function __set__visibleColumnCount(loc2)
	{
		this._nVisibleColumnCount = loc2;
		return this.__get__visibleColumnCount();
	}
	function __get__visibleColumnCount()
	{
		return this._nVisibleColumnCount;
	}
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider = loc2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		var loc3 = this.getMaxRow();
		if(this._nScrollPosition > loc3)
		{
			this.setVPosition(loc3);
		}
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._eaDataProvider;
	}
	function __set__selectedIndex(loc2)
	{
		this.setSelectedItem(loc2);
		return this.__get__selectedIndex();
	}
	function __get__selectedIndex()
	{
		return this._nSelectedIndex;
	}
	function __get__selectedItem()
	{
		return this._mcScrollContent["c" + this._nSelectedIndex];
	}
	function __set__scrollBar(loc2)
	{
		this._bScrollBar = loc2;
		return this.__get__scrollBar();
	}
	function __get__scrollBar()
	{
		return this._bScrollBar;
	}
	function setVPosition(loc2)
	{
		var loc3 = this.getMaxRow();
		if(loc2 > loc3)
		{
			loc2 = loc3;
		}
		if(loc2 < 0)
		{
			loc2 = 0;
		}
		if(this._nScrollPosition != loc2)
		{
			this._nScrollPosition = loc2;
			this.setScrollBarProperties();
			var loc4 = this.__height / this._nVisibleRowCount;
			this.layoutContent();
		}
	}
	function getContainer(loc2)
	{
		return (ank.gapi.controls.Container)this._mcScrollContent["c" + loc2];
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ContainerGrid.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcScrollContent",10);
		this.createEmptyMovieClip("_mcMask",20);
		this.drawRoundRect(this._mcMask,0,0,1,1,0,0);
		this._mcScrollContent.setMask(this._mcMask);
		if(this._bScrollBar)
		{
			this.attachMovie("ScrollBar","_sbVertical",30);
			this._sbVertical.addEventListener("scroll",this);
		}
		ank.utils.MouseEvents.addListener(this);
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		if(this._bScrollBar)
		{
			this._sbVertical.setSize(this.__height);
			this._sbVertical.move(this.__width - this._sbVertical.width,0);
		}
		this._mcMask._width = this.__width - (!this._bScrollBar?0:this._sbVertical.width);
		this._mcMask._height = this.__height;
		this.setScrollBarProperties();
		this._bInvalidateLayout = this._bInitialized;
		this.layoutContent();
	}
	function layoutContent()
	{
		var loc2 = (this.__width - (!this._bScrollBar?0:this._sbVertical.width)) / this._nVisibleColumnCount;
		var loc3 = this.__height / this._nVisibleRowCount;
		var loc4 = 0;
		if(!this._bInvalidateLayout)
		{
			var loc5 = 0;
			while(loc5 < this._nVisibleRowCount)
			{
				var loc6 = 0;
				while(loc6 < this._nVisibleColumnCount)
				{
					var loc7 = this._mcScrollContent["c" + loc4];
					if(loc7 == undefined)
					{
						loc7 = (ank.gapi.controls.Container)this._mcScrollContent.attachMovie("Container","c" + loc4,loc4,{margin:this._nStyleMargin});
						loc7.addEventListener("drag",this);
						loc7.addEventListener("drop",this);
						loc7.addEventListener("over",this);
						loc7.addEventListener("out",this);
						loc7.addEventListener("click",this);
						loc7.addEventListener("dblClick",this);
					}
					loc7._x = loc2 * loc6;
					loc7._y = loc3 * loc5;
					loc7.setSize(loc2,loc3);
					loc4 = loc4 + 1;
					loc6 = loc6 + 1;
				}
				loc5 = loc5 + 1;
			}
		}
		var loc8 = 0;
		loc4 = this._nScrollPosition * this._nVisibleColumnCount;
		var loc9 = 0;
		while(loc9 < this._nVisibleRowCount)
		{
			var loc10 = 0;
			while(loc10 < this._nVisibleColumnCount)
			{
				var loc11 = this._mcScrollContent["c" + loc8];
				loc11.showLabel = this._eaDataProvider[loc4].label != undefined && this._eaDataProvider[loc4].label > 0;
				loc11.contentData = this._eaDataProvider[loc4];
				loc11.id = loc4;
				if(loc4 == this._nSelectedIndex)
				{
					loc11.selected = true;
				}
				else
				{
					loc11.selected = false;
				}
				loc11.enabled = this._bEnabled;
				loc4 = loc4 + 1;
				loc8 = loc8 + 1;
				loc10 = loc10 + 1;
			}
			loc9 = loc9 + 1;
		}
		if(this._bInvalidateLayout)
		{
		}
		this._bInvalidateLayout = false;
	}
	function draw()
	{
		this._bInvalidateLayout = !this._bInitialized;
		this.layoutContent();
		var loc2 = this.getStyle();
		var loc3 = loc2.containerbackground;
		var loc4 = loc2.containerborder;
		var loc5 = loc2.containerhighlight;
		this._nStyleMargin = loc2.containermargin;
		for(var loc6 in this._mcScrollContent)
		{
			loc6.backgroundRenderer = loc3;
			loc6.borderRenderer = loc4;
			loc6.highlightRenderer = loc5;
			loc6.margin = this._nStyleMargin;
			loc6.styleName = loc2.containerstyle;
		}
		if(this._bScrollBar)
		{
			this._sbVertical.styleName = loc2.scrollbarstyle;
		}
	}
	function setEnabled()
	{
		for(this._mcScrollContent[k].enabled in this._mcScrollContent)
		{
		}
		this.addToQueue({object:this,method:function()
		{
			this._sbVertical.enabled = this._bEnabled;
		}});
	}
	function getMaxRow()
	{
		return Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount) - this._nVisibleRowCount;
	}
	function setScrollBarProperties()
	{
		var loc2 = this._nRowCount - this._nVisibleRowCount;
		var loc3 = this._nVisibleRowCount * (loc2 / this._nRowCount);
		this._sbVertical.setScrollProperties(loc3,0,loc2);
		this._sbVertical.scrollPosition = this._nScrollPosition;
	}
	function getItemById(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < this._nVisibleRowCount)
		{
			var loc6 = 0;
			while(loc6 < this._nVisibleColumnCount)
			{
				var loc7 = this._mcScrollContent["c" + loc3];
				if(loc2 == loc7.id)
				{
					return loc7;
				}
				loc3 = loc3 + 1;
				loc6 = loc6 + 1;
			}
			loc5 = loc5 + 1;
		}
	}
	function setSelectedItem(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < this._nVisibleRowCount)
		{
			var loc6 = 0;
			while(loc6 < this._nVisibleColumnCount)
			{
				var loc7 = this._mcScrollContent["c" + loc3];
				if(loc2 == loc7.id)
				{
					loc2 = loc3;
					loc4 = loc7.id;
				}
				loc3 = loc3 + 1;
				loc6 = loc6 + 1;
			}
			loc5 = loc5 + 1;
		}
		if(this._nSelectedIndex != loc4)
		{
			var loc8 = this.getItemById(this._nSelectedIndex);
			var loc9 = this._mcScrollContent["c" + loc2];
			if(loc9.contentData == undefined)
			{
				return undefined;
			}
			loc8.selected = false;
			loc9.selected = true;
			this._nSelectedIndex = loc4;
		}
	}
	function modelChanged(loc2)
	{
		var loc3 = this._nRowCount;
		this._nRowCount = Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount);
		this._bInvalidateLayout = true;
		this.layoutContent();
		this.draw();
		this.setScrollBarProperties();
	}
	function scroll(loc2)
	{
		this.setVPosition(loc2.target.scrollPosition);
	}
	function drag(loc2)
	{
		this.dispatchEvent({type:"dragItem",target:loc2.target});
	}
	function drop(loc2)
	{
		this.dispatchEvent({type:"dropItem",target:loc2.target});
	}
	function over(loc2)
	{
		this.dispatchEvent({type:"overItem",target:loc2.target});
	}
	function out(loc2)
	{
		this.dispatchEvent({type:"outItem",target:loc2.target});
	}
	function click(loc2)
	{
		if(this._bSelectable)
		{
			this.setSelectedItem(loc2.target.id);
		}
		this.dispatchEvent({type:"selectItem",target:loc2.target,owner:this});
	}
	function dblClick(loc2)
	{
		this.dispatchEvent({type:"dblClickItem",target:loc2.target,owner:this});
	}
	function onMouseWheel(loc2, loc3)
	{
		if(String(loc3._target).indexOf(this._target) != -1)
		{
			this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - (loc2 <= 0?-1:1);
		}
	}
}
