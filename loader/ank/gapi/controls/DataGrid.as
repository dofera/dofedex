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
	function __set__titleHeight(var2)
	{
		this._nTitleHeight = var2;
		return this.__get__titleHeight();
	}
	function __get__titleHeight()
	{
		return this._nTitleHeight;
	}
	function __set__columnsWidths(var2)
	{
		this._aColumnsWidths = var2;
		return this.__get__columnsWidths();
	}
	function __get__columnsWidths()
	{
		return this._aColumnsWidths;
	}
	function __set__columnsNames(var2)
	{
		this._aColumnsNames = var2;
		this.setLabels();
		return this.__get__columnsNames();
	}
	function __get__columnsNames()
	{
		return this._aColumnsNames;
	}
	function __set__columnsProperties(var2)
	{
		this._aColumnsProperties = var2;
		return this.__get__columnsProperties();
	}
	function __get__columnsProperties()
	{
		return this._aColumnsProperties;
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
		this._sCellRenderer = var2;
		return this.__get__cellRenderer();
	}
	function __get__cellRenderer()
	{
		return this._sCellRenderer;
	}
	function __set__dataProvider(var2)
	{
		this._lstList.dataProvider = var2;
		return this.__get__dataProvider();
	}
	function __get__dataProvider()
	{
		return this._lstList.dataProvider;
	}
	function __set__selectedIndex(var2)
	{
		this._lstList.selectedIndex = var2;
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
	function addItem(var2)
	{
		this._lstList.addItem(var2);
	}
	function addItemAt(var2, var3)
	{
		this._lstList.addItemAt(var2,var3);
	}
	function removeItemAt(var2, var3)
	{
		this._lstList.removeItemAt(var2,var3);
	}
	function removeAll()
	{
		this._lstList.removeAll();
	}
	function setVPosition(var2)
	{
		this._lstList.setVPosition(var2);
	}
	function sortOn(var2, var3)
	{
		this._lstList.selectedIndex = -1;
		this._lstList.sortOn(var2,var3);
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
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._aColumnsWidths.length)
		{
			var var4 = var2 + this._aColumnsWidths[var3] >= this.__width?this.__width - var2:this._aColumnsWidths[var3];
			if(this._aColumnsProperties[var3] != undefined)
			{
				var var5 = this.attachMovie("Button","_btnTitle" + var3,this.getNextHighestDepth(),{_x:var2,styleName:"none",label:"",backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",toggle:true,params:{index:var3}});
				var5.setSize(var4,this._nTitleHeight);
				var5.addEventListener("click",this);
			}
			this["_lblTitle" + var3].removeMovieClip();
			var var6 = this.attachMovie("Label","_lblTitle" + var3,this.getNextHighestDepth(),{_x:var2,styleName:this.getStyle().labelstyle,text:this._aColumnsNames[var3]});
			var6.setSize(var4,this._nTitleHeight);
			var2 = var2 + var4;
			var3 = var3 + 1;
		}
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._lstList.styleName = var2.liststyle;
		if(this.initialized)
		{
			var var3 = this.getStyle().labelstyle;
			var var4 = 0;
			while(var4 < this._aColumnsWidths.length)
			{
				this["_lblTitle" + var4].styleName = var3;
				var4 = var4 + 1;
			}
		}
		this.drawRoundRect(this._mcTitle,0,0,1,1,0,var2.titlebgcolor);
		this._mcTitle._alpha = var2.titlebgcolor != -1?100:0;
	}
	function setLabels()
	{
		if(this.initialized)
		{
			var var2 = 0;
			while(var2 < this._aColumnsWidths.length)
			{
				this["_lblTitle" + var2].text = this._aColumnsNames[var2];
				var2 = var2 + 1;
			}
		}
	}
	function click(var2)
	{
		var var3 = var2.target.params.index;
		var var4 = this._aColumnsProperties[var3];
		var var5 = !var2.target.selected?Array.CASEINSENSITIVE | Array.DESCENDING:Array.CASEINSENSITIVE;
		if(!_global.isNaN(Number(this._lstList.dataProvider[0][var4])))
		{
			var5 = var5 | Array.NUMERIC;
		}
		this.sortOn(var4,var5);
	}
	function itemSelected(var2)
	{
		var2.list = var2.target;
		var2.target = this;
		this.dispatchEvent(var2);
	}
	function itemRollOver(var2)
	{
		this.dispatchEvent(var2);
	}
	function itemRollOut(var2)
	{
		this.dispatchEvent(var2);
	}
	function itemDrag(var2)
	{
		this.dispatchEvent(var2);
	}
	function itemdblClick(var2)
	{
		this.dispatchEvent(var2);
	}
}
