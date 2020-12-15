class ank.gapi.controls.ContainerGrid extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ContainerGrid";
	var _nVisibleRowCount = 3;
	var _nVisibleColumnCount = 3;
	var _nRowCount = 1;
	var _bInvalidateLayout = false;
	var _bScrollBar = true;
	var _bSelectable = true;
	var _bMultiContainerSelection = true;
	var _nScrollPosition = 0;
	var _nStyleMargin = 0;
	function ContainerGrid()
	{
		super();
	}
	function __set__multipleContainerSelectionEnabled(var2)
	{
		this._bMultiContainerSelection = var2;
		return this.__get__multipleContainerSelectionEnabled();
	}
	function __get__multipleContainerSelectionEnabled()
	{
		return this._bMultiContainerSelection;
	}
	function __set__selectable(var2)
	{
		this._bSelectable = var2;
		return this.__get__selectable();
	}
	function __get__selectable()
	{
		return this._bSelectable;
	}
	function __set__visibleRowCount(var2)
	{
		this._nVisibleRowCount = var2;
		return this.__get__visibleRowCount();
	}
	function __get__visibleRowCount()
	{
		return this._nVisibleRowCount;
	}
	function __set__visibleColumnCount(var2)
	{
		this._nVisibleColumnCount = var2;
		return this.__get__visibleColumnCount();
	}
	function __get__visibleColumnCount()
	{
		return this._nVisibleColumnCount;
	}
	function __set__dataProvider(var2)
	{
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		var var3 = this.getMaxRow();
		if(this._nScrollPosition > var3)
		{
			this.setVPosition(var3);
		}
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._eaDataProvider;
	}
	function __set__selectedIndex(var2)
	{
		this.setSelectedItem(var2);
		return this.__get__selectedIndex();
	}
	function __get__selectedIndex()
	{
		return this._aSelectedIndexes[this._aSelectedIndexes.length - 1].index;
	}
	function __get__selectedItem()
	{
		return this._mcScrollContent["c" + this.selectedIndex];
	}
	function __set__scrollBar(var2)
	{
		this._bScrollBar = var2;
		return this.__get__scrollBar();
	}
	function __get__scrollBar()
	{
		return this._bScrollBar;
	}
	function isSelectedIndex(var2)
	{
		var var3 = 0;
		while(var3 < this._aSelectedIndexes.length)
		{
			var var4 = this._aSelectedIndexes[var3].index;
			if(var4 == var2)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function setVPosition(var2)
	{
		var var3 = this.getMaxRow();
		if(var2 > var3)
		{
			var2 = var3;
		}
		if(var2 < 0)
		{
			var2 = 0;
		}
		if(this._nScrollPosition != var2)
		{
			this._nScrollPosition = var2;
			this.setScrollBarProperties();
			var var4 = this.__height / this._nVisibleRowCount;
			this.layoutContent();
		}
	}
	function getContainer(var2)
	{
		return (ank.gapi.controls.Container)this._mcScrollContent["c" + var2];
	}
	function unSelectAll()
	{
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._nVisibleRowCount)
		{
			var var4 = 0;
			while(var4 < this._nVisibleColumnCount)
			{
				var var5 = this._mcScrollContent["c" + var2];
				if(var5.selected)
				{
					var5.selected = false;
				}
				var2 = var2 + 1;
				var4 = var4 + 1;
			}
			var3 = var3 + 1;
		}
		this._aSelectedIndexes = new Array();
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
		this._aSelectedIndexes = new Array();
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
		var var2 = (this.__width - (!this._bScrollBar?0:this._sbVertical.width)) / this._nVisibleColumnCount;
		var var3 = this.__height / this._nVisibleRowCount;
		var var4 = 0;
		if(!this._bInvalidateLayout)
		{
			var var5 = 0;
			while(var5 < this._nVisibleRowCount)
			{
				var var6 = 0;
				while(var6 < this._nVisibleColumnCount)
				{
					var var7 = this._mcScrollContent["c" + var4];
					if(var7 == undefined)
					{
						var7 = (ank.gapi.controls.Container)this._mcScrollContent.attachMovie("Container","c" + var4,var4,{margin:this._nStyleMargin});
						var7.addEventListener("drag",this);
						var7.addEventListener("drop",this);
						var7.addEventListener("over",this);
						var7.addEventListener("out",this);
						var7.addEventListener("click",this);
						var7.addEventListener("dblClick",this);
					}
					var7._x = var2 * var6;
					var7._y = var3 * var5;
					var7.setSize(var2,var3);
					var4 = var4 + 1;
					var6 = var6 + 1;
				}
				var5 = var5 + 1;
			}
		}
		var var8 = 0;
		var4 = this._nScrollPosition * this._nVisibleColumnCount;
		var var9 = 0;
		while(var9 < this._nVisibleRowCount)
		{
			var var10 = 0;
			while(var10 < this._nVisibleColumnCount)
			{
				var var11 = this._mcScrollContent["c" + var8];
				var11.showLabel = this._eaDataProvider[var4].label != undefined && this._eaDataProvider[var4].label > 0;
				var11.contentData = this._eaDataProvider[var4];
				var11.id = var4;
				if(this.isSelectedIndex(var4))
				{
					var11.selected = true;
				}
				else
				{
					var11.selected = false;
				}
				var11.enabled = this._bEnabled;
				var4 = var4 + 1;
				var8 = var8 + 1;
				var10 = var10 + 1;
			}
			var9 = var9 + 1;
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
		var var2 = this.getStyle();
		var var3 = var2.containerbackground;
		var var4 = var2.containerborder;
		var var5 = var2.containerhighlight;
		this._nStyleMargin = var2.containermargin;
		for(var k in this._mcScrollContent)
		{
			var var6 = this._mcScrollContent[k];
			var6.backgroundRenderer = var3;
			var6.borderRenderer = var4;
			var6.highlightRenderer = var5;
			var6.margin = this._nStyleMargin;
			var6.styleName = var2.containerstyle;
		}
		if(this._bScrollBar)
		{
			this._sbVertical.styleName = var2.scrollbarstyle;
		}
	}
	function setEnabled()
	{
		for(var k in this._mcScrollContent)
		{
			this._mcScrollContent[k].enabled = this._bEnabled;
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
		var var2 = this._nRowCount - this._nVisibleRowCount;
		var var3 = this._nVisibleRowCount * (var2 / this._nRowCount);
		this._sbVertical.setScrollProperties(var3,0,var2);
		this._sbVertical.scrollPosition = this._nScrollPosition;
	}
	function getItemById(var2)
	{
		var var3 = 0;
		var var4 = 0;
		var var5 = 0;
		while(var5 < this._nVisibleRowCount)
		{
			var var6 = 0;
			while(var6 < this._nVisibleColumnCount)
			{
				var var7 = this._mcScrollContent["c" + var3];
				if(var2 == var7.id)
				{
					return var7;
				}
				var3 = var3 + 1;
				var6 = var6 + 1;
			}
			var5 = var5 + 1;
		}
	}
	function getSelectedItems()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < this._aSelectedIndexes.length)
		{
			var var4 = this._aSelectedIndexes[var3].item;
			var2.push(var4);
			var3 = var3 + 1;
		}
		var2.reverse();
		return var2;
	}
	function selectContainer(var2)
	{
		var2.selected = true;
		this._aSelectedIndexes.push({index:var2.id,item:var2.contentData});
	}
	function unSelectContainer(var2)
	{
		var2.selected = false;
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aSelectedIndexes.length)
		{
			if(var2.id != this._aSelectedIndexes[var4].index)
			{
				var3.push(this._aSelectedIndexes[var4]);
			}
			var4 = var4 + 1;
		}
		this._aSelectedIndexes = var3;
	}
	function setSelectedItem(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		var var4 = 0;
		var var5 = 0;
		var var6 = 0;
		while(var6 < this._nVisibleRowCount)
		{
			var var7 = 0;
			while(var7 < this._nVisibleColumnCount)
			{
				var var8 = this._mcScrollContent["c" + var4];
				if(var2 == var8.id)
				{
					var2 = var4;
					var5 = var8.id;
				}
				var4 = var4 + 1;
				var7 = var7 + 1;
			}
			var6 = var6 + 1;
		}
		var var9 = this.getItemById(this.selectedIndex);
		var var10 = this._mcScrollContent["c" + var2];
		if(this._bMultiContainerSelection)
		{
			if(!Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY))
			{
				this.unSelectAll();
			}
		}
		else
		{
			this.unSelectContainer(var9);
		}
		if(var10.contentData == undefined)
		{
			return undefined;
		}
		if(var10.selected)
		{
			if(var3)
			{
				return undefined;
			}
			this.unSelectContainer(var10);
			return undefined;
		}
		this.selectContainer(var10);
	}
	function modelChanged(var2)
	{
		this.unSelectAll();
		var var3 = this._nRowCount;
		this._nRowCount = Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount);
		this._bInvalidateLayout = true;
		this.layoutContent();
		this.draw();
		this.setScrollBarProperties();
	}
	function scroll(var2)
	{
		this.setVPosition(var2.target.scrollPosition);
	}
	function drag(var2)
	{
		this.dispatchEvent({type:"dragItem",target:var2.target});
	}
	function drop(var2)
	{
		this.dispatchEvent({type:"dropItem",target:var2.target});
	}
	function over(var2)
	{
		if(this._bSelectable && (this._bMultiContainerSelection && (Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY) && Key.isDown(Key.SHIFT))))
		{
			this.setSelectedItem(var2.target.id,true);
		}
		this.dispatchEvent({type:"overItem",target:var2.target});
	}
	function out(var2)
	{
		this.dispatchEvent({type:"outItem",target:var2.target});
	}
	function click(var2)
	{
		if(this._bSelectable)
		{
			this.setSelectedItem(var2.target.id);
		}
		this.dispatchEvent({type:"selectItem",target:var2.target,owner:this});
	}
	function dblClick(var2)
	{
		var var3 = this.getSelectedItems();
		this.unSelectAll();
		this.dispatchEvent({type:"dblClickItem",target:var2.target,targets:var3,owner:this});
	}
	function onMouseWheel(var2, var3)
	{
		if(dofus.graphics.gapi.ui.Zoom.isZooming())
		{
			return undefined;
		}
		if(String(var3._target).indexOf(this._target) != -1)
		{
			this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - (var2 <= 0?-1:1);
		}
	}
}
