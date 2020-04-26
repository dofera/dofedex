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
	function __set__multipleSelection(loc2)
	{
		this._bMultipleSelection = loc2;
		return this.__get__multipleSelection();
	}
	function __get__multipleSelection()
	{
		return this._bMultipleSelection;
	}
	function __set__rowHeight(loc2)
	{
		if(loc2 == 0)
		{
			return undefined;
		}
		this._nRowHeight = loc2;
		return this.__get__rowHeight();
	}
	function __get__rowHeight()
	{
		return this._nRowHeight;
	}
	function __set__cellRenderer(loc2)
	{
		if(loc2 != undefined)
		{
			this._sCellRenderer = loc2;
		}
		return this.__get__cellRenderer();
	}
	function __get__cellRenderer()
	{
		return this._sCellRenderer;
	}
	function __set__dataProvider(loc2)
	{
		delete this._nSelectedIndex;
		this._eaDataProvider = loc2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		var loc3 = Math.ceil(this.__height / this._nRowHeight);
		if(loc2.length <= loc3)
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
	function __set__selectedIndex(loc2)
	{
		var loc3 = this._mcContent["row" + loc2];
		this._nSelectedIndex = loc2;
		this.layoutSelection(loc2,loc3);
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
	function __set__autoScroll(loc2)
	{
		this._bAutoScroll = loc2;
		return this.__get__autoScroll();
	}
	function __get__autoScroll()
	{
		return this._bAutoScroll;
	}
	function __set__dblClickEnabled(loc2)
	{
		this._bDblClickEnabled = loc2;
		return this.__get__dblClickEnabled();
	}
	function __get__dblClickEnabled()
	{
		return this._bDblClickEnabled;
	}
	function addItem(loc2)
	{
		this._aRows.push({item:loc2,selected:false});
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function addItemAt(loc2, loc3)
	{
		this._aRows.splice(loc3,0,{item:loc2,selected:false});
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function removeItemAt(loc2, loc3)
	{
		this._aRows.splice(loc3,1);
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function removeAll()
	{
		this._aRows = new Array();
		this.setScrollBarProperties(true);
		this.layoutContent();
	}
	function setVPosition(loc2, loc3)
	{
		var loc4 = this._eaDataProvider.length - Math.floor(this.__height / this._nRowHeight);
		if(loc2 > loc4)
		{
			loc2 = loc4;
		}
		if(loc2 < 0)
		{
			loc2 = 0;
		}
		if(this._nScrollPosition != loc2 || loc3)
		{
			this._nScrollPosition = loc2;
			this.setScrollBarProperties(loc3 == true);
			this.layoutContent();
		}
	}
	function sortOn(loc2, loc3)
	{
		this._eaDataProvider.sortOn(loc2,loc3);
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
		var loc2 = this.getStyle();
		for(this._mcContent[k].styleName in this._mcContent)
		{
		}
		this._sbVertical.styleName = loc2.scrollbarstyle;
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
		var loc2 = Math.ceil(this.__height / this._nRowHeight);
		var loc3 = 0;
		while(loc3 < loc2)
		{
			var loc4 = this._mcContent["row" + loc3];
			if(loc4 == undefined)
			{
				loc4 = (ank.gapi.controls.list.SelectableRow)this._mcContent.attachMovie("SelectableRow","row" + loc3,loc3,{_x:0,_y:loc3 * this._nRowHeight,index:loc3,styleName:this.styleName,enabled:this._bEnabled,gapi:this.gapi});
				loc4.setCellRenderer(this._sCellRenderer);
				loc4.addEventListener("itemSelected",this);
				loc4.addEventListener("itemdblClick",this);
				loc4.addEventListener("itemRollOver",this);
				loc4.addEventListener("itemRollOut",this);
				loc4.addEventListener("itemDrag",this);
				loc4.addEventListener("itemDrop",this);
			}
			var loc5 = loc3 + this._nScrollPosition;
			if(this._bInvalidateLayout)
			{
				loc4.setSize(this._nMaskWidth,this._nRowHeight);
			}
			var loc6 = this._aRows[loc5];
			var loc7 = loc6.item;
			var loc8 = typeof loc7 != "string"?loc7.label:loc7;
			var loc9 = !((loc6.selected || loc5 == this._nSelectedIndex) && loc7 != undefined)?"normal":"selected";
			loc4.setValue(loc8,loc7,loc9);
			loc4.itemIndex = loc5;
			loc3 = loc3 + 1;
		}
		this._bInvalidateLayout = false;
	}
	function addScrollBar(loc2)
	{
		if(!this._sbVertical._visible)
		{
			this._sbVertical._visible = true;
			if(loc2)
			{
				this.arrange();
			}
		}
	}
	function removeScrollBar(loc2)
	{
		if(this._sbVertical._visible)
		{
			this._sbVertical._visible = false;
			if(loc2)
			{
				this.arrange();
			}
		}
	}
	function setScrollBarProperties(loc2)
	{
		this._bInvalidateScrollBar = false;
		var loc3 = Math.floor(this.__height / this._nRowHeight);
		var loc4 = this._aRows.length - loc3;
		var loc5 = loc3 * (loc4 / this._aRows.length);
		if(loc3 >= this._aRows.length || this._aRows.length == 0)
		{
			this.removeScrollBar(loc2);
		}
		else
		{
			this.addScrollBar(loc2);
			this._sbVertical.setScrollProperties(loc5,0,loc4);
			this._sbVertical.scrollPosition = this._nScrollPosition;
		}
	}
	function layoutSelection(loc2, loc3)
	{
		if(loc2 == undefined)
		{
			loc2 = this._nSelectedIndex;
		}
		var loc4 = this._aRows[loc2];
		var loc5 = this._aRows[loc2].selected;
		if(!this._bMultipleSelection)
		{
			var loc6 = this._aRows.length;
			while((loc6 = loc6 - 1) >= 0)
			{
				if(this._aRows[loc6].selected)
				{
					this._aRows[loc6].selected = false;
					this._mcContent["row" + (loc6 - this._nScrollPosition)].setState("normal");
				}
			}
		}
		if(loc5 && this._bMultipleSelection)
		{
			loc4.selected = false;
			loc3.setState("normal");
		}
		else
		{
			loc4.selected = true;
			loc3.setState("selected");
		}
	}
	function modelChanged()
	{
		this.selectedIndex = -1;
		this._aRows = new Array();
		var loc2 = this._eaDataProvider.length;
		var loc3 = 0;
		while(loc3 < loc2)
		{
			this._aRows[loc3] = {item:this._eaDataProvider[loc3],selected:false};
			loc3 = loc3 + 1;
		}
		if(this._bAutoScroll)
		{
			this.setVPosition(loc2,true);
		}
		else
		{
			this.setScrollBarProperties(true);
			this.layoutContent();
		}
	}
	function scroll(loc2)
	{
		this.setVPosition(loc2.target.scrollPosition);
	}
	function itemSelected(loc2)
	{
		var loc3 = loc2.target.itemIndex;
		var loc4 = loc2.target;
		this._nSelectedIndex = loc3;
		this.layoutSelection(loc3,loc4);
		this.dispatchEvent({type:"itemSelected",row:loc2.target});
	}
	function itemdblClick(loc2)
	{
		var loc3 = loc2.target.itemIndex;
		var loc4 = loc2.target;
		this._nSelectedIndex = loc3;
		this.layoutSelection(loc3,loc4);
		this.dispatchEvent({type:"itemdblClick",row:loc2.target});
	}
	function itemRollOver(loc2)
	{
		this.dispatchEvent({type:"itemRollOver",row:loc2.target});
	}
	function itemRollOut(loc2)
	{
		this.dispatchEvent({type:"itemRollOut",row:loc2.target});
	}
	function itemDrag(loc2)
	{
		this.dispatchEvent({type:"itemDrag",row:loc2.target});
	}
	function itemDrop(loc2)
	{
		this.dispatchEvent({type:"itemDrop",row:loc2.target});
	}
	function onMouseWheel(loc2, loc3)
	{
		if(String(loc3._target).indexOf(this._target) != -1)
		{
			this.setVPosition(this._nScrollPosition - loc2);
		}
	}
}
