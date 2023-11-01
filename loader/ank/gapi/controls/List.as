class ank.gapi.controls.List extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "List";
	var _aRows = new Array();
	var _nRowHeight = 20;
	var _bInvalidateLayout = true;
	var _bInvalidateScrollBar = true;
	var _nScrollPosition = 0;
	var _sCellRenderer = "DefaultCellRenderer";
	var _bMultipleSelection = false;
	var _bAutoScroll = false;
	var _bDblClickEnabled = false;
	function List()
	{
		super();
	}
	function __set__multipleSelection(var2)
	{
		this._bMultipleSelection = var2;
		return this.__get__multipleSelection();
	}
	function __get__multipleSelection()
	{
		return this._bMultipleSelection;
	}
	function __set__rowHeight(var2)
	{
		if(var2 == 0)
		{
			return undefined;
		}
		this._nRowHeight = var2;
		return this.__get__rowHeight();
	}
	function __get__rowHeight()
	{
		return this._nRowHeight;
	}
	function __set__cellRenderer(var2)
	{
		if(var2 != undefined)
		{
			this._sCellRenderer = var2;
		}
		return this.__get__cellRenderer();
	}
	function __get__cellRenderer()
	{
		return this._sCellRenderer;
	}
	function __set__dataProvider(var2)
	{
		delete this._nSelectedIndex;
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		var var3 = Math.ceil(this.__height / this._nRowHeight);
		if(var2.length <= var3)
		{
			this.setVPosition(0);
		}
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._eaDataProvider;
	}
	function __set__selectedIndex(var2)
	{
		var var3 = this._mcContent["row" + var2];
		this._nSelectedIndex = var2;
		this.layoutSelection(var2,var3);
		return this.__get__selectedIndex();
	}
	function __get__selectedIndex()
	{
		return this._nSelectedIndex;
	}
	function __get__selectedItem()
	{
		return this._eaDataProvider[this._nSelectedIndex];
	}
	function __set__autoScroll(var2)
	{
		this._bAutoScroll = var2;
		return this.__get__autoScroll();
	}
	function __get__autoScroll()
	{
		return this._bAutoScroll;
	}
	function __set__dblClickEnabled(var2)
	{
		this._bDblClickEnabled = var2;
		return this.__get__dblClickEnabled();
	}
	function __get__dblClickEnabled()
	{
		return this._bDblClickEnabled;
	}
	function addItem(var2)
	{
		this._aRows.push({item:var2,selected:false});
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function addItemAt(var2, var3)
	{
		this._aRows.splice(var3,0,{item:var2,selected:false});
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function removeItemAt(var2, var3)
	{
		this._aRows.splice(var3,1);
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function removeAll()
	{
		this._aRows = new Array();
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function setVPosition(var2, var3)
	{
		var var4 = this._eaDataProvider.length - Math.floor(this.__height / this._nRowHeight);
		if(var2 > var4)
		{
			var2 = var4;
		}
		if(var2 < 0)
		{
			var2 = 0;
		}
		if(this._nScrollPosition != var2 || var3)
		{
			this._nScrollPosition = var2;
			this.setScrollBarProperties(var3 == true);
			this.layoutContent();
		}
	}
	function sortOn(var2, var3)
	{
		this._eaDataProvider.sortOn(var2,var3);
		this.modelChanged();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.List.CLASS_NAME);
	}
	function createChildren()
	{
		this.attachMovie("ScrollBar","_sbVertical",10,{styleName:this.styleName});
		this._sbVertical.addEventListener("scroll",this);
		this.createEmptyMovieClip("_mcContent",20);
		this.createEmptyMovieClip("_mcMask",30);
		this.drawRoundRect(this._mcMask,0,0,100,100,0,16711680);
		this._mcContent.setMask(this._mcMask);
		ank.utils.MouseEvents.addListener(this);
	}
	function size()
	{
		super.size();
		this._bInvalidateScrollBar = true;
		this.arrange();
		if(this.initialized)
		{
			this.setVPosition(this._nScrollPosition,true);
		}
	}
	function draw()
	{
		if(this.styleName == "none")
		{
			return undefined;
		}
		var var2 = this.getStyle();
		for(var k in this._mcContent)
		{
			this._mcContent[k].styleName = this.styleName;
		}
		this._sbVertical.styleName = var2.scrollbarstyle;
	}
	function arrange()
	{
		if(this._bInvalidateScrollBar)
		{
			this.setScrollBarProperties(false);
		}
		if(this._sbVertical._visible)
		{
			this._sbVertical.setSize(this.__height);
			this._sbVertical._x = this.__width - this._sbVertical.width;
			this._sbVertical._y = 0;
		}
		this._nMaskWidth = !this._sbVertical._visible?this.__width:this.__width - this._sbVertical.width;
		this._mcMask._width = this._nMaskWidth;
		this._mcMask._height = this.__height;
		this._bInvalidateLayout = true;
		this.layoutContent();
	}
	function layoutContent()
	{
		var var2 = Math.ceil(this.__height / this._nRowHeight);
		var var3 = 0;
		while(var3 < var2)
		{
			var var4 = this._mcContent["row" + var3];
			if(var4 == undefined)
			{
				var4 = (ank.gapi.controls.list.SelectableRow)this._mcContent.attachMovie("SelectableRow","row" + var3,var3,{_x:0,_y:var3 * this._nRowHeight,index:var3,styleName:this.styleName,enabled:this._bEnabled,gapi:this.gapi});
				var4.setCellRenderer(this._sCellRenderer);
				var4.addEventListener("itemSelected",this);
				var4.addEventListener("itemdblClick",this);
				var4.addEventListener("itemRollOver",this);
				var4.addEventListener("itemRollOut",this);
				var4.addEventListener("itemDrag",this);
				var4.addEventListener("itemDrop",this);
			}
			var var5 = var3 + this._nScrollPosition;
			if(this._bInvalidateLayout)
			{
				var4.setSize(this._nMaskWidth,this._nRowHeight);
			}
			var var6 = this._aRows[var5];
			var var7 = var6.item;
			var var8 = typeof var7 != "string"?var7.label:var7;
			var var9 = !((var6.selected || var5 == this._nSelectedIndex) && var7 != undefined)?"normal":"selected";
			var4.setValue(var8,var7,var9);
			var4.itemIndex = var5;
			var3 = var3 + 1;
		}
		this._bInvalidateLayout = false;
	}
	function addScrollBar(var2)
	{
		if(!this._sbVertical._visible)
		{
			this._sbVertical._visible = true;
			if(var2)
			{
				this.arrange();
			}
		}
	}
	function removeScrollBar(var2)
	{
		if(this._sbVertical._visible)
		{
			this._sbVertical._visible = false;
			if(var2)
			{
				this.arrange();
			}
		}
	}
	function setScrollBarProperties(var2)
	{
		this._bInvalidateScrollBar = false;
		var var3 = Math.floor(this.__height / this._nRowHeight);
		var var4 = this._aRows.length - var3;
		var var5 = var3 * (var4 / this._aRows.length);
		if(var3 >= this._aRows.length || this._aRows.length == 0)
		{
			this.removeScrollBar(var2);
		}
		else
		{
			this.addScrollBar(var2);
			this._sbVertical.setScrollProperties(var5,0,var4);
			this._sbVertical.scrollPosition = this._nScrollPosition;
		}
	}
	function layoutSelection(var2, var3, var4)
	{
		if(var4 == undefined)
		{
			var4 = false;
		}
		if(var2 == undefined)
		{
			var2 = this._nSelectedIndex;
		}
		var var5 = this._aRows[var2];
		var var6 = this._bMultipleSelection && Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY);
		if(!var6)
		{
			this.unSelectAll();
		}
		if(var5.selected && (var6 && !var4))
		{
			var5.selected = false;
			var3.setState("normal");
		}
		else if(!var5.selected)
		{
			var5.selected = true;
			var3.setState("selected");
		}
	}
	function getSelectedItems()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < this._aRows.length)
		{
			if(this._aRows[var3].selected)
			{
				var var4 = this._aRows[var3].item;
				var2.push(var4);
			}
			var3 = var3 + 1;
		}
		var2.reverse();
		return var2;
	}
	function unSelectAll()
	{
		var var2 = 0;
		while(var2 < this._aRows.length)
		{
			if(this._aRows[var2].selected)
			{
				this._aRows[var2].selected = false;
				this._mcContent["row" + (var2 - this._nScrollPosition)].setState("normal");
			}
			var2 = var2 + 1;
		}
	}
	function modelChanged()
	{
		this.selectedIndex = -1;
		this._aRows = new Array();
		var var2 = this._eaDataProvider.length;
		var var3 = 0;
		while(var3 < var2)
		{
			this._aRows[var3] = {item:this._eaDataProvider[var3],selected:false};
			var3 = var3 + 1;
		}
		if(this._bAutoScroll)
		{
			this.setVPosition(var2,true);
		}
		else
		{
			this.setScrollBarProperties(true);
			this.layoutContent();
		}
	}
	function scroll(var2)
	{
		this.setVPosition(var2.target.scrollPosition);
	}
	function itemSelected(var2)
	{
		var var3 = var2.target.itemIndex;
		var var4 = var2.target;
		this._nSelectedIndex = var3;
		this.layoutSelection(var3,var4);
		this.dispatchEvent({type:"itemSelected",row:var2.target,targets:this.getSelectedItems()});
	}
	function itemdblClick(var2)
	{
		var var3 = var2.target.itemIndex;
		var var4 = var2.target;
		this._nSelectedIndex = var3;
		this.layoutSelection(var3,var4);
		this.dispatchEvent({type:"itemdblClick",row:var2.target,targets:this.getSelectedItems()});
	}
	function itemRollOver(var2)
	{
		var var3 = this._bMultipleSelection && (Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY) && Key.isDown(Key.SHIFT));
		if(var3)
		{
			var var4 = var2.target.itemIndex;
			var var5 = var2.target;
			this.layoutSelection(var4,var5,true);
		}
		this.dispatchEvent({type:"itemRollOver",row:var2.target,targets:this.getSelectedItems()});
	}
	function itemRollOut(var2)
	{
		this.dispatchEvent({type:"itemRollOut",row:var2.target,targets:this.getSelectedItems()});
	}
	function itemDrag(var2)
	{
		this.dispatchEvent({type:"itemDrag",row:var2.target});
	}
	function itemDrop(var2)
	{
		this.dispatchEvent({type:"itemDrop",row:var2.target});
	}
	function onMouseWheel(var2, var3)
	{
		if(dofus.graphics.gapi.ui.Zoom.isZooming())
		{
			return undefined;
		}
		if(String(var3._target).indexOf(this._target) != -1)
		{
			this.setVPosition(this._nScrollPosition - var2);
		}
	}
}
