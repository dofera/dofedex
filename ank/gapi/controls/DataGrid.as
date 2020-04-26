class ank.gapi.controls.DataGrid extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "DataGrid";
	var _nRowHeight = 20;
	var _nTitleHeight = 20;
	var _sCellRenderer = "DefaultCellRenderer";
	var _bMultipleSelection = false;
	function DataGrid()
	{
		super();
	}
	function __set__titleHeight(loc2)
	{
		this._nTitleHeight = loc2;
		return this.__get__titleHeight();
	}
	function __get__titleHeight()
	{
		return this._nTitleHeight;
	}
	function __set__columnsWidths(loc2)
	{
		this._aColumnsWidths = loc2;
		return this.__get__columnsWidths();
	}
	function __get__columnsWidths()
	{
		return this._aColumnsWidths;
	}
	function __set__columnsNames(loc2)
	{
		this._aColumnsNames = loc2;
		this.setLabels();
		return this.__get__columnsNames();
	}
	function __get__columnsNames()
	{
		return this._aColumnsNames;
	}
	function __set__columnsProperties(loc2)
	{
		this._aColumnsProperties = loc2;
		return this.__get__columnsProperties();
	}
	function __get__columnsProperties()
	{
		return this._aColumnsProperties;
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
		this._sCellRenderer = loc2;
		return this.__get__cellRenderer();
	}
	function __get__cellRenderer()
	{
		return this._sCellRenderer;
	}
	function __set__dataProvider(loc2)
	{
		this._lstList.dataProvider = loc2;
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._lstList.dataProvider;
	}
	function __set__selectedIndex(loc2)
	{
		this._lstList.selectedIndex = loc2;
		return this.__get__selectedIndex();
	}
	function __get__selectedIndex()
	{
		return this._lstList.selectedIndex;
	}
	function __get__selectedItem()
	{
		return this._lstList.selectedItem;
	}
	function addItem(loc2)
	{
		this._lstList.addItem(loc2);
	}
	function addItemAt(loc2, loc3)
	{
		this._lstList.addItemAt(loc2,loc3);
	}
	function removeItemAt(loc2, loc3)
	{
		this._lstList.removeItemAt(loc2,loc3);
	}
	function removeAll()
	{
		this._lstList.removeAll();
	}
	function setVPosition(loc2)
	{
		this._lstList.setVPosition(loc2);
	}
	function sortOn(loc2, loc3)
	{
		this._lstList.selectedIndex = -1;
		this._lstList.sortOn(loc2,loc3);
	}
	function init()
	{
		super.init(false,ank.gapi.controls.DataGrid.CLASS_NAME);
	}
	function createChildren()
	{
		this.attachMovie("List","_lstList",10,{styleName:"none",multipleSelection:this._bMultipleSelection,rowHeight:this._nRowHeight,cellRenderer:this._sCellRenderer,enabled:this.enabled});
		this._lstList.addEventListener("itemSelected",this);
		this._lstList.addEventListener("itemdblClick",this);
		this._lstList.addEventListener("itemRollOver",this);
		this._lstList.addEventListener("itemRollOut",this);
		this._lstList.addEventListener("itemDrag",this);
		this.createEmptyMovieClip("_mcTitle",20);
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._lstList._y = this._nTitleHeight;
		this._lstList.setSize(this.__width,this.__height - this._nTitleHeight);
		this._mcTitle._width = this.__width;
		this._mcTitle._height = this._nTitleHeight;
		var loc2 = 0;
		var loc3 = 0;
		while(loc3 < this._aColumnsWidths.length)
		{
			var loc4 = loc2 + this._aColumnsWidths[loc3] >= this.__width?this.__width - loc2:this._aColumnsWidths[loc3];
			if(this._aColumnsProperties[loc3] != undefined)
			{
				var loc5 = this.attachMovie("Button","_btnTitle" + loc3,this.getNextHighestDepth(),{_x:loc2,styleName:"none",label:"",backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",toggle:true,params:{index:loc3}});
				loc5.setSize(loc4,this._nTitleHeight);
				loc5.addEventListener("click",this);
			}
			this["_lblTitle" + loc3].removeMovieClip();
			var loc6 = this.attachMovie("Label","_lblTitle" + loc3,this.getNextHighestDepth(),{_x:loc2,styleName:this.getStyle().labelstyle,text:this._aColumnsNames[loc3]});
			loc6.setSize(loc4,this._nTitleHeight);
			loc2 = loc2 + loc4;
			loc3 = loc3 + 1;
		}
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this._lstList.styleName = loc2.liststyle;
		if(this.initialized)
		{
			var loc3 = this.getStyle().labelstyle;
			var loc4 = 0;
			while(loc4 < this._aColumnsWidths.length)
			{
				this["_lblTitle" + loc4].styleName = loc3;
				loc4 = loc4 + 1;
			}
		}
		this.drawRoundRect(this._mcTitle,0,0,1,1,0,loc2.titlebgcolor);
		this._mcTitle._alpha = loc2.titlebgcolor != -1?100:0;
	}
	function setLabels()
	{
		if(this.initialized)
		{
			var loc2 = 0;
			while(loc2 < this._aColumnsWidths.length)
			{
				this["_lblTitle" + loc2].text = this._aColumnsNames[loc2];
				loc2 = loc2 + 1;
			}
		}
	}
	function click(loc2)
	{
		var loc3 = loc2.target.params.index;
		var loc4 = this._aColumnsProperties[loc3];
		var loc5 = !loc2.target.selected?Array.CASEINSENSITIVE | Array.DESCENDING:Array.CASEINSENSITIVE;
		if(!_global.isNaN(Number(this._lstList.dataProvider[0][loc4])))
		{
			loc5 = loc5 | Array.NUMERIC;
		}
		this.sortOn(loc4,loc5);
	}
	function itemSelected(loc2)
	{
		loc2.list = loc2.target;
		loc2.target = this;
		this.dispatchEvent(loc2);
	}
	function itemRollOver(loc2)
	{
		this.dispatchEvent(loc2);
	}
	function itemRollOut(loc2)
	{
		this.dispatchEvent(loc2);
	}
	function itemDrag(loc2)
	{
		this.dispatchEvent(loc2);
	}
	function itemdblClick(loc2)
	{
		this.dispatchEvent(loc2);
	}
}
